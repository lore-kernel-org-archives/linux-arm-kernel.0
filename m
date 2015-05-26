From: k.kozlowski@outlook.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Tue, 26 May 2015 17:08:31 +0900
Subject: [PATCH RESEND] ARM: dts: exynos4412: Enable AX88760 USB hub on
 Origen board
In-Reply-To: <1428944566-17132-1-git-send-email-matthew@mattleach.net>
References: <1428944566-17132-1-git-send-email-matthew@mattleach.net>
Message-ID: <BLU436-SMTP64BEEAC702E695B18320ACE2CC0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-14 2:02 GMT+09:00 Matthew Leach <matthew@mattleach.net>:
> Enable the Origen's usb phy and ohci devices in the device tree.  Also
> add the "samsung,vbus-gpio" property to enable the GPX3(5) gpio pin so
> the AX88760 hub is powered.
>
> Signed-off-by: Matthew Leach <matthew@mattleach.net>
> ---
>  arch/arm/boot/dts/exynos4412-origen.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index bd8b730..c810ca3 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -531,4 +531,19 @@
>                         clock-frequency = <24000000>;
>                 };
>         };
> +
> +       exynos-usbphy at 125B0000 {

Could you use label notation here?
&exynos_usbphy {
...
}

Best regards,
Krzysztof
