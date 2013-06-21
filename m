From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Fri, 21 Jun 2013 15:14:48 -0300
Subject: [GIT PULL 1/2] ARM: mvebu: dt changes for v3.11 (round 6!)
In-Reply-To: <201306211958.00637.arnd@arndb.de>
References: <20130621164611.GT31667@titan.lakedaemon.net>
 <201306211958.00637.arnd@arndb.de>
Message-ID: <CALF0-+W0XeK-bh3NTAotjLTLh1q=m9RwkRNV8bU8nu1T8F8chg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Fri, Jun 21, 2013 at 2:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Pulled into next/dt, thanks!
>
> I got a non-obvious conflict that I resolved like this:
>
>
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@@ -30,8 -30,8 +30,9 @@@
>
>         ocp at f1000000 {
>                 compatible = "simple-bus";
> -               ranges = <0x00000000 0xf1000000 0x4000000
> +               ranges = <0x00000000 0xf1000000 0x0100000
>  +                        0xe0000000 0xe0000000 0x8100000 /* PCIE */
> +                         0xf4000000 0xf4000000 0x0000400
>                           0xf5000000 0xf5000000 0x0000400>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>
>

Yes, that looks fine.

Thanks,
-- 
    Ezequiel
