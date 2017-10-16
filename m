From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 16 Oct 2017 15:15:21 -0700
Subject: [PATCH] arm64: defconfig: re-enable Qualcomm DB410c USB
In-Reply-To: <20171016142257.12882-1-elder@linaro.org>
References: <20171016142257.12882-1-elder@linaro.org>
Message-ID: <20171016221521.GO1165@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 16 Oct 07:22 PDT 2017, Alex Elder wrote:

> Stephen Boyd reworked some Qualcomm USB code earlier this year.
> The result requires a few different config options to be enabled
> in order for the USB on the DragonBoard 410c to continue working,
> but these were never added to arm64 "defconfig".  As a result, USB
> on that board stopped working during the v4.13-rc1 merge window.
> 
> Re-enable this functionality by setting the needed config options
> in the arm64 "defconfig" file.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 34480e9af2e7..325a9991ab72 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -423,6 +423,7 @@ CONFIG_USB_DWC2=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_UDC=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_CHIPIDEA_ULPI=y
>  CONFIG_USB_ISP1760=y
>  CONFIG_USB_HSIC_USB3503=y
>  CONFIG_NOP_USB_XCEIV=y
> @@ -431,6 +432,7 @@ CONFIG_USB_QCOM_8X16_PHY=y
>  CONFIG_USB_ULPI=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_RENESAS_USBHS_UDC=m
> +CONFIG_USB_ULPI_BUS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_BLOCK_MINORS=32
>  CONFIG_MMC_ARMMMCI=y
> @@ -533,6 +535,7 @@ CONFIG_PWM_SAMSUNG=y
>  CONFIG_PWM_TEGRA=m
>  CONFIG_PHY_RCAR_GEN3_USB2=y
>  CONFIG_PHY_HI6220_USB=y
> +CONFIG_PHY_QCOM_USB_HS=y
>  CONFIG_PHY_SUN4I_USB=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_EMMC=y
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
