From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 11 Jan 2018 14:59:01 +1300
Subject: [PATCH v2 1/3] ARM: dts: armada-xp: enable L2 cache parity and ecc on
 db-xc3-24g4xg
In-Reply-To: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz>
References: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180111015903.11322-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable L2 cache parity and ECC on the db-xc3-24g4xg board so that cache
operations are protected and errors can be flagged to the EDAC
subsystem.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Update commit message

 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index 06fce35d7491..00ca489fc788 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -70,6 +70,11 @@
 	};
 };
 
+&L2 {
+	arm,parity-enable;
+	marvell,ecc-enable;
+};
+
 &devbus_bootcs {
 	status = "okay";
 
-- 
2.15.1
