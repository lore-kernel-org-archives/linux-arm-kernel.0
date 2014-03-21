From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 21 Mar 2014 10:50:13 +0530
Subject: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Message-ID: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Gerlach <d-gerlach@ti.com>

Do not reset GPIO5 at boot-up because GPIO5_7 is used
on AM437x GP-EVM to control VTT regulators on DDR3.
Without this some GP-EVM boards will fail to boot because
of DDR3 corruption.

Reported-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
This is applied on top of current linux-next.
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

 arch/arm/boot/dts/am437x-gp-evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index df8798e..a055f7f 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -117,6 +117,11 @@
 	status = "okay";
 };
 
+&gpio5 {
+	status = "okay";
+	ti,no-reset-on-init;
+};
+
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vmmcsd_fixed>;
-- 
1.7.9.5
