From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Aug 2011 19:25:35 -0300
Subject: [PATCH] ARM: mx5: Enable HIGHMEM
Message-ID: <1314224735-6343-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX53 is capable of addressing up to 1GB of RAM.

Select CONFIG_HIGHMEM so that the full 1GB can be detected by the kernel.
and we avoid getting the following message:

Ignoring RAM at b0000000-cfffffff (vmalloc region overlap)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Sascha,

As suggested by Russel I enabled HIGHMEM so that we can get the whole 
1GB available on MX53.

I don't have my hardware handy right now to test it, but I am sending you this patch 
so that you can select this one or the previous that selects CONFIG_VMSPLIT_2G.

 arch/arm/configs/mx5_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mx5_defconfig b/arch/arm/configs/mx5_defconfig
index ede3cc2..8eec865 100644
--- a/arch/arm/configs/mx5_defconfig
+++ b/arch/arm/configs/mx5_defconfig
@@ -30,6 +30,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
-- 
1.6.0.4
