From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 22 May 2017 20:48:14 +0800
Subject: [PATCH v8 2/9] dt-bindings: hisi: Add Hisilicon HiP05/06/07 Djtag dts
 bindings
Message-ID: <1495457294-233366-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

Add Hisilicon HiP05/06/07 Djtag dts bindings for CPU and IO Die

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/hisilicon/djtag.txt    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/djtag.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
new file mode 100644
index 0000000..fde5bab
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
@@ -0,0 +1,51 @@
+The Hisilicon Djtag is an independent component which connects with some other
+components in the SoC by Debug Bus. The djtag is available in CPU and IO dies
+in the chip. The djtag controls access to connecting modules of CPU and IO
+dies.
+The various connecting components in CPU die (like L3 cache, L3 cache PMU etc.)
+are accessed by djtag during real time debugging. In IO die there are connecting
+components like RSA. These components appear as devices attached to djtag bus.
+
+Hisilicon HiP05/06/07 djtag for CPU die
+Required properties:
+  - compatible : The value should be as follows
+	(a) "hisilicon,hip05-cpu-djtag-v1" for CPU die which use v1 hw in
+	    HiP05 chipset.
+	(b) "hisilicon,hip06-cpu-djtag-v1" for CPU die which use v1 hw in
+	    HiP06 chipset.
+	(c) "hisilicon,hip07-cpu-djtag-v2" for CPU die which use v2 hw in
+	    HiP07 chipset.
+  - reg : Register address and size
+  - hisilicon,scl-id : The Super Cluster ID for CPU or IO die
+
+Example 1: Djtag for CPU die in HiP07
+
+	/* for Hisilicon HiP07 djtag for CPU Die */
+	djtag0: djtag at 60010000 {
+		compatible = "hisilicon,hip07-cpu-djtag-v2";
+		reg = <0x0 0x60010000 0x0 0x10000>;
+		hisilicon,scl-id = <0x03>;
+
+		/* All connecting components will appear as child nodes */
+	};
+
+Hisilicon HiP05/06/07 djtag for IO die
+Required properties:
+  - compatible : The value should be as follows
+	(a) "hisilicon,hip05-io-djtag-v1" for IO die which use v1 hw in
+	    HiP05 chipset.
+	(c) "hisilicon,hip06-io-djtag-v2" for IO die which use v2 hw in
+	    HiP06 chipset.
+	(d) "hisilicon,hip07-io-djtag-v2" for IO die which use v2 hw in
+	    HiP07 chipset
+
+Example 2: Djtag for IO die in HiP05
+
+	/* for Hisilicon HiP05 djtag for IO Die */
+	djtag1: djtag at d0000000 {
+		compatible = "hisilicon,hip05-io-djtag-v1";
+		reg = <0x0 0xd0000000 0x0 0x10000>;
+		hisilicon,scl-id = <0x0>;
+
+		/* All connecting components will appear as child nodes */
+	};
-- 
1.9.1
