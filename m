From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Apr 2014 12:18:17 -0600
Subject: [PATCH 7/7] ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
In-Reply-To: <1397757570-19750-8-git-send-email-dianders@chromium.org>
References: <1397757570-19750-1-git-send-email-dianders@chromium.org>
 <1397757570-19750-8-git-send-email-dianders@chromium.org>
Message-ID: <535560E9.5040108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 11:59 AM, Doug Anderson wrote:
> This adds the EC i2c tunnel (and devices under it) to the
> tegra124-venice2 device tree.

The series,
Tested-by: Stephen Warren <swarren@nvidia.com>

I can apply this one patch once the other patches in the series are
acked or applied (in order to make sure the DT binding is acceptable to
others).

I guess I'll send separate patches for tegra_defconfig and
multi_v7_defconfig to add the required options once I've applied this,
unless you beat me to it.

> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts

>  	aliases {
> +		i2c20 = "/spi at 0,7000d400/cros-ec at 0/i2c-tunnel";

Is that needed? I'd prefer not to add it unless there's a specific
reason. I don't think I2C buses need specific names, do they?
