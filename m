From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Mon, 24 Aug 2015 15:09:34 +0530
Subject: [PATCH] dts: ipq40xx: Add the global counter node
Message-ID: <20150824093934.GA26409@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the dt data for the 56 global counter which supplies
the count to the arm arch timers.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---

> Refer http://www.spinics.net/lists/linux-arm-msm/msg16660.html
>
> On Fri, Aug 21, 2015 at 09:21:33AM -0700, Bjorn Andersson
> wrote:
>
> Most of the time when there's a device consuming one
> register it turns out to be part of some larger hw block
> and down the road things get complicated from the fact
> that we mapped 4 bytes in the middle.
>
> Is this part of a larger block? Can we better implement
> that as a simple-mfd or syscon?

It is a part of larger block. However, we are ok with the
default settings of the other registers. In a subsequent
patch we will set a value in this register.

Please let me know if I should still go for mfd/syscon

 Documentation/devicetree/bindings/clock/qca,gcnt.txt | 15 +++++++++++++++
 arch/arm/boot/dts/qcom-ipq40xx.dtsi                  |  5 +++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qca,gcnt.txt

diff --git a/Documentation/devicetree/bindings/clock/qca,gcnt.txt b/Documentation/devicetree/bindings/clock/qca,gcnt.txt
new file mode 100644
index 0000000..ccffc01
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qca,gcnt.txt
@@ -0,0 +1,15 @@
+QCA Global Counter
+------------------------------------------------
+Enable 56-bit global counter which supplies the count to the arm arch timers.
+
+Required properties :
+- compatible : "qcom,qca-gcnt"
+
+- reg : shall contain base register location and length
+
+Example:
+
+	counter {
+		compatible = "qcom,qca-gcnt";
+		reg = <0x004a1000 0x4>;
+	};
diff --git a/arch/arm/boot/dts/qcom-ipq40xx.dtsi b/arch/arm/boot/dts/qcom-ipq40xx.dtsi
index f572f38..76c55a3 100644
--- a/arch/arm/boot/dts/qcom-ipq40xx.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq40xx.dtsi
@@ -62,6 +62,11 @@
 			<0x0b002000 0x1000>;
 		};
 
+		counter {
+			compatible = "qcom,qca-gcnt";
+			reg = <0x004a1000 0x4>;
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <1 2 0xf08>,
-- 
1.8.2.1
