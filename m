From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 15:52:46 +0200
Subject: [PATCH 6/8] ARM: dts: exynos4x12: Keep mshc node disabled by default
In-Reply-To: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
References: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377006768-23174-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSHC node requires additional board-specific data, so it should be
disabled by default. Board dts files already have status override for
it, so only the change in exynso4x12.dtsi is needed.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 06cef96..2f243c2 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -203,5 +203,6 @@
 		interrupts = <0 77 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 };
-- 
1.8.3.2
