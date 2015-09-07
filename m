From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 07 Sep 2015 09:02:23 +0900
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable DW USB2 support and
 rockchip phy
In-Reply-To: <1441570566-14001-5-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441570566-14001-5-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <55ECD40F.8020001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.09.2015 05:16, Sjoerd Simons wrote:
> The DesignWare HS OTG USB 2.0 is used in various SoC families among wich
> the various rockchip SoCs, enable the driver and the PHY glue for
> rockchip
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index fb673e2..49c733a 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -514,6 +514,7 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_DWC2=y

+Cc Marek and Kukjin,

This would conflict with Marek's:
[PATCH v2] ARM: multi_v7_defconfig: Enable DWC2 USB driver and USB
ethernet gadget
http://www.spinics.net/lists/linux-samsung-soc/msg46743.html

Probably your series and Marek's change should go together to the same
tree. How about rebasing your work on top of it?

Best regards,
Krzysztof

>  CONFIG_AB8500_USB=y
>  CONFIG_KEYSTONE_USB_PHY=y
>  CONFIG_OMAP_USB3=y
> @@ -658,6 +659,7 @@ CONFIG_PHY_HIX5HD2_SATA=y
>  CONFIG_PWM_STI=m
>  CONFIG_OMAP_USB2=y
>  CONFIG_TI_PIPE3=y
> +CONFIG_PHY_ROCKCHIP_USB=y
>  CONFIG_PHY_MIPHY28LP=y
>  CONFIG_PHY_MIPHY365X=y
>  CONFIG_PHY_RCAR_GEN2=m
> 
