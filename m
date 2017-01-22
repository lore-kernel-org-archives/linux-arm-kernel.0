From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 22 Jan 2017 22:17:48 +0100
Subject: [PATCH] ARM: dts: tegra: =?iso-8859-1?Q?Fi?=
 =?iso-8859-1?Q?x_missing_card_detection_in_Trimslice_=B5SD?= card slot
Message-ID: <20170122211747.exirq4nvb2xj6dk6@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Card insertion and removal currently goes undetected. AFAIK there's no
way to generate interrupts on card changes in this slot, so use polling.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
 arch/arm/boot/dts/tegra20-trimslice.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 381747f..87b07fb 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -366,6 +366,7 @@
 
 	sdhci at c8000000 {
 		status = "okay";
+		broken-cd;
 		bus-width = <4>;
 	};
 
-- 
2.10.2

-- 
Rask Ingemann Lambertsen
