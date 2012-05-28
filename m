From: rubini@gnudd.com (Alessandro Rubini)
Date: Mon, 28 May 2012 18:37:59 +0200
Subject: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <cover.1338222460.git.rubini@gnudd.com>
References: <cover.1338222460.git.rubini@gnudd.com>
Message-ID: <f85fefb10b7a7407b77180be65b18bf0426145b9.1338222461.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sta2x11 I/O Hub is a bridge from PCIe to AMBA. It reuses a number
of amba drivers and needs to activate core bus support.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 arch/x86/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 91dea918..112718f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -500,6 +500,7 @@ config STA2X11
 	select SWIOTLB
 	select MFD_STA2X11
 	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
 	default n
 	---help---
 	  This adds support for boards based on the STA2X11 IO-Hub,
@@ -2173,6 +2174,9 @@ config GEOS
 
 endif # X86_32
 
+config ARM_AMBA
+        bool
+
 config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
-- 
1.7.7.2
