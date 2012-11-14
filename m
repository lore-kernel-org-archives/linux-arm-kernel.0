From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 14 Nov 2012 23:38:24 +0530
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add d_can instances to aliases
In-Reply-To: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352916505-12343-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add d_can instances to aliases node to get the D_CAN instance number
from the driver. To initialize D_CAN message RAM, corresponding instance
number is required.

To initialize instance 0 message RAM then 0x1 should be written and for
instance 1 message RAM, 0x2 should be written to control module register.

With device-tree framework ip instance number is "-1" by default for all
instances. To get device id/instance number then modules should be added
to DT "aliases" node. of_alias_get_id() gives the device id number based
on number of alias nodes present in "aliases node".

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 5dfd682..c92c35f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -21,6 +21,8 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &uart6;
+		d_can0 = &dcan0;
+		d_can1 = &dcan1;
 	};
 
 	cpus {
-- 
1.7.9.5
