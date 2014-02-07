From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Feb 2014 16:34:45 -0700
Subject: [PATCH] ARM: tegra: enable I2C MUX PCA954x
In-Reply-To: <1391806412-8561-1-git-send-email-pengw@nvidia.com>
References: <1391806412-8561-1-git-send-email-pengw@nvidia.com>
Message-ID: <52F56D95.50707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 01:53 PM, Bryan Wu wrote:
> Cardhu has a PCA9546 for I2C bus extension, which connects to 3
> cameras. It's required for Tegra V4L2 soc camera driver and camera
> sensor drivers.

>  arch/arm/boot/dts/tegra30-cardhu.dtsi | 8 ++++++++
>  arch/arm/configs/tegra_defconfig      | 1 +

DT and defconfig changes go into separate branches. Could I get this
split into two patches please?

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi

> +		/* NXP PCA9546 I2C Mux */

That comment isn't useful, since the compatible value below spells out
what the device is.

> +		pca9546 at 70 {

DT nodes should be named after the class/type of device, not the
identify. As such, use "i2cmux at 70".
