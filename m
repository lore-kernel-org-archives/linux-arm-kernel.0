From: tommy.lin.1101@gmail.com (Tommy Lin)
Date: Fri,  8 Jul 2011 14:00:06 +0800
Subject: [PATCH 2/2] arch: arm: CNS3xxx select the correct CPU type CPU_V6K
Message-ID: <1310104806-12984-1-git-send-email-tommy.lin@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM11        -> CPU_V6
ARM11 MPCore -> CPU_V6K
CNS3xxx has ARM11 MPCore CPUs (dual core), but initially select the same single
core CPU type. To select MPCore watchdog support, this patch correts the CPU
type from CPU_V6 to CPU_V6K.

Signed-off-by: Tommy Lin <tommy.lin@caviumnetworks.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c148326..89eaab7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -321,7 +321,7 @@ config ARCH_CLPS711X
 
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
-	select CPU_V6
+	select CPU_V6K
 	select GENERIC_CLOCKEVENTS
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
-- 
1.7.6
