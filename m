From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 17 Jul 2015 16:08:01 -0500
Subject: [PATCH 1/4] ARM: dts: AM33xx: Add ti,
 mbox-send-noirq to wkup_m3 mailbox
In-Reply-To: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
References: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1437167284-25659-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ti,mbox-send-noirq to wkup_m3 mailbox so that messages using
wkup_m3 mailbox are sent without triggering any further interrupts.
This is needed to achieve lower power numbers during CPU idle on
AM33xx.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[s-anna at ti.com: revise commit description]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4c1b4a8..4f2c07a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -391,6 +391,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
 			mbox_wkupm3: wkup_m3 {
+				ti,mbox-send-noirq;
 				ti,mbox-tx = <0 0 0>;
 				ti,mbox-rx = <0 0 3>;
 			};
-- 
2.4.5
