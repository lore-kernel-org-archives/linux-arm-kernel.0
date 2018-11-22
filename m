From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Thu, 22 Nov 2018 05:15:06 +0000
Subject: [PATCH v4 7/7] arm64: dts: lx2160a: update fspi node
In-Reply-To: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1542863544-21257-8-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 3b20c97..24cc41c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -45,6 +45,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <20000000>;
 		reg = <0>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <8>;
 	};
 
 	mt35xu512aba1: flash at 1 {
@@ -54,6 +56,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <20000000>;
 		reg = <1>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <8>;
 	};
 };
 
-- 
2.7.4
