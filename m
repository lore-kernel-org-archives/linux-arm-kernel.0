From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Apr 2015 14:56:47 +0100
Subject: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <1429019389.16264.5.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
 <20150306111338.GD8700@leverpostej>
 <1429002474.14855.7.camel@mhfsdcap03>
 <20150414100657.GB28709@leverpostej>
 <1429019389.16264.5.camel@mhfsdcap03>
Message-ID: <20150414135647.GG28709@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >       smi_common:smi at 14022000 {
> > >                  compatible = ?mediate, mt8173-smi?;
> > >                  reg = <0 0x14022000 0 0x1000>;
> > >                  clocks = <&mmsys MM_SMI_COMMON>;
> > >                  clocks-names = ?smi_common?;
> > >       };
> > > 
> > >       larb0: larb at 14021000 {
> > >                  compatible = ?mediate, mt8173-smi-larb?;
> > >                  reg = <0 0x14021000 0 0x1000>;
> > >                  smi = <&smi_common>;
> > >                  clocks = <&mmsys MM_SMI_LARB0>, 
> > > 		 	<&mmsys MM_SMI_LARB0>;
> > >                  clocks-names = ?apb_clk?, ?smi_clk?;
> > >      };
> > > 
> > >      larb1: larb at 16010000 {
> > >                  compatible = ?mediate, mt8173-smi-larb?;
> > >                  reg = <0 0x16010000 0 0x1000>;
> > >                  smi = <&smi_common>;
> > >                  clocks = <&vdecsys VDEC_CKEN>, 
> > > 			 <&mmsys VDEC_LARB_CKEN>;
> > >                  clocks-names = ?apb_clk?, ?smi_clk?;
> > >       };
> > >       ? 
> > >      In some local arbiter, the source clock of the APB clock and the
> > > SMI clock may be the same, like larb0. so the two clocks are the same.
> > > And they may be different in other local arbiteres, like larb1.      
> > > 
> > >      If it is designed like this, is it ok?
> > 
> > That looks pretty good; the clocks and names on the larb nodes seem
> > sensible.
> > 
> > The naming of the "smi_common" clock on the smi_common node looks a bit
> > odd though. Is that really what the clock input is called?
> > 
> > Mark.
>      After check with DE, the smi_common clock also have its APB clock
> and the smi clock(they have the same clock source).
>     And I prepare to delete "_clk" in all the clock-names.
>     So it may be like this:
>          smi_common:smi at 14022000 {
>                  compatible = ?mediate, mt8173-smi?;
>                     reg = <0 0x14022000 0 0x1000>;
>                   clocks = <&mmsys MM_SMI_COMMON>, 
> 			   <&mmsys MM_SMI_COMMON>;
>                   clocks-names = ?apk?,"smi";
>         };
>      How about this?

That looks fine to me. I assume "apk" should be "apb" in the last
example.

Mark.
