From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 27 Aug 2012 12:51:27 +0300
Subject: [PATCH] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <201208271144.03681.heiko@sntech.de>
References: <201208252353.59345.heiko@sntech.de>
 <201208271001.05026.heiko@sntech.de>
 <CA+E=qVfV1DL1ikjVnLd7qTeCx9C8Z7dGvhh_9NSgxPYrOCJ=0g@mail.gmail.com>
 <201208271144.03681.heiko@sntech.de>
Message-ID: <CA+E=qVf9+J1rtvr7snhfRgqKHgWZ+g7TfcQuP8qm00+HH86CDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 12:44 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Vasily,
>
> I'm not sure I follow :-) .
>
> The compatible property here only sets the mechanism on how to handle the
> gpios defined in the devicetree - here to use the s3c24xx-style. As you can
> see in gpio-samsung.c the handling is already unified for all the s3c24xx
> architectures.
>
> The definition of what gpio banks exist is then done in the respective
> devicetree file for the individual SoC. And of course here one would have
> individual definitions, depending on the banks present.
>
> For reference my quite empty s3c2416.dtsi file currently looks like:
>
> /include/ "skeleton.dtsi"
>
> / {
>         compatible = "samsung,s3c2416";
>
>         cpus {
>                 cpu at 0 {
>                         compatible = "arm,arm926ejs";
>                 };
>         };
>
>         gpio-controllers {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 gpio-controller;
>                 ranges;
>
>                 gpa: gpio-controller at 56000000 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000000 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpb: gpio-controller at 56000010 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000010 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpc: gpio-controller at 56000020 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000020 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpd: gpio-controller at 56000030 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000030 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpe: gpio-controller at 56000040 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000040 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpf: gpio-controller at 56000050 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000050 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpg: gpio-controller at 56000060 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000060 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gph: gpio-controller at 56000070 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000070 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 /* s3c2443 and later */
>                 gpj: gpio-controller at 560000D0 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x560000D0 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpk: gpio-controller at 560000E0 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x560000E0 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpl: gpio-controller at 560000F0 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x560000F0 0x10>;
>                         #gpio-cells = <3>;
>                 };
>
>                 gpm: gpio-controller at 56000100 {
>                         compatible = "samsung,s3c24xx-gpio";
>                         reg = <0x56000100 0x10>;
>                         #gpio-cells = <3>;
>                 };
>         };
> };
>
> Other s3c24xx SoCs would of course need to define their own.

I see. But how does it handle GPA bank (which is output-only, and
GPACON differs a bit from GP{B-J}CON? And some banks has lower number
(not 16) of GPIOs, like GPH.

Also, what would be value for S3C_GPIO_END?

Regards
Vasily
