From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Mon, 10 Dec 2012 14:42:36 +0100
Subject: [PATCH v4 7/7] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
Message-ID: <1355146956-6009-8-git-send-email-ciminaghi@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

The sta2x11 I/O Hub is a bridge from PCIe to AMBA. It reuses a number
of amba drivers and needs to activate core bus support.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 arch/x86/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5f67642..0659e7b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -521,6 +521,7 @@ config STA2X11
 	select SWIOTLB
 	select MFD_STA2X11
 	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
 	default n
 	---help---
 	  This adds support for boards based on the STA2X11 IO-Hub,
@@ -2237,6 +2238,9 @@ config GEOS
 
 endif # X86_32
 
+config ARM_AMBA
+        bool
+
 config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
-- 
1.7.10.4
