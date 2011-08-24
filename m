From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 24 Aug 2011 18:37:20 -0300
Subject: [PATCH] ARM: mx5: Select CONFIG_VMSPLIT_2G option
Message-ID: <1314221840-6049-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX53 is capable of addressing up to 1GB of RAM.

Select CONFIG_VMSPLIT_2G so that the full 1GB can be detected by the kernel.
and we avoid getting the following message:

Ignoring RAM at b0000000-cfffffff (vmalloc region overlap)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mx5_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mx5_defconfig b/arch/arm/configs/mx5_defconfig
index ede3cc2..91fe1fe 100644
--- a/arch/arm/configs/mx5_defconfig
+++ b/arch/arm/configs/mx5_defconfig
@@ -28,6 +28,7 @@ CONFIG_MACH_MX53_ARD=y
 CONFIG_MXC_PWM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-- 
1.6.0.4
