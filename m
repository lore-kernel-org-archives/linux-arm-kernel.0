From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 07 Jul 2011 09:36:05 +0200
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
	<CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
Message-ID: <op.vx8nefym2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Jul 2011 01:57:11 +0200, Lin Mac <mkl0301@gmail.com> wrote:

> CNS3xxx have PL310. Would you mind to enable CONFIG_CACHE_PL310 by
> default as well? It is default disabled by !CPU_V6 of CACHE_PL310.
>
> @@ -795,6 +795,7 @@ config CACHE_L2X0
>         default y
>         select OUTER_CACHE
>         select OUTER_CACHE_SYNC
> +       select CACHE_PL310 if ARCH_CNS3XXX
>         help
>           This option enables the L2x0 PrimeCell.

Correct me if I'm wrong, but isn't cns3xxx V6K? So.....

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -322,7 +322,7 @@ config ARCH_CLPS711X

  config ARCH_CNS3XXX
  	bool "Cavium Networks CNS3XXX family"
-	select CPU_V6
+	select CPU_V6K
  	select GENERIC_CLOCKEVENTS
  	select ARM_GIC
  	select MIGHT_HAVE_PCI


Imre
