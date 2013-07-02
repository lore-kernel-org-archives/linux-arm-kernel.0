From: lho@apm.com (Loc Ho)
Date: Tue,  2 Jul 2013 14:38:59 -0600
Subject: [PATCH 2/2] power: arm64: Add DTS entry for APM X-Gene reboot driver.
In-Reply-To: <1372797539-13111-2-git-send-email-lho@apm.com>
References: <1372797539-13111-1-git-send-email-lho@apm.com>
 <1372797539-13111-2-git-send-email-lho@apm.com>
Message-ID: <1372797539-13111-3-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

power: arm64: Add DTS entry for APM X-Gene reboot driver.

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..e686919 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -178,6 +178,12 @@
 			};
 		};
 
+                reboot at 0x17000014 {
+                        compatible = "apm,xgene-reboot";
+                        reg = <0x0 0x17000014 0x0 0x100>;
+                        mask = <0x1>;
+                };
+
 		serial0: serial at 1c020000 {
 			device_type = "serial";
 			compatible = "ns16550";
-- 
1.5.5
