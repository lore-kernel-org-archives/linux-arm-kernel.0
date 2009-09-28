From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 28 Sep 2009 09:21:35 +0200 (CEST)
Subject: [PATCH needed?] ARM: add missing HAVE_KERNEL_GZIP
Message-ID: <Pine.LNX.4.64.0909280914220.4212@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel fails to uncompress itself and boot without this patch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

No idea if this is the correct or even needed fix. I did observe a failure 
to boot with a post 2.6.31 kernel about two weeks ago without this patch 
(from u-boot), but it might well have become irrelevant by now.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..fca630e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,7 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_KERNEL_GZIP
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
