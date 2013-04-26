From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Apr 2013 18:27:45 +0200
Subject: [PATCH 4/6] ARM: shmobile: r8a7740: add MMCIF DMA definitions
In-Reply-To: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
References: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1366993667-23294-5-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA channel slave IDs and configuration entries for the r8a7740
MMCIF controller.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7740.c        |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 7b1138f..536c021 100644
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
index 00c5a70..6b3ed42 100644
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
1.7.2.5
