From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 13 Aug 2012 16:33:47 +0200
Subject: [patch] ARM: Kirkwood: fix Makefile.boot
In-Reply-To: <20120805203610.644315269@rtp-net.org>
References: <20120805203555.457907381@rtp-net.org>
 <20120805203610.644315269@rtp-net.org>
Message-ID: <20120813143347.GG12756@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 10:35:57PM +0200, Arnaud Patard wrote:
> While building the dtbs target, one is getting:
> 
> make dtbs
> make[1]: *** No rule to make target `arch/arm/boot/kirkwood-qnap-ts219.dtb', needed by `arch/arm/boot/dtbs'.  Stop.
> make: *** [dtbs] Error 2
> 
> The reason is that there's no kirkwood-qnap-ts219.dts file. Update Makefile.boot
> to reflect the dts files present.

Acked-by: Andrew Lunn <andrew@lunn.ch>

Jason, please channel this towards t3.6-rc2

> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: alunn/arch/arm/mach-kirkwood/Makefile.boot
> ===================================================================
> --- alunn.orig/arch/arm/mach-kirkwood/Makefile.boot	2012-07-20 09:14:46.010289974 +0200
> +++ alunn/arch/arm/mach-kirkwood/Makefile.boot	2012-07-26 00:13:14.983792385 +0200
> @@ -7,7 +7,8 @@ dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) +=
>  dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
>  dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
>  dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
> -dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
> +dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-ts219-6281.dtb
> +dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-ts219-6282.dtb
>  dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
>  dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
>  dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
> 
> 
