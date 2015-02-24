From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 24 Feb 2015 08:08:35 -0700
Subject: [PATCH] ARM: vexpress: update CONFIG_USB_ISP1760 option
In-Reply-To: <1424790150-8450-1-git-send-email-sudeep.holla@arm.com>
References: <1424790150-8450-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CANLsYkySc5yDjozMRHB4V5qT_8B5W+swt5Gv--KvgQngiQAvCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2015 at 08:02, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Commt 7ef077a8ad35 ("usb: isp1760: Move driver from drivers/usb/host/
> to drivers/usb/isp1760/") moved the isp1760 driver and changed the
> Kconfig option. This makes CONFIG_USB_ISP1760_HCD not selectable
> directly anymore. This results in driver being not compiled in when
> using vexpress_defconfig and the USB is non-functional.
>
> This patch updates the CONFIG_USB_ISP1760_HCD to CONFIG_USB_ISP1760 to
> get back USB functional on vexpress platforms.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/configs/vexpress_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> index f489fdaa19b8..37fe607a4ede 100644
> --- a/arch/arm/configs/vexpress_defconfig
> +++ b/arch/arm/configs/vexpress_defconfig
> @@ -118,8 +118,8 @@ CONFIG_HID_ZEROPLUS=y
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_MON=y
> -CONFIG_USB_ISP1760_HCD=y
>  CONFIG_USB_STORAGE=y
> +CONFIG_USB_ISP1760=y
>  CONFIG_MMC=y
>  CONFIG_MMC_ARMMMCI=y
>  CONFIG_NEW_LEDS=y
> --
> 1.9.1

I tested this change and confirm that it does indeed re-activate USB
functionality.

Mathieu

>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
