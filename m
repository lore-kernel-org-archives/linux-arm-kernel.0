From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Fri, 12 Feb 2016 07:20:43 +0700
Subject: [PATCH] dtb: amd: Fix-up for ccn504 and kcs nodes
Message-ID: <1455236443-23949-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This is a fix-up patch based on the review comment from
Arnd regarding:
    * fix ccn504 address in the node name
    * remove kcs interrupt-name

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---

Hi Olof,

Here are the changes from the V3 that I sent earlier. Sorry for confusion.
Would you please pull this into the next tree?

Thank you,
Suravee

 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index a7fc059..bd3adea 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -231,7 +231,7 @@
 		};
 
 		/* Perf CCN504 PMU */
-		ccn: ccn at 0xe8000000 {
+		ccn: ccn at e8000000 {
 			compatible = "arm,ccn-504";
 			reg = <0x0 0xe8000000 0 0x1000000>;
 			interrupts = <0 380 4>;
@@ -243,7 +243,6 @@
 			device_type = "ipmi";
 			reg = <0x0 0xe0010000 0 0x8>;
 			interrupts = <0 389 4>;
-			interrupt-names = "ipmi_kcs";
 			reg-size = <1>;
 			reg-spacing = <4>;
 		};
-- 
2.5.0
