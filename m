From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue,  6 Dec 2011 21:12:17 -0500
Subject: [PATCH] ARM: pcontrol_g20_defconfig should not specify toolchain path
Message-ID: <1323223937-14281-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building defconfigs is a routine operation for people checking
code that touches multiple arch.  But this defconfig calls out
a path to a toolchain that most people will never have.

The defconfigs should not be calling out site specific toolchain
locations, so delete the setting of CROSS_COMPILE.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/configs/pcontrol_g20_defconfig b/arch/arm/configs/pcontrol_g20_defconfig
index c75c9fc..4324a77 100644
--- a/arch/arm/configs/pcontrol_g20_defconfig
+++ b/arch/arm/configs/pcontrol_g20_defconfig
@@ -1,5 +1,4 @@
 CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE="/opt/arm-2010q1/bin/arm-none-linux-gnueabi-"
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-- 
1.7.7.2
