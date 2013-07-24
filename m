From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:34:07 +0900
Subject: [PATCH 14/16] ARM: shmobile: r8a7740: add MMCIF DMA definitions
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
Message-ID: <9a1456242c7c644d0032032ba80e8538b8322d3c.1374624383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add DMA channel slave IDs and configuration entries for the r8a7740
MMCIF controller.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h |  2 ++
 arch/arm/mach-shmobile/setup-r8a7740.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index b34d19b..56f3750 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -42,6 +42,8 @@ enum {
 	SHDMA_SLAVE_FSIB_TX,
 	SHDMA_SLAVE_USBHS_TX,
 	SHDMA_SLAVE_USBHS_RX,
+	SHDMA_SLAVE_MMCIF_TX,
+	SHDMA_SLAVE_MMCIF_RX,
 };
 
 extern void r8a7740_meram_workaround(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index ac29c2e..84c5bb6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -588,6 +588,16 @@ static const struct sh_dmae_slave_config r8a7740_dmae_slaves[] = {
 		.addr		= 0xfe1f0064,
 		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
 		.mid_rid	= 0xb5,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+		.addr		= 0xe6bd0034,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+		.addr		= 0xe6bd0034,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd2,
 	},
 };
 
-- 
1.8.2.1
