From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Jul 2017 11:45:47 +0100
Subject: [PATCH v2] arm64: dts: r8a7795: add IMR-LX4 support
In-Reply-To: <CAMuHMdV9o0HhZgJS2cyWPmsdqgRmXpjSfKrKQMN=x5VTpXZoUw@mail.gmail.com>
References: <20170627173152.532417992@cogentembedded.com>
 <CAMuHMdV9o0HhZgJS2cyWPmsdqgRmXpjSfKrKQMN=x5VTpXZoUw@mail.gmail.com>
Message-ID: <20170705104547.GE24043@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 05, 2017 at 12:18:01PM +0200, Geert Uytterhoeven wrote:
> Hi Sergei,
> 
> On Tue, Jun 27, 2017 at 7:30 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Describe the IMR-LX4 devices in the R8A7795 device tree.
> >
> > Based on the original (and large) patch by Konstantin Kozhevnikov
> > <Konstantin.Kozhevnikov@cogentembedded.com>.
> >
> > Signed-off-by: Konstantin Kozhevnikov <Konstantin.Kozhevnikov@cogentembedded.com>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > ---
> > This patch is against the 'renesas-devel-20170626-v4.12-rc7' tag of Simon
> > Horman's 'renesas.git' repo.
> >
> > The IMR-LX4 bindings were documented in the IMR driver patch and ACK'ed by Rob
> > Herring, so I don't expect them to change...
> >
> > Changes in version 2:
> > - added SoC specific "compatible" prop values;
> > - refreshed the patch;
> > - added Geert's tag.
> 
> In the mean time, r8a7795.dtsi gained reset controller support, so
> you should add "resets" properties were appropriate.

Thanks, I have squashed-in the following.

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f76cb360e110..31d1ba586ec2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1542,6 +1542,7 @@
 			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 823>;
 			power-domains = <&sysc R8A7795_PD_A3VC>;
+			resets = <&cpg 823>;
 		};
 
 		imr-lx4 at fe870000 {
@@ -1551,6 +1552,7 @@
 			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 822>;
 			power-domains = <&sysc R8A7795_PD_A3VC>;
+			resets = <&cpg 822>;
 		};
 
 		imr-lx4 at fe880000 {
@@ -1560,6 +1562,7 @@
 			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 821>;
 			power-domains = <&sysc R8A7795_PD_A3VC>;
+			resets = <&cpg 821>;
 		};
 
 		imr-lx4 at fe890000 {
@@ -1569,6 +1572,7 @@
 			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 820>;
 			power-domains = <&sysc R8A7795_PD_A3VC>;
+			resets = <&cpg 820>;
 		};
 
 		vspbc: vsp at fe920000 {
