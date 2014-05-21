From: heiko.stuebner@bq.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 May 2014 19:18:59 +0200
Subject: [PATCH v5 2/6] dt-bindings: add mtk-timer bindings
In-Reply-To: <3a9b6824-e088-4774-b125-7a33b5a895dc@BN1AFFO11FD022.protection.gbl>
References: <1400689583-21119-1-git-send-email-matthias.bgg@gmail.com>
 <1948139.7c1AZ80ZQt@phil>
 <3a9b6824-e088-4774-b125-7a33b5a895dc@BN1AFFO11FD022.protection.gbl>
Message-ID: <1615424.OJcNQb1ONt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 21. Mai 2014, 09:53:57 schrieb S?ren Brinkmann:
> On Wed, 2014-05-21 at 06:54PM +0200, Heiko St?bner wrote:
> > Am Mittwoch, 21. Mai 2014, 09:34:10 schrieb S?ren Brinkmann:
> > > Hi Matthias,
> > > 
> > > On Wed, 2014-05-21 at 06:26PM +0200, Matthias Brugger wrote:
> > > > +		compatible = "mediatek,mtk6577-timer";
> > > > +		reg = <0x10008000 0x80>;
> > > > +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> > > > +		clocks = <&system_clk>, <&rtc_clk>;
> > > > +		clock-names = "system-clk", "rtc-clk";
> > > 
> > > I'm still not convinced that the timer IP calls its clock inputs this
> > > way, but well.
> > 
> > Maybe this might convince you ;-)
> > 
> > "The GPT includes 5 32-bit timers and one 64-bit timer. Each timer has 4
> > operation modes, which are ONE-SHOT,  REPEAT,  KEEP-GO and  FREERUN, and
> > can operate on one of the 2 clock sources, RTC clock (32.768kHz) and
> > system clock (13MHz)."
> 
> Is this copied from the timer data sheet or the SOC documentation?

That is from the processor datasheet containing the timer documentation.
I don't think it's customary for soc vendors to provide additional individual 
documentation for self-developed IPs contained in a SoC.
