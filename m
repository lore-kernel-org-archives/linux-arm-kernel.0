From: trblinux@gmail.com (Tushar Behera)
Date: Wed, 02 Jul 2014 14:50:24 +0530
Subject: [PATCH v5 14/14] ARM: dts: Add max77802 to exynos5420-peach-pit
 and exynos5800-peach-pi
In-Reply-To: <1403806546-31122-15-git-send-email-javier.martinez@collabora.co.uk>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-15-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <53B3CED8.4020808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2014 11:45 PM, Javier Martinez Canillas wrote:
> Peach pit and pi boards uses a Maxim 77802 power management
> IC to drive regulators and its Real Time Clock. This patch
> adds support for this chip.
> 
> These are the device nodes and pinctrl configuration that
> are present on the Peach pit DeviceTree source file in the
> the Chrome OS kernel 3.8 tree.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---

[ ... ]

> +
> +		regulators {
> +			buck1_reg: BUCK1 {
> +				regulator-name = "vdd_mif";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <12500>;
> +			};

IMO, adding a blank line between sub-nodes would be better.

> +			buck2_reg: BUCK2 {
> +				regulator-name = "vdd_arm_real";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <12500>;
> +			};

[ ... ]

> +			vqmmc_sdcard: ldo4_reg: LDO4 {
> +				regulator-name = "vdd_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +

Blank line, can be removed.

> +			};

[ ... ]
> +			ldo23_reg: LDO23 {
> +				regulator-name = "ld0_23";

ldo_23, 'o' in place of '0'.

Similar comments for peach-pi DTS file.

-- 
Tushar Behera
