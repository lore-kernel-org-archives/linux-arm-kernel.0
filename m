From: b32955@freescale.com (Huang Shijie)
Date: Fri, 8 Jul 2011 13:28:03 +0800
Subject: [PATCH v6 2/4] ARM: mxs: add new a pad control
In-Reply-To: <1310102885-4102-1-git-send-email-b32955@freescale.com>
References: <1310102885-4102-1-git-send-email-b32955@freescale.com>
Message-ID: <1310102885-4102-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a new pad control which is used in some rare cases,
such as gpmi-nand device.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-mxs/include/mach/iomux.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/iomux.h b/arch/arm/mach-mxs/include/mach/iomux.h
index 7abdf58..1f31762 100644
--- a/arch/arm/mach-mxs/include/mach/iomux.h
+++ b/arch/arm/mach-mxs/include/mach/iomux.h
@@ -94,6 +94,9 @@ typedef u32 iomux_cfg_t;
 /* generic pad control used in most cases */
 #define MXS_PAD_CTRL	(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
 
+/* special pad control used in rare cases */
+#define MXS_PAD_CTRL_12MA	(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
+
 #define MXS_IOMUX_PAD(_bank, _pin, _muxsel, _ma, _vol, _pull)		\
 		(((iomux_cfg_t)(_bank) << MXS_PAD_BANK_SHIFT) |		\
 		((iomux_cfg_t)(_pin) << MXS_PAD_PIN_SHIFT) |		\
-- 
1.7.0.4
