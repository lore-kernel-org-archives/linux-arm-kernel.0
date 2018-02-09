From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri,  9 Feb 2018 19:55:10 +0800
Subject: [PATCH 3/3] arm64: dts: rockchip: Avoid wakeup when inserting the pen
In-Reply-To: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
Message-ID: <20180209115510.11868-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wakeup interrupt trigger type for Pen Insert gpio key, to avoid
wakeup when inserting the pen.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 191a6bcb1704..5edfbd288b2f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -134,6 +134,8 @@
 		gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		linux,code = <SW_PEN_INSERTED>;
 		linux,input-type = <EV_SW>;
+		/* Wakeup only when ejecting */
+		wakeup-trigger-type = <IRQ_TYPE_EDGE_RISING>;
 		wakeup-source;
 	};
 };
-- 
2.11.0
