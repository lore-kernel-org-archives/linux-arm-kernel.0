From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Jun 2015 16:17:08 -0300
Subject: imx: apf27: the board no longer boot with latest git kernel
In-Reply-To: <CAOMZO5DbL8etNQAb4vOwsXSQr2SBWMzCx0P7+TUWj54T9ZrSjg@mail.gmail.com>
References: <558EA370.6020108@gmail.com>
 <CAOMZO5AcRd8UJQg9MpV6mXJKkB2JMriGHzzKYS95oWQYzMOsuw@mail.gmail.com>
 <558EDCB2.9040603@gmail.com>
 <CAOMZO5DbL8etNQAb4vOwsXSQr2SBWMzCx0P7+TUWj54T9ZrSjg@mail.gmail.com>
Message-ID: <CAOMZO5DgrV-divVoAa3K5QOLdxChewpGcKRLbDjMPRtpx_8KNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philippe,

On Sat, Jun 27, 2015 at 2:34 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Yes, please submit a formal patch.
>
> I thought it was imx1_timer_init_dt because in imx27.dtsi we have:
>
> compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
>
> So I am wondering if this is correct or it should be
>
> compatible = "fsl,imx27-gpt", "fsl,imx21-gpt"; instead?

In addition to the drivers/clocksource/timer-imx-gpt.c patch, could
you also try the change below?

--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -108,7 +108,7 @@
             };

             gpt1: timer at 10003000 {
-                compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+                compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
                 reg = <0x10003000 0x1000>;
                 interrupts = <26>;
                 clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
@@ -117,7 +117,7 @@
             };

             gpt2: timer at 10004000 {
-                compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+                compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
                 reg = <0x10004000 0x1000>;
                 interrupts = <25>;
                 clocks = <&clks IMX27_CLK_GPT2_IPG_GATE>,
@@ -126,7 +126,7 @@
             };

             gpt3: timer at 10005000 {
-                compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+                compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
                 reg = <0x10005000 0x1000>;
                 interrupts = <24>;
                 clocks = <&clks IMX27_CLK_GPT3_IPG_GATE>,
@@ -376,7 +376,7 @@
             };

             gpt4: timer at 10019000 {
-                compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+                compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
                 reg = <0x10019000 0x1000>;
                 interrupts = <4>;
                 clocks = <&clks IMX27_CLK_GPT4_IPG_GATE>,
@@ -385,7 +385,7 @@
             };

             gpt5: timer at 1001a000 {
-                compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+                compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
                 reg = <0x1001a000 0x1000>;
                 interrupts = <3>;
                 clocks = <&clks IMX27_CLK_GPT5_IPG_GATE>,
@@ -436,7 +436,7 @@
             };

             gpt6: timer at 1001f000 {
-                compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+                compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
                 reg = <0x1001f000 0x1000>;
                 interrupts = <2>;
                 clocks = <&clks IMX27_CLK_GPT6_IPG_GATE>,
