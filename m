From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:24:22 +0530
Subject: [PATCH 5/6] arm64: dts: Add IPROC RNG200 DT node for NS2
In-Reply-To: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
References: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808463-21120-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have IPROC RNG200 hardware random number generation in
NS2 SoC, lets enable it for NS2 in NS2 DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index bc31c0e..92ecf1c 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -187,5 +187,10 @@
 			clock-frequency = <23961600>;
 			status = "disabled";
 		};
+
+		hwrng: hwrng at 66220000 {
+			compatible = "brcm,iproc-rng200";
+			reg = <0x66220000 0x28>;
+		};
 	};
 };
-- 
1.9.1
