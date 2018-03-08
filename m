From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  8 Mar 2018 15:42:26 +0800
Subject: [PATCH v5 3/3] arm64: dts: rockchip: kevin: Avoid wakeup when
 inserting the pen
In-Reply-To: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
Message-ID: <20180308074226.18974-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wakeup event action for Pen Insert gpio key, to avoid wakeup when
inserting the pen.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v5: None
Changes in v4:
Include dt-binding gpio-keys.h

Changes in v3: None
Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 191a6bcb1704..89126dbe5d91 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -44,6 +44,7 @@
 
 /dts-v1/;
 #include "rk3399-gru.dtsi"
+#include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/linux-event-codes.h>
 
 /*
@@ -134,6 +135,8 @@
 		gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		linux,code = <SW_PEN_INSERTED>;
 		linux,input-type = <EV_SW>;
+		/* Wakeup only when ejecting */
+		wakeup-event-action = <EV_ACT_DEASSERTED>;
 		wakeup-source;
 	};
 };
-- 
2.11.0
