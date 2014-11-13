From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 10:38:58 +0100
Subject: [PATCHv3 3/5] ARM: mvebu: remove unused register offset definition
In-Reply-To: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1415871540-20302-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit b21dcafea36d ("arm: mvebu: remove dependency of SMP init
on static I/O mapping"), the COHERENCY_FABRIC_CFG_OFFSET register
offset definition is no longer used, so this commit removes it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index c31f4c0..db2f5bd 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -42,8 +42,6 @@ void __iomem *coherency_base;
 static void __iomem *coherency_cpu_base;
 
 /* Coherency fabric registers */
-#define COHERENCY_FABRIC_CFG_OFFSET		   0x4
-
 #define IO_SYNC_BARRIER_CTL_OFFSET		   0x0
 
 enum {
-- 
2.0.0
