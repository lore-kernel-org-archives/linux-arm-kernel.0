From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 15 Jun 2015 16:27:23 +0200
Subject: [PATCH 2/2] ARM: mvebu: disable IP checksum with jumbo frames for
 Armada 370
In-Reply-To: <1434378443-23029-1-git-send-email-simon.guinot@sequanux.org>
References: <1434378443-23029-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1434378443-23029-3-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ethernet controller found in Armada 370 SoCs don't support TCP/IP
checksumming with frames largest than 1600 Bytes.

This patch sets accordingly the tx_csum_limit property in Ethernet nodes
for Armada 370.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Cc: <stable@vger.kernel.org> # v3.8+
---
 arch/arm/boot/dts/armada-370.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 00b50db57c9c..046489df351d 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -307,6 +307,14 @@
 					dmacap,memset;
 				};
 			};
+
+			ethernet at 70000 {
+				tx_csum_limit = <1600>;
+			};
+
+			ethernet at 74000 {
+				tx_csum_limit = <1600>;
+			};
 		};
 	};
 };
-- 
2.1.4
