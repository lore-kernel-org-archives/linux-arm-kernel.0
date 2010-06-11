From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 21:49:16 +0200
Subject: [RFC 8/9] ARM: SAMSUNG: Add crypto engine register definitions
In-Reply-To: <cover.1276284559.git.mcuelenaere@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
Message-ID: <4C12933C.9080506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the header file containing the register offsets used by the
crypto engine.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-samsung/include/plat/regs-sss.h |  153 +++++++++++++++++++++++++
 1 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-sss.h

diff --git a/arch/arm/plat-samsung/include/plat/regs-sss.h b/arch/arm/plat-samsung/include/plat/regs-sss.h
new file mode 100644
index 0000000..f54cd3b
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-sss.h
@@ -0,0 +1,153 @@
+/*
+ * linux/arch/arm/plat-samsung/include/plat/regs-sss.h
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __PLAT_SAMSUNG_REGS_SSS_H
+#define __PLAT_SAMSUNG_REGS_SSS_H __FILE__
+
+#include <mach/regs-sss.h>
+
+/* Config */
+#define DnI_CFG				(SSS_OFF_CFG + 0x00)
+
+#define DnI_CFG_WrPrivMismatch		(1 << 31)
+#define DnI_CFG_RdPrivMismatch		(1 << 30)
+#define DnI_CFG_SHA_Intr_Status		(1 << 22)
+#define DnI_CFG_DES_Intr_Status		(1 << 21)
+#define DnI_CFG_AES_Intr_Status		(1 << 20)
+#define DnI_CFG_FTx_Intr_Status		(1 << 17)
+#define DnI_CFG_FRx_Intr_Status		(1 << 16)
+#define DnI_CFG_SHA_Intr_En		(1 << 14)
+#define DnI_CFG_DES_Intr_En		(1 << 13)
+#define DnI_CFG_AES_Intr_En		(1 << 12)
+#define DnI_CFG_FTx_Intr_En		(1 << 9)
+#define DnI_CFG_FRx_Intr_En		(1 << 8)
+#define DnI_CFG_TxTrgLevel(n)		(((n / 4) & 7) << 5)
+#define DnI_CFG_TxDmaEnb		(1 << 4)
+#define DnI_CFG_RxTrgLevel(n)		(((n / 4) & 7) << 1)
+#define DnI_CFG_RxDmaEnb		(1 << 0)
+
+/* FIFO */
+#define FRx_Ctrl			(SSS_OFF_FIFO_RX + 0x00)
+#define FRx_MLen			(SSS_OFF_FIFO_RX + 0x04)
+#define FRx_BlkSz			(SSS_OFF_FIFO_RX + 0x08)
+#define FRx_Addr			(SSS_OFF_FIFO_RX + 0x0C)
+#define FRx_MLenCnt			(SSS_OFF_FIFO_RX + 0x10)
+#define FRx_Buf				(SSS_OFF_FIFO_RX + 0x40)
+
+#define FTx_Ctrl			(SSS_OFF_FIFO_TX + 0x00)
+#define FTx_MLen			(SSS_OFF_FIFO_TX + 0x04)
+#define FTx_BlkSz			(SSS_OFF_FIFO_TX + 0x08)
+#define FTx_Addr			(SSS_OFF_FIFO_TX + 0x0C)
+#define FTx_MLenCnt			(SSS_OFF_FIFO_TX + 0x10)
+#define FTx_Buf				(SSS_OFF_FIFO_TX + 0x40)
+
+#define FXx_Ctrl_WrPrivError		(1 << 31)
+#define FXx_Ctrl_RdPrivError		(1 << 30)
+#define FXx_Ctrl_Full			(1 << 27)
+#define FXx_Ctrl_Empty			(1 << 26)
+#define FXx_Ctrl_Done			(1 << 25)
+#define FXx_Ctrl_Running		(1 << 24)
+#define FRx_Ctrl_Wd2Write(n)		((n & 0xFF) << 16)
+#define FRx_Ctrl_Wd2Read(n)		((n & 0xFF) << 8)
+#define FTx_Ctrl_Wd2Read(n)		((n & 0xFF) << 16)
+#define FTx_Ctrl_Wd2Write(n)		((n & 0xFF) << 8)
+#define FXx_Ctrl_Module_AES		(0 << 6)
+#define FXx_Ctrl_Module_DES		(1 << 6)
+#define FXx_Ctrl_Module_SHA		(2 << 6)
+#define FXx_Ctrl_Host_Rd_En		(1 << 5)
+#define FXx_Ctrl_Host_Wr_En		(1 << 4)
+#define FRx_Ctrl_Sync_Tx		(1 << 3)
+#define FXx_Ctrl_Reset			(1 << 2)
+#define FXx_Ctrl_ERROR_En		(1 << 1)
+#define FXx_Ctrl_Start			(1 << 0)
+
+#define FXx_BlkSz_LastValidByte(n)	((n & 3) << 16)
+
+/* AES */
+#define AES_CTRL			(SSS_OFF_AES_RX + 0x00)
+#define AES_DIN				(SSS_OFF_AES_RX + 0x10)
+#define AES_DOUT			(SSS_OFF_AES_TX + 0x20)
+#define AES_KEY				(SSS_OFF_AES_RX + 0x80)
+#define AES_IV				(SSS_OFF_AES_RX + 0xA0)
+#define AES_CTR				(SSS_OFF_AES_RX + 0xB0)
+
+#define AES_CTRL_WrPrivMismatch		(1 << 31)
+#define AES_CTRL_RdPrivMismatch		(1 << 30)
+#define AES_CTRL_OutReady		(1 << 10)
+#define AES_CTRL_InReady		(1 << 9)
+#define AES_CTRL_ContDecOn		(1 << 8)
+#define AES_CTRL_CtrWidth_16bits	(0 << 6)
+#define AES_CTRL_CtrWidth_32bits	(1 << 6)
+#define AES_CTRL_CtrWidth_64bits	(2 << 6)
+#define AES_CTRL_OpMode_ECB		(1 << 4)
+#define AES_CTRL_OpMode_CBC		(2 << 4)
+#define AES_CTRL_OpMode_CTR		(3 << 4)
+#define AES_CTRL_OpDirection_Enc	(0 << 3)
+#define AES_CTRL_OpDirection_Dec	(1 << 3)
+#define AES_CTRL_KeyMode_128bits	(0 << 1)
+#define AES_CTRL_KeyMode_192bits	(1 << 1)
+#define AES_CTRL_KeyMode_256bits	(2 << 1)
+#define AES_CTRL_OpEnable		(1 << 0)
+
+/* TDES */
+#define TDES_CTRL			(SSS_OFF_TDES_RX + 0x00)
+#define TDES_KEY			(SSS_OFF_TDES_RX + 0x10)
+#define TDES_INPUT			(SSS_OFF_TDES_RX + 0x40)
+#define TDES_OUTPUT			(SSS_OFF_TDES_TX + 0x48)
+#define TDES_IV				(SSS_OFF_TDES_RX + 0x50)
+
+#define TDES_CTRL_WrPrivMismatch	(1 << 31)
+#define TDES_CTRL_RdPrivMismatch	(1 << 30)
+#define TDES_CTRL_OutReady		(1 << 7)
+#define TDES_CTRL_InReady		(1 << 6)
+#define TDES_CTRL_Mode_Des		(0 << 5)
+#define TDES_CTRL_Mode_Tdes		(1 << 5)
+#define TDES_CTRL_Mode_ECB		(1 << 3)
+#define TDES_CTRL_Mode_CBC		(2 << 3)
+#define TDES_CTRL_OpDirection_Enc	(0 << 2)
+#define TDES_CTRL_OpDirection_Dec	(1 << 2)
+#define TDES_CTRL_IntMode		(1 << 1)
+#define TDES_CTRL_OpEnable		(1 << 0)
+
+/* SHA1/PRNG */
+#define HASH_CTRL			(SSS_OFF_HASH_RX + 0x00)
+#define HASH_DATA			(SSS_OFF_HASH_RX + 0x04)
+#define HASH_STATUS			(SSS_OFF_HASH_RX + 0x30)
+#define HASH_OUTPUT			(SSS_OFF_HASH_TX + 0x34)
+#define HASH_MIDOUT			(SSS_OFF_HASH_RX + 0x5C)
+#define HASH_IV				(SSS_OFF_HASH_RX + 0x70)
+#define PRE_MSG_LENGTH			(SSS_OFF_HASH_RX + 0x84)
+
+#define HASH_CTRL_USE_IV		(1 << 8)
+#define HASH_CTRL_End_of_Hash_byte(n)	((n & 3) << 6)
+#define HASH_CTRL_SEED_SETTING_ENB	(1 << 5)
+#define HASH_CTRL_Hash_Input_Finished	(1 << 4)
+#define HASH_CTRL_Hash_Start		(1 << 3)
+#define HASH_CTRL_Data_Selection	(1 << 2)
+#define HASH_CTRL_Engine_HMAC		(0 << 0)
+#define HASH_CTRL_Engine_SHA1		(1 << 0)
+#define HASH_CTRL_Engine_PRNG		(2 << 0)
+
+#define HASH_STATUS_BUFFER_IN_ENB	(1 << 4)
+#define HASH_STATUS_Engine_Ready	(1 << 3)
+#define HASH_STATUS_RNG_Ready		(1 << 2)
+#define HASH_STATUS_32bit_Ready		(1 << 1)
+#define HASH_STATUS_Output_Ready	(1 << 0)
+
+/* SDMA */
+#define SDMA_FRx_Buf			(SSS_OFF_SDMA_RX + 0x40)
+#define SDMA_FTx_Buf			(SSS_OFF_SDMA_TX + 0x40)
+
+/* Generic */
+#define WrPrivMismatch			(1 << 31)
+#define RdPrivMismatch			(1 << 30)
+
+#endif /* __PLAT_SAMSUNG_REGS_SSS_H */
-- 
1.7.1
