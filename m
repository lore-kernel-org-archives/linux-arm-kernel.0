From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Oct 2013 17:27:49 -0600
Subject: [PATCH 6/7] ARM: tegra: enable Tegra RTC for Venice2
In-Reply-To: <1381310411-11391-7-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
 <1381310411-11391-7-git-send-email-josephl@nvidia.com>
Message-ID: <5255E675.5040706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 03:20 AM, Joseph Lo wrote:
> Enable the Tegra RTC device on Venice2. It also can be used as a wakeup
> device when platform suspended.

> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts

> +	rtc at 7000e000 {
> +		status = "okay";
> +	};

Does that mean this node has status = "disabled" in tegra124.dtsi? It
shouldn't have, since the RTC doesn't depend on any board-specific HW,
and hence can be enabled by default. We certainly have it enabled by
default on all previous SoCs.

I assume this was caused by one of the commits of yours I already
applied? Let's have a fixup patch to tegra124.dtsi.
