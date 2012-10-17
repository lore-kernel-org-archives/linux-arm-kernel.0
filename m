From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:39:16 +0900
Subject: [PATCH 05/10] ARM: mach-shmobile: add FLCTL DMA slave definitions for
 sh7372
In-Reply-To: <1350448761-27346-1-git-send-email-horms@verge.net.au>
References: <1350448761-27346-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448761-27346-6-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@googlemail.com>

SH7372 can use DMA with the FLCTL flash controller. Add required slave
IDs and slave descriptors.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    4 ++++
 arch/arm/mach-shmobile/setup-sh7372.c        |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index eb98b45..d65fbbe 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -452,6 +452,10 @@ enum {
 	SHDMA_SLAVE_SCIF5_RX,
 	SHDMA_SLAVE_SCIF6_TX,
 	SHDMA_SLAVE_SCIF6_RX,
+	SHDMA_SLAVE_FLCTL0_TX,
+	SHDMA_SLAVE_FLCTL0_RX,
+	SHDMA_SLAVE_FLCTL1_TX,
+	SHDMA_SLAVE_FLCTL1_RX,
 	SHDMA_SLAVE_SDHI0_RX,
 	SHDMA_SLAVE_SDHI0_TX,
 	SHDMA_SLAVE_SDHI1_RX,
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index a07954f..a360111 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -408,6 +408,26 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x3e,
 	}, {
+		.slave_id	= SHDMA_SLAVE_FLCTL0_TX,
+		.addr		= 0xe6a30050,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0x83,
+	}, {
+		.slave_id	= SHDMA_SLAVE_FLCTL0_RX,
+		.addr		= 0xe6a30050,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0x83,
+	}, {
+		.slave_id	= SHDMA_SLAVE_FLCTL1_TX,
+		.addr		= 0xe6a30060,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0x87,
+	}, {
+		.slave_id	= SHDMA_SLAVE_FLCTL1_RX,
+		.addr		= 0xe6a30060,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0x87,
+	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
 		.addr		= 0xe6850030,
 		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
-- 
1.7.10.4
