From: horms@verge.net.au (Simon Horman)
Date: Mon, 2 Oct 2017 09:15:59 +0200
Subject: [PATCH 22/48] ARM: dts: gr-peach: Add user led device nodes
In-Reply-To: <20171001173614.GB4037@w540>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
 <cfce5ac1aaf08fc0920d6572779360f80e8f3489.1506683482.git.horms+renesas@verge.net.au>
 <e2e2b3a5-23b2-7f11-4fb3-2f835fdbc11a@cogentembedded.com>
 <20171001173614.GB4037@w540>
Message-ID: <20171002071559.GB10579@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 01, 2017 at 07:36:14PM +0200, jacopo mondi wrote:
> Hi Seregei,
> 
> On Sat, Sep 30, 2017 at 01:36:18PM +0300, Sergei Shtylyov wrote:
> > Hello!
> >
> > On 9/29/2017 2:53 PM, Simon Horman wrote:
> >
> > >From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > >
> > >Add device nodes for user leds on gr-peach board.
> > >
> > >Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > >Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > >---
> > >  arch/arm/boot/dts/r7s72100-gr-peach.dts | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > >diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
> > >index bcfa6445bbaa..13d745bb56a5 100644
> > >--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
> > >+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
> > [...]
> > >@@ -51,6 +52,15 @@
> > >  			reg = <0x00600000 0x00200000>;
> > >  		};
> > >  	};
> > >+
> > >+leds {
> >
> >    Not indented properly...
> 
> Thanks!
> 
> Simon, as you sent pull request already, will we need a patch on top
> of this to fix it?

Thanks, please do.

I don't think we need to re-spin the pull-request to correct this,
rather, a follow-up patch can be provided in a follow-up pull-request.

> 
> Thanks
>   j
> >
> > >+		status = "okay";
> > >+		compatible = "gpio-leds";
> > >+
> > >+		led1 {
> > >+			gpios = <&port6 12 GPIO_ACTIVE_HIGH>;
> > >+		};
> > >+	};
> > >  };
> > >  &pinctrl {
> >
> > MBR, Sergei
> 
