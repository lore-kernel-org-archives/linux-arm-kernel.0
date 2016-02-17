From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Feb 2016 21:50:44 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <1455730114-2547-3-git-send-email-romain.perier@gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <1455730114-2547-3-git-send-email-romain.perier@gmail.com>
Message-ID: <9529888.YxErSS5PS8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 February 2016 18:28:34 Romain Perier wrote:
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index 0477a81..71009dc 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -99,6 +99,11 @@
>                 };
>         };
>  
> +       hwrev at c1107d4c {
> +               compatible = "amlogic,meson8b-hwrev", "syscon";
> +               reg = <0xc1107d4c 0x460>;
> +       };
> 

That is a very odd address. Are you sure this is not part of a larger
block of registers?

	Arnd
