From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 May 2018 19:46:24 +0200
Subject: [PATCH v2] arm64: dts: r8a77965: Add SDHI device nodes
In-Reply-To: <CAMuHMdWq0w2V-Oskvci6bznTMPRXALVkCtefkFgvSm3Obw-e-Q@mail.gmail.com>
References: <1525869504-3361-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdWq0w2V-Oskvci6bznTMPRXALVkCtefkFgvSm3Obw-e-Q@mail.gmail.com>
Message-ID: <20180509174621.e22jqofunz4bwmdy@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 03:39:45PM +0200, Geert Uytterhoeven wrote:
> Hi Kaneko-san,
> 
> On Wed, May 9, 2018 at 2:38 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > Add SDHI nodes to the DT of the r8a77965 SoC.
> >
> > Based on several similar patches of the R8A7796 device tree
> > by Simon Horman <horms+renesas@verge.net.au>.
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> >
> > This patch is based on the devel branch of Simon Horman's renesas tree.
> >
> > v2 [Yoshihiro Kaneko]
> > * As suggested by Simon Horman
> > Rebased on top of the devel branch of the renesas tree.
> 
> Thanks for the update!
> 
> >  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 36 +++++++++++++++++++++++++++----
> >  1 file changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > index ba0edda..510815e 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > @@ -978,23 +978,51 @@
> >                 };
> >
> >                 sdhi0: sd at ee100000 {
> > +                       compatible = "renesas,sdhi-r8a77965",
> > +                                    "renesas,rcar-gen3-sdhi";
> >                         reg = <0 0xee100000 0 0x2000>;
> > -                       /* placeholder */
> > +                       interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&cpg CPG_MOD 314>;
> > +                       max-frequency = <200000000>;
> > +                       power-domains = <&sysc 32>;
> 
> In the mean time, <dt-bindings/power/r8a77965-sysc.h> has landed
> upstream, so please use R8A77965_PD_ALWAYS_ON.
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have applied the patch with that fix.
The result is as follows:

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Subject: [PATCH] arm64: dts: r8a77965: Add SDHI device nodes

Add SDHI nodes to the DT of the r8a77965 SoC.

Based on several similar patches of the R8A7796 device tree
by Simon Horman <horms+renesas@verge.net.au>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 36 +++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index ba0edda431a5..f51c1b2cbae4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -978,23 +978,51 @@
 		};
 
 		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a77965",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee100000 0 0x2000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
 		};
 
 		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a77965",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee120000 0 0x2000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
 		};
 
 		sdhi2: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a77965",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee140000 0 0x2000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			status = "disabled";
 		};
 
 		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a77965",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee160000 0 0x2000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
 		};
 
 		gic: interrupt-controller at f1010000 {
-- 
2.11.0
