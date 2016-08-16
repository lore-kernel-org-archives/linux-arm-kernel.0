From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Aug 2016 11:09:40 +0800
Subject: [PATCH] ARM: sun5i: Fix typo in trip point temperature
In-Reply-To: <6c422122-e83d-84e7-f330-0b747f06d51f@bonstra.fr.eu.org>
References: <6c422122-e83d-84e7-f330-0b747f06d51f@bonstra.fr.eu.org>
Message-ID: <CAGb2v66LpeEHveJFbkwHh1gW=qKUZ91=b4N5dNZt=o2Bx_5ieg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jul 30, 2016 at 9:17 PM, Hugo Grostabussiat
<bonstra@bonstra.fr.eu.org> wrote:
> Set cpu_alert0 temperature to 85?C instead of 850?C.
>

Please add:

Fixes: 32a5d2d170cc ("ARM: dts: sun5i: Add cpu thermal zones to dtsi")

And you should send it to the proper maintainers, lest it get missed.

> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  arch/arm/boot/dts/sun5i-a13.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi
> b/arch/arm/boot/dts/sun5i-a13.dtsi
> index 263d46d..2d78eee 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -84,7 +84,7 @@
>                         trips {
>                                 cpu_alert0: cpu_alert0 {
>                                         /* milliCelsius */
> -                                       temperature = <850000>;
> +                                       temperature = <85000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
>                                 };
> --
> 2.9.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
