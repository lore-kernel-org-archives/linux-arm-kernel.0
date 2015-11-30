From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 30 Nov 2015 13:27:46 +0100
Subject: [PATCH v4 net 6/6] mvebu: dts: enable IP checksum with jumbo frames
 for Armada 38x on Port0
In-Reply-To: <1448886466-31538-1-git-send-email-mw@semihalf.com>
References: <1448886466-31538-1-git-send-email-mw@semihalf.com>
Message-ID: <1448886466-31538-7-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ethernet controller found in the Armada 38x SoC's family support
TCP/IP checksumming with frame sizes larger than 1600 bytes, however
only on port 0.

This commit enables it by setting 'tx-csum-limit' to 9800B in
'ethernet at 70000' node.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index c6a0e9d..e8b7f67 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -498,6 +498,7 @@
 				reg = <0x70000 0x4000>;
 				interrupts-extended = <&mpic 8>;
 				clocks = <&gateclk 4>;
+				tx-csum-limit = <9800>;
 				status = "disabled";
 			};
 
-- 
1.8.3.1
