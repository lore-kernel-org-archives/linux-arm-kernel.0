From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Fri, 18 Jan 2013 12:49:28 +0530
Subject: [PATCH 8/9] ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
In-Reply-To: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1358493569-17142-9-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since AM33XX supports only DT-boot, this is needed
for the appropriate device nodes to be created.

Note: OCMC RAM is part of the PER power domain and supports
retention. The assembly code for low power entry/exit will
run from OCMC RAM. To ensure that the OMAP PM code does not
attempt to disable the clock to OCMC RAM as part of the
suspend process add the no_idle_on_suspend flag.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Change from RFC version:
	No change

 arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..4731748 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -385,5 +385,16 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		ocmcram: ocmcram at 40300000 {
+			compatible = "ti,ocmcram";
+			ti,hwmods = "ocmcram";
+			ti,no_idle_on_suspend;
+		};
+
+		wkup_m3: wkup_m3 at 44d00000 {
+			compatible = "ti,wkup_m3";
+			ti,hwmods = "wkup_m3";
+		};
 	};
 };
-- 
1.7.0.4
