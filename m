From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 11 Jul 2016 09:46:32 +0530
Subject: [PATCH] arm64: defconfig: Enable more IP blocks for Exynos7 and
 Exynos5433
In-Reply-To: <1468009023-25758-1-git-send-email-krzk@kernel.org>
References: <1468009023-25758-1-git-send-email-krzk@kernel.org>
Message-ID: <57831DA0.707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 07/09/2016 01:47 AM, Krzysztof Kozlowski wrote:
> Enable more drivers for IP blocks for existing Exynos7 and upcoming
> Exynos5433:
> 1. SPI,
> 2. Watchdog,
> 3. USB: DWC3, Exynos EHCI and OHCI,
> 4. Exynos ADC,
> 5. Samsung PWM.
>
> These are already used by Exynos7 Espresso board or will be used by
> Exynos5433 based board.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
Thanks for posting this patch.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> ---
>
> If there are no objections, I can take it through Samsung SoC tree.
> ---
>   arch/arm64/configs/defconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c05b8badec2c..fe6d6c34323a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -183,6 +183,7 @@ CONFIG_SPI_ORION=y
>   CONFIG_SPI_PL022=y
>   CONFIG_SPI_QUP=y
>   CONFIG_SPI_SPIDEV=m
> +CONFIG_SPI_S3C64XX=y
>   CONFIG_SPMI=y
>   CONFIG_PINCTRL_SINGLE=y
>   CONFIG_PINCTRL_MSM8916=y
> @@ -202,6 +203,7 @@ CONFIG_THERMAL_EMULATION=y
>   CONFIG_EXYNOS_THERMAL=y
>   CONFIG_WATCHDOG=y
>   CONFIG_RENESAS_WDT=y
> +CONFIG_S3C2410_WATCHDOG=y
>   CONFIG_MFD_SPMI_PMIC=y
>   CONFIG_MFD_SEC_CORE=y
>   CONFIG_MFD_HI655X_PMIC=y
> @@ -221,18 +223,22 @@ CONFIG_SOUND=y
>   CONFIG_SND=y
>   CONFIG_SND_SOC=y
>   CONFIG_SND_SOC_RCAR=y
> +CONFIG_SND_SOC_SAMSUNG=y
>   CONFIG_SND_SOC_AK4613=y
>   CONFIG_USB=y
>   CONFIG_USB_OTG=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_XHCI_RCAR=y
> +CONFIG_USB_EHCI_EXYNOS=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_MSM=y
>   CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_OHCI_EXYNOS=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_HCD_PLATFORM=y
>   CONFIG_USB_STORAGE=y
>   CONFIG_USB_DWC2=y
> +CONFIG_USB_DWC3=y
>   CONFIG_USB_CHIPIDEA=y
>   CONFIG_USB_CHIPIDEA_UDC=y
>   CONFIG_USB_CHIPIDEA_HOST=y
> @@ -304,6 +310,10 @@ CONFIG_PHY_HI6220_USB=y
>   CONFIG_PHY_XGENE=y
>   CONFIG_ARM_SCPI_PROTOCOL=y
>   CONFIG_ACPI=y
> +CONFIG_IIO=y
> +CONFIG_EXYNOS_ADC=y
> +CONFIG_PWM=y
> +CONFIG_PWM_SAMSUNG=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   CONFIG_FANOTIFY=y
>
