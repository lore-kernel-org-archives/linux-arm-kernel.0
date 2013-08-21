From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 21 Aug 2013 11:29:33 -0600
Subject: [PATCH 2/2] ARM: tegra: add Palmas pincontrol to Dalmore device
 tree
In-Reply-To: <1377088461-9499-2-git-send-email-ldewangan@nvidia.com>
References: <1377088461-9499-1-git-send-email-ldewangan@nvidia.com>
 <1377088461-9499-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <5214F8FD.3070003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2013 06:34 AM, Laxman Dewangan wrote:
> Add Palmas pincontrol to Dalmore device tree and make following
> configuration as default:
> - Disable DVFS1 and DVFS2.
> - Set GPIO6 to gpio mode.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

> +			palmas_pinctrl {
> +				compatible = "ti,tps65913-pinctrl";

A node name of "pinmux" would be more appropriate here, since the node
name should represent device type rather than device identity.

Aside from that, the series looks fine, but at this point will have to
wait for 3.13 I think, unless this series has a side-effect of fixing
some bug/regression. Can you please repost once 3.12-rc1 is out?
