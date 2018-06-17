From: daniel@zonque.org (Daniel Mack)
Date: Sun, 17 Jun 2018 13:53:09 +0200
Subject: [PATCH v2] ARM: dts: am437x: make edt-ft5x06 a wakeup source
Message-ID: <20180617115309.1341-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen driver no longer configures the device as wakeup source by
default. A "wakeup-source" property is needed.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
v1 ? v2: amended subject to not mention imx6 anymore

 arch/arm/boot/dts/am437x-sk-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 440351ad0b80..d4be3fd0b6f4 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -610,6 +610,8 @@
 
 		touchscreen-size-x = <480>;
 		touchscreen-size-y = <272>;
+
+		wakeup-source;
 	};
 
 	tlv320aic3106: tlv320aic3106 at 1b {
-- 
2.17.1
