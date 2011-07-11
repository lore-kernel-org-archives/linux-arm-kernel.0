From: b32955@freescale.com (Huang Shijie)
Date: Mon, 11 Jul 2011 16:01:04 +0800
Subject: [PATCH v7 2/4] ARM: mxs: add new a pad control
In-Reply-To: <1310371266-10704-1-git-send-email-b32955@freescale.com>
References: <1310371266-10704-1-git-send-email-b32955@freescale.com>
Message-ID: <1310371266-10704-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a new pad control which is used in some rare cases,
such as gpmi-nand device.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/include/mach/iomux.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/iomux.h b/arch/arm/mach-mxs/include/mach/iomux.h
index 7abdf58..1b6f55a 100644
--- a/arch/arm/mach-mxs/include/mach/iomux.h
+++ b/arch/arm/mach-mxs/include/mach/iomux.h
@@ -93,6 +93,7 @@ typedef u32 iomux_cfg_t;
 
 /* generic pad control used in most cases */
 #define MXS_PAD_CTRL	(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
+#define MXS_PAD_CTRL_12MA	(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
 
 #define MXS_IOMUX_PAD(_bank, _pin, _muxsel, _ma, _vol, _pull)		\
 		(((iomux_cfg_t)(_bank) << MXS_PAD_BANK_SHIFT) |		\
-- 
1.7.0.4
