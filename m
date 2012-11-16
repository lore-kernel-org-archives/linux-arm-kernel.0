From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 16 Nov 2012 15:39:24 +0100
Subject: [PATCH] ARM: imx: ehci: fix host power mask bit
In-Reply-To: <20121116142531.228251f6@eb-e6520>
References: <1353063197.3647.27.camel@mars> <20121116142531.228251f6@eb-e6520>
Message-ID: <1353076764.3647.35.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets HPM (Host power mask bit) to bit 16 according to i.MX
Reference Manual. Falsely it was set to bit 8, but this controls pull-up
Impedance.

Reported-by: Michael Burkey <mdburkey@gmail.com>
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Acked-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-imx/ehci-imx25.c |    2 +-
 arch/arm/mach-imx/ehci-imx35.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/ehci-imx25.c b/arch/arm/mach-imx/ehci-imx25.c
index 27e40d1..134c190 100644
--- a/arch/arm/mach-imx/ehci-imx25.c
+++ b/arch/arm/mach-imx/ehci-imx25.c
@@ -30,7 +30,7 @@
 #define MX25_H1_SIC_SHIFT	21
 #define MX25_H1_SIC_MASK	(0x3 << MX25_H1_SIC_SHIFT)
 #define MX25_H1_PP_BIT		(1 << 18)
-#define MX25_H1_PM_BIT		(1 << 8)
+#define MX25_H1_PM_BIT		(1 << 16)
 #define MX25_H1_IPPUE_UP_BIT	(1 << 7)
 #define MX25_H1_IPPUE_DOWN_BIT	(1 << 6)
 #define MX25_H1_TLL_BIT		(1 << 5)
diff --git a/arch/arm/mach-imx/ehci-imx35.c b/arch/arm/mach-imx/ehci-imx35.c
index a596f70..554e7cc 100644
--- a/arch/arm/mach-imx/ehci-imx35.c
+++ b/arch/arm/mach-imx/ehci-imx35.c
@@ -30,7 +30,7 @@
 #define MX35_H1_SIC_SHIFT	21
 #define MX35_H1_SIC_MASK	(0x3 << MX35_H1_SIC_SHIFT)
 #define MX35_H1_PP_BIT		(1 << 18)
-#define MX35_H1_PM_BIT		(1 << 8)
+#define MX35_H1_PM_BIT		(1 << 16)
 #define MX35_H1_IPPUE_UP_BIT	(1 << 7)
 #define MX35_H1_IPPUE_DOWN_BIT	(1 << 6)
 #define MX35_H1_TLL_BIT		(1 << 5)
-- 
1.7.10.4
