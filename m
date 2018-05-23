From: daniel@zonque.org (Daniel Mack)
Date: Wed, 23 May 2018 10:30:13 +0200
Subject: [PATCH 2/2] ARM: dts: am437x: make edt-ft5x06 a wakeup source for
 imx6 boards
In-Reply-To: <20180523083013.7570-1-daniel@zonque.org>
References: <20180523083013.7570-1-daniel@zonque.org>
Message-ID: <20180523083013.7570-2-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen driver no longer configures the device as wakeup source by
default. A "wakeup-source" property is needed.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 4118802b7fea..f17ed89da06b 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -537,6 +537,8 @@
 
 		touchscreen-size-x = <480>;
 		touchscreen-size-y = <272>;
+
+		wakeup-source;
 	};
 
 	tlv320aic3106: tlv320aic3106 at 1b {
-- 
2.14.3
