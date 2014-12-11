From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Dec 2014 17:33:45 +0100
Subject: [PATCH 1/2] i2c: i2c-mv64xxx: use BIT() macro for register value
 definitions
In-Reply-To: <1418315626-9552-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1418315626-9552-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1418315626-9552-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 2f64273..7f57d1f 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -30,12 +30,12 @@
 #define MV64XXX_I2C_BAUD_DIV_N(val)			(val & 0x7)
 #define MV64XXX_I2C_BAUD_DIV_M(val)			((val & 0xf) << 3)
 
-#define	MV64XXX_I2C_REG_CONTROL_ACK			0x00000004
-#define	MV64XXX_I2C_REG_CONTROL_IFLG			0x00000008
-#define	MV64XXX_I2C_REG_CONTROL_STOP			0x00000010
-#define	MV64XXX_I2C_REG_CONTROL_START			0x00000020
-#define	MV64XXX_I2C_REG_CONTROL_TWSIEN			0x00000040
-#define	MV64XXX_I2C_REG_CONTROL_INTEN			0x00000080
+#define	MV64XXX_I2C_REG_CONTROL_ACK			BIT(2)
+#define	MV64XXX_I2C_REG_CONTROL_IFLG			BIT(3)
+#define	MV64XXX_I2C_REG_CONTROL_STOP			BIT(4)
+#define	MV64XXX_I2C_REG_CONTROL_START			BIT(5)
+#define	MV64XXX_I2C_REG_CONTROL_TWSIEN			BIT(6)
+#define	MV64XXX_I2C_REG_CONTROL_INTEN			BIT(7)
 
 /* Ctlr status values */
 #define	MV64XXX_I2C_STATUS_BUS_ERR			0x00
@@ -68,16 +68,16 @@
 #define	MV64XXX_I2C_REG_BRIDGE_TIMING			0xe0
 
 /* Bridge Control values */
-#define	MV64XXX_I2C_BRIDGE_CONTROL_WR			0x00000001
-#define	MV64XXX_I2C_BRIDGE_CONTROL_RD			0x00000002
+#define	MV64XXX_I2C_BRIDGE_CONTROL_WR			BIT(0)
+#define	MV64XXX_I2C_BRIDGE_CONTROL_RD			BIT(1)
 #define	MV64XXX_I2C_BRIDGE_CONTROL_ADDR_SHIFT		2
-#define	MV64XXX_I2C_BRIDGE_CONTROL_ADDR_EXT		0x00001000
+#define	MV64XXX_I2C_BRIDGE_CONTROL_ADDR_EXT		BIT(12)
 #define	MV64XXX_I2C_BRIDGE_CONTROL_TX_SIZE_SHIFT	13
 #define	MV64XXX_I2C_BRIDGE_CONTROL_RX_SIZE_SHIFT	16
-#define	MV64XXX_I2C_BRIDGE_CONTROL_ENABLE		0x00080000
+#define	MV64XXX_I2C_BRIDGE_CONTROL_ENABLE		BIT(19)
 
 /* Bridge Status values */
-#define	MV64XXX_I2C_BRIDGE_STATUS_ERROR			0x00000001
+#define	MV64XXX_I2C_BRIDGE_STATUS_ERROR			BIT(0)
 #define	MV64XXX_I2C_STATUS_OFFLOAD_ERROR		0xf0000001
 #define	MV64XXX_I2C_STATUS_OFFLOAD_OK			0xf0000000
 
-- 
2.1.0
