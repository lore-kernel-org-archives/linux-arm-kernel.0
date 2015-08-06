From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 06 Aug 2015 16:05:13 +0100
Subject: [PATCH 1/3] clk: versatile: Switch to assigned clock parents
In-Reply-To: <55C24E56.3020004@codeaurora.org>
References: <55BBB2FC.9030102@codeaurora.org>
 <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
 <1438386285-5070-2-git-send-email-sboyd@codeaurora.org>
 <1438610480.2142.14.camel@arm.com> <55BFAB11.7080600@codeaurora.org>
 <1438770574.2142.80.camel@arm.com> <55C24E56.3020004@codeaurora.org>
Message-ID: <1438873513.2142.95.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-05 at 18:56 +0100, Stephen Boyd wrote:
> On 08/05/2015 03:29 AM, Pawel Moll wrote:
> >
> > Right, that's probably my fault. The sp810 nodes appeared in the VE
> > trees very early (in terms of the "DT era"), when we weren't so strict
> > about documentation. So far, it would be fairly simple, something like
> > the text below - feel free to take it, mend it, extend it with your
> > changes and include in the series:
> >
> > Thanks!
> 
> Great! Can you please provide your signed-off-by? 

Sure. 

8<--------------------------------------------------------

>From cddb00e4c8b6b57e82008fa23a7359560e5c997c Mon Sep 17 00:00:00 2001
From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 6 Aug 2015 16:04:10 +0100
Subject: [PATCH] clk: versatile: Add SP810 device tree bindings document

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/arm/sp810.txt | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sp810.txt

diff --git a/Documentation/devicetree/bindings/arm/sp810.txt b/Documentation/devicetree/bindings/arm/sp810.txt
new file mode 100644
index 0000000..440ee08
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sp810.txt
@@ -0,0 +1,35 @@
+SP810 System Controller
+-----------------------
+
+Required properties:
+
+- compatible:	standard compatible string for a Primecell peripheral,
+		see Documentation/devicetree/bindings/arm/primecell.txt
+		for more details
+		should be: "arm,sp810", "arm,primecell"
+
+- reg:		standard registers property, physical address and size
+		of the control registers
+
+- clock-names:	from the common clock bindings, for more details see
+		Documentation/devicetree/bindings/clock/clock-bindings.txt;
+		should be: "refclk", "timclk", "apb_pclk"
+
+- clocks:	from the common clock bindings, phandle and clock
+		specifier pairs for the entries of clock-names property
+
+- #clock-cells: from the common clock bindings;
+		should be: <1>
+
+- clock-output-names: from the common clock bindings;
+		should be: "timerclken0", "timerclken1", "timerclken2", "timerclken3"
+
+Example:
+	sysctl at 020000 {
+		compatible = "arm,sp810", "arm,primecell";
+		reg = <0x020000 0x1000>;
+		clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
+		clock-names = "refclk", "timclk", "apb_pclk";
+		#clock-cells = <1>;
+		clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+	};
-- 
2.1.4
