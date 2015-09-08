From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 08 Sep 2015 17:11:12 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable USB Video Class support
In-Reply-To: <1441662323-15468-1-git-send-email-javier@osg.samsung.com>
References: <1441662323-15468-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55EE9820.2010202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.09.2015 06:45, Javier Martinez Canillas wrote:
> The Exynos5420 Peach Pit and Exynos5800 Peach Pi boards have a built-in
> Silicon Motion USB UVC WebCam. Enable support for the USB Video Class
> driver and its needed media Kconfig symbols so the camera is supported.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/exynos_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)

The patch itself looks good but now I wonder whether we are not putting
to much stuff built-in. The exynos_defconfig does not replace the
distribution distro. For a fully working board the distro should prepare
it's own config.

I understand that in this case the USB webcams are parts of device (like
on all laptops)... a little bit similar as camera sensors on mobile
phones. Yet on mobile phone usually the camera itself is part of SoC,
only the sensor is external.

Actually what we need is a kind of policy for exynos_defconfig - what
should be inside as built-in and what as module?

Best regards,
Krzysztof


> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 1ff2bfa2e183..62f677f76a0b 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -126,6 +126,10 @@ CONFIG_REGULATOR_S2MPA01=y
>  CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
>  CONFIG_REGULATOR_TPS65090=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_USB_SUPPORT=y
> +CONFIG_USB_VIDEO_CLASS=y
>  CONFIG_DRM=y
>  CONFIG_DRM_NXP_PTN3460=y
>  CONFIG_DRM_PARADE_PS8622=y
> 
