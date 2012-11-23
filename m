From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Fri, 23 Nov 2012 16:08:30 +0100
Subject: [PATCH 8/8] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
Message-ID: <1353683310-23654-9-git-send-email-ciminaghi@gnudd.com>
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
index 3e6a59f..79304a0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -525,6 +525,7 @@ config STA2X11
 	select SWIOTLB
 	select MFD_STA2X11
 	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
 	default n
 	---help---
 	  This adds support for boards based on the STA2X11 IO-Hub,
@@ -2179,6 +2180,9 @@ config GEOS
 
 endif # X86_32
 
+config ARM_AMBA
+        bool
+
 config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
-- 
1.7.10.4
