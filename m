From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:40:23 +0200
Subject: [PATCH 3/4] ARM: shmobile: r8a7791: Add QSPI DMA support
In-Reply-To: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
References: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716424-29740-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/include/mach/r8a7791.h | 2 ++
 arch/arm/mach-shmobile/setup-r8a7791.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
index 533999916e73..c4582df76139 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7791.h
@@ -4,6 +4,8 @@
 /* DMA slave IDs */
 enum {
 	RCAR_DMA_SLAVE_INVALID,
+	SYS_DMAC_SLAVE_QSPI_TX,
+	SYS_DMAC_SLAVE_QSPI_RX,
 };
 
 void r8a7791_add_standard_devices(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 77e1bc2b2870..8dbdb17ffe51 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -57,6 +57,7 @@
 }
 
 static const struct sh_dmae_slave_config r8a7791_sys_dmac_slaves[] = {
+	SYS_DMAC_SLAVE(QSPI,   8, 0xe6b10000, 0x04, 0x04,   0x17, 0x18),
 };
 
 static const struct sh_dmae_channel r8a7791_sys_dmac_channels[] = {
-- 
1.9.1
