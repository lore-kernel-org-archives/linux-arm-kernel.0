From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 28 Jul 2015 13:29:58 +0800
Subject: [PATCH v4 7/7] arm64: dts: mt8173: Add subsystem clock
 controller device nodes
In-Reply-To: <24796517.2pfRdOOmRJ@ubix>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omAUAHZUJQMnWJbH7NXB_Etp=OF3dWyMB7Ri1+rAyzyPBg@mail.gmail.com>
 <1437965782.5614.4.camel@mtksdaap41> <24796517.2pfRdOOmRJ@ubix>
Message-ID: <1438061398.17770.25.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-07-27 at 03:21 -0700, Matthias Brugger wrote:
> On Monday, July 27, 2015 10:56:22 AM James Liao wrote:
> > Hi Daniel,
> > 
> > On Fri, 2015-07-24 at 19:32 +0800, Daniel Kurtz wrote:
> > > > @@ -88,6 +88,13 @@
> > > > 
> > > >                 #clock-cells = <0>;
> > > >         
> > > >         };
> > > > 
> > > > +       cpum_ck: dummy_clk {
> > > 
> > > I'm not a big fan of this "dummy_clk".
> > > The 'name' part of the devicetree node is supposed to be generic.
> > > So, perhaps just oscillator at 2, and move it down below clk32k:
> > > oscillator at 1.
> > 
> > > Otherwise:
> > cpum_ck is a test clock which only available in IC test. It's empty on
> > MT8173 evaluation or production boards. Should we name this kind of
> > empty clock as an oscillator? Or is there a better name for it?
> > 
> 
> So if it will never be part of any available boards, why do you want to add 
> it?

infra_cpum is a clock gate, and its clock comes from an external clock.
In previous versions we named the external clock as "clk_null", but it's
not accepted. A specified name is preferred even it's not available on
some boards. So I named it as cpum_ck in this patch.


Best regards,

James
