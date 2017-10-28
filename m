From: linus.luessing@c0d3.blue (Linus =?utf-8?Q?L=C3=BCssing?=)
Date: Sat, 28 Oct 2017 23:08:41 +0200
Subject: [PATCH v7 4/6] ARM: meson: Add SMP bringup code for Meson8 and
 Meson8b
In-Reply-To: <20170917164523.6970-5-martin.blumenstingl@googlemail.com>
Message-ID: <20171028210841.GQ2750@otheros>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 47d3a1ab08d2..82faa958ab88 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -147,6 +147,7 @@ textofs-$(CONFIG_SA1111) := 0x00208000
>  endif
>  textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> +textofs-$(CONFIG_ARCH_MESON) := 0x00208000
>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
>  
> # Machine directory name.  This list is sorted alphanumerically

Due to the observations made/explained here [0], would it make
sense to put this diff into an extra patch? With a
"Fixes: 4a69fcd3a108 ("ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards")"
and "Reported-by: Emiliano Ingrassia <ingrassia@epigenesys.com>"
maybe?

Regards, Linus

[0]: https://lkml.org/lkml/2017/10/28/148
