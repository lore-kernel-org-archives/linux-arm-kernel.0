From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 17:11:00 -0700
Subject: [PATCH 03/10] ARM: tegra: Add MIPI calibration DT entries for
 Tegra114
In-Reply-To: <1387468774-14216-4-git-send-email-treding@nvidia.com>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
 <1387468774-14216-4-git-send-email-treding@nvidia.com>
Message-ID: <52B38B14.8080605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 08:59 AM, Thierry Reding wrote:
> Add a device node for the MIPI calibration block on Tegra114. There is
> no need to disable it by default because it only enables the clock while
> performing calibration and therefore shouldn't be consuming any power
> when unused.

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +	mipi: mipi {

That should be:

	mipi: mipi at 700e3000 {

I fixed it up for you.
