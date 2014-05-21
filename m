From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 21 May 2014 09:53:57 -0700
Subject: [PATCH v5 2/6] dt-bindings: add mtk-timer bindings
In-Reply-To: <1948139.7c1AZ80ZQt@phil>
References: <1400689583-21119-1-git-send-email-matthias.bgg@gmail.com>
 <1400689583-21119-3-git-send-email-matthias.bgg@gmail.com>
 <63a3ee29-aa23-4137-9c0c-5b2bdd75a68f@BN1BFFO11FD014.protection.gbl>
 <1948139.7c1AZ80ZQt@phil>
Message-ID: <3a9b6824-e088-4774-b125-7a33b5a895dc@BN1AFFO11FD022.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-05-21 at 06:54PM +0200, Heiko St?bner wrote:
> Am Mittwoch, 21. Mai 2014, 09:34:10 schrieb S?ren Brinkmann:
> > Hi Matthias,
> > 
> > On Wed, 2014-05-21 at 06:26PM +0200, Matthias Brugger wrote:
> > > Add binding documentation for the General Porpose Timer driver of
> > 
> > Typo: Purpose
> > 
> > > the Mediatek SoCs.
> > > 
> > > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/timer/mediatek,mtk-timer.txt   | 18
> > >  ++++++++++++++++++ 1 file changed, 18 insertions(+)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt> 
> > > diff --git
> > > a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> > > b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt new file
> > > mode 100644
> > > index 0000000..7d909f7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> > > @@ -0,0 +1,18 @@
> > > +Mediatek MT6577, MT6572 and MT6589 Timers
> > > +---------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible: Should be "mediatek,mtk6577-timer"
> > > +- reg: Should contain location and length for timers register.
> > > +- clocks: Clocks driving the timer hardware. This list shoud include two
> > > +	clocks. The order is system clock and as second clock the RTC clock.
> > > +
> > > +Examples:
> > > +
> > > +	timer {
> > 
> > The node name should be timer at 0x10008000
> 
> I think the more commonly used variant is
> 
> 	timer at 10008000
> 
> without the 0x. While some dts files really use @0x they are in the minority.

You're right.

> 
> 
> > 
> > > +		compatible = "mediatek,mtk6577-timer";
> > > +		reg = <0x10008000 0x80>;
> > > +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> > > +		clocks = <&system_clk>, <&rtc_clk>;
> > > +		clock-names = "system-clk", "rtc-clk";
> > 
> > I'm still not convinced that the timer IP calls its clock inputs this
> > way, but well.
> 
> Maybe this might convince you ;-)
> 
> "The GPT includes 5 32-bit timers and one 64-bit timer. Each timer has 4 
> operation modes, which are ONE-SHOT,  REPEAT,  KEEP-GO and  FREERUN, and can 
> operate on one of the 2 clock sources, RTC clock (32.768kHz) and system clock 
> (13MHz)."

Is this copied from the timer data sheet or the SOC documentation?

	S?ren
