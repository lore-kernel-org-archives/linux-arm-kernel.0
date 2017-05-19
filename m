From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 19 May 2017 16:42:03 -0700
Subject: [PATCH] ARM64: defconfig: enable IR core,
 decoders and Meson IR device
In-Reply-To: <1493105980-19724-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Tue, 25 Apr 2017 09:39:40 +0200")
References: <1493105980-19724-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m28tls4do4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch enables the MEDIA Infrared RC Decoders and Meson Infrared
> decoder for ARM64 defconfig.
> These drivers are selected as modules by default.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/configs/defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c021aefa..59c400f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -321,6 +321,11 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
>  CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
>  CONFIG_MEDIA_CONTROLLER=y
> +CONFIG_MEDIA_RC_SUPPORT=y
> +CONFIG_RC_CORE=y

This one should be a module too.

With that fixed, applied to v4.13/defconfig

Kevin

> +CONFIG_RC_DEVICES=y
> +CONFIG_RC_DECODERS=y
> +CONFIG_IR_MESON=m
>  CONFIG_VIDEO_V4L2_SUBDEV_API=y
>  # CONFIG_DVB_NET is not set
>  CONFIG_V4L_MEM2MEM_DRIVERS=y
