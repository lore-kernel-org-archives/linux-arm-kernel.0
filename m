From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 24 Nov 2013 22:51:33 -0800 (PST)
Subject: [RFC 15/17] ARM: shmobile: Remove non-multiplatform Marzen
 reference support
In-Reply-To: <1385342312-1967-16-git-send-email-horms+renesas@verge.net.au>
References: <1385342312-1967-1-git-send-email-horms+renesas@verge.net.au>
 <1385342312-1967-16-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87li0dnfda.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> Now that r8a7779 has CCF support remove the legacy Marzen reference
> Kconfig bits CONFIG_MACH_KOELSCH_REFERENCE for the non-multiplatform
> case.

I guess

 - CONFIG_MACH_KOELSCH_REFERENCE
 + CONFIG_MACH_MARZEN_REFERENCE

> Starting from this commit Marzen board support is always enabled via
> CONFIG_MACH_KOELSCH, and CONFIG_ARCH_MULTIPLATFORM is used to select

ditto ?

> between board-koelsch.c and board-koelsch-reference.c
> The file board-koelsch-reference.c can no longer be used together with

koelsch <-> marzen ?

> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -69,8 +69,7 @@ obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
>  obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
>  obj-$(CONFIG_MACH_GENMAI_REFERENCE)	+= board-genmai-reference.o
>  obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
> -obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
> -obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
> +obj-$(CONFIG_MACH_LAGER)	+= boardo-lager.o

boardo-lager ??
     ^

Best regards
---
Kuninori Morimoto
