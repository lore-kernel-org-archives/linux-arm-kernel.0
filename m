From: jason77.wang@gmail.com (Jason Wang)
Date: Sat, 21 Aug 2010 16:24:05 +0800
Subject: [PATCH 3/3] ARM: imx: set cache line size to 64 bytes for i.MX5
In-Reply-To: <1282379045-32363-3-git-send-email-jason77.wang@gmail.com>
References: <1282379045-32363-1-git-send-email-jason77.wang@gmail.com>
	<1282379045-32363-2-git-send-email-jason77.wang@gmail.com>
	<1282379045-32363-3-git-send-email-jason77.wang@gmail.com>
Message-ID: <1282379045-32363-4-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core of i.MX5 series is cortex-A8, its cache line size is 64 bytes
instead of 32 bytes. Refer to the OMAP3's selection, we choose 64
bytes for i.MX5, this can increase a little bit performance when
perform cache operations.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/plat-mxc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 0527e65..6785db4 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -43,6 +43,7 @@ config ARCH_MXC91231
 config ARCH_MX5
 	bool "MX5-based"
 	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
 	help
 	  This enables support for systems based on the Freescale i.MX51 family
 
-- 
1.5.6.5
