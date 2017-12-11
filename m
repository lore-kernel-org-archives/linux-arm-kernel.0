From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Mon, 11 Dec 2017 08:50:01 +0100
Subject: [PATCH 4/4] arm: dts: sun8i: a83t: Set timer node to use phy timer
In-Reply-To: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
References: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
Message-ID: <20171211075001.6100-5-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, virtual timers are used. These timers need an offset
that must be set by firmware, for example. In case of SMP support,
after a reset, this offset is in "unknown" state and produced
a hang of the kernel.

Use "arm,cpu-registers-not-fw-configured" property allows to use
physical timers instead of virtual ones.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 3e2aad537972..0fe4b9e5dee1 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -121,6 +121,7 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,cpu-registers-not-fw-configured;
 	};
 
 	clocks {
-- 
2.11.0
