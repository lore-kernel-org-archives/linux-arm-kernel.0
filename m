From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 14:42:33 +0200
Subject: [PATCH 6/9] arm: tegra: apalis_t30: enable hda for eval board
In-Reply-To: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440765756-1382-7-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually enable HDA now that it should otherwise be supported driver
and device tree wise.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 6236bde..5a49f03 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -126,6 +126,10 @@
 		};
 	};
 
+	hda at 70030000 {
+		status = "okay";
+	};
+
 	sd1: sdhci at 78000000 {
 		status = "okay";
 		bus-width = <4>;
-- 
2.4.3
