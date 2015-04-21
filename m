From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Apr 2015 09:03:25 +0200
Subject: [PATCH] ARM: sunxi: Enable simplefb in the defconfig
In-Reply-To: <1429559320-27519-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1429559320-27519-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5535F63D.8080304@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-04-15 21:48, Maxime Ripard wrote:
> Now that we have simplefb support, we can enable it in our defconfig. Also
> enable the framebuffer console, so that we are sure that we actually get
> something displayed in any case.
>
> And while we're at it, enable the module support.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Makes sense:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   arch/arm/configs/sunxi_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index 2c7af0a57cb1..7ebc346bf9fa 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -2,6 +2,7 @@ CONFIG_NO_HZ=y
>   CONFIG_HIGH_RES_TIMERS=y
>   CONFIG_BLK_DEV_INITRD=y
>   CONFIG_PERF_EVENTS=y
> +CONFIG_MODULES=y
>   CONFIG_ARCH_SUNXI=y
>   CONFIG_SMP=y
>   CONFIG_NR_CPUS=8
> @@ -86,6 +87,10 @@ CONFIG_REGULATOR=y
>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
>   CONFIG_REGULATOR_AXP20X=y
>   CONFIG_REGULATOR_GPIO=y
> +CONFIG_FB=y
> +CONFIG_FB_SIMPLE=y
> +CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_HCD_PLATFORM=y
>
