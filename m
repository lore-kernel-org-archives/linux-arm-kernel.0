From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 30 Sep 2015 11:10:43 +0200
Subject: [PATCH v4 2/5] ARM: mvebu: enable broken-idle on Armada 38x
In-Reply-To: <1443604246-29844-1-git-send-email-simon.guinot@sequanux.org>
References: <1443604246-29844-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1443604246-29844-3-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Donnefort <vdonnefort@gmail.com>

Following the broken-idle DT property introduction, this patch enables
this option for the Armada 38x SoCs. This allows to deactivate the idle
state which is currently broken on this SoCs.

Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index f9f2347d9995..6d29afe12892 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -422,6 +422,7 @@
 			coherency-fabric at 21010 {
 				compatible = "marvell,armada-380-coherency-fabric";
 				reg = <0x21010 0x1c>;
+				broken-idle;
 			};
 
 			pmsu at 22000 {
-- 
2.1.4
