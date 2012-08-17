From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 17 Aug 2012 16:35:17 +0200
Subject: [PATCH 1/8] arm: sam9_l9260_defconfig: adjust UBI bad eraseblocks
 limit
In-Reply-To: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
References: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1345214124-5478-2-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

UBI has changed the MTD_UBI_BEB_LIMIT semantics. It used to be a percent of
total amount of eraseblock in the partition, and now it is the maximum
amount of bad eraseblocks on the entire devise per 1024 eraseblocks. So not
only the units changed, but also the meaning. But anyway, old 3% roughly
correspond to new 30, so change the defconfig correspondingly.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/arm/configs/sam9_l9260_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/sam9_l9260_defconfig b/arch/arm/configs/sam9_l9260_defconfig
index da276f9..d11fea5 100644
--- a/arch/arm/configs/sam9_l9260_defconfig
+++ b/arch/arm/configs/sam9_l9260_defconfig
@@ -39,7 +39,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_BEB_LIMIT=3
+CONFIG_MTD_UBI_BEB_LIMIT=30
 CONFIG_MTD_UBI_GLUEBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
1.7.2.5
