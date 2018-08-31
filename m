From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Fri, 31 Aug 2018 15:59:59 +0530
Subject: [PATCH 2/7] spi: add flags for octal I/O data transfer
In-Reply-To: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1535711404-29528-3-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add flags for Octal I/O data transfer
Required for the SPI controller which can do data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 include/linux/spi/spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 558aeed..180f277 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -164,6 +164,8 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define	SPI_TX_OCTAL	0x1000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x2000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.7.4
