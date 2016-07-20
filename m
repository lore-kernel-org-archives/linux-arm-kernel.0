From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 20 Jul 2016 20:26:14 +0530
Subject: [net-next PATCH 3/3] ARM: dts: dra72-evm-revc: fix non-working cpsw
 second ethernet
In-Reply-To: <20160720145614.13132-1-mugunthanvnm@ti.com>
References: <20160720145614.13132-1-mugunthanvnm@ti.com>
Message-ID: <20160720145614.13132-4-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second ethernet of cpsw is not working, make it work by adding
impedance configuration.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index f9cfd3b..4313de5 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -69,5 +69,7 @@
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,impedance-control = <0x1f>;
 	};
 };
+
-- 
2.9.2.368.g08bb350
