From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Jan 2011 08:43:30 +0200
Subject: [RESEND PATCH 1/3] arm: Kconfig: remove duplicated GENERIC_HARDIRQS
	entry
In-Reply-To: <1295505812-5062-1-git-send-email-balbi@ti.com>
References: <1295505812-5062-1-git-send-email-balbi@ti.com>
Message-ID: <1295505812-5062-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
so it's safe to drop the duplicated entry and simply
select HAVE_GENERIC_HARDIRQS.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..9756f07 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -17,6 +17,7 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_GENERIC_HARDIRQS
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
-- 
1.7.4.rc2
