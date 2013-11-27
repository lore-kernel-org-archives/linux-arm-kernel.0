From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Nov 2013 12:52:42 -0800
Subject: [PATCH 1/2] arm: socfpga: Add clock for smp_twd timer
In-Reply-To: <1380656155.13502.10.camel@linux-builds1>
References: <1379435541-26338-1-git-send-email-dinguyen@altera.com>
 <524B2119.3020702@gmail.com> <1380656155.13502.10.camel@linux-builds1>
Message-ID: <20131127205242.16819.8437@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dinh Nguyen (2013-10-01 12:35:55)
> On Tue, 2013-10-01 at 14:23 -0500, Rob Herring wrote:
> > On 09/17/2013 11:32 AM, dinguyen at altera.com wrote:
> > > From: Dinh Nguyen <dinguyen@altera.com>
> > > 
> > > Assign a clock for the twd-timer.
> > > 
> > > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > Cc: Pawel Moll <pawel.moll@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > Cc: Ian Campbell <ian.campbell@citrix.com>
> > > CC: linux-arm-kernel at lists.infradead.org
> > > ---
> > >  arch/arm/boot/dts/socfpga.dtsi |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > > index acd6c3a..e28df94 100644
> > > --- a/arch/arm/boot/dts/socfpga.dtsi
> > > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > > @@ -480,11 +480,11 @@
> > >                     clock-names = "biu", "ciu";
> > >             };
> > >  
> > > -           /* Local timer */
> > > -           timer at fffec600 {
> > > +           local-timer at fffec600 {
> > 
> > timer was the right name.
> 
> I'll put it back...
> 
> > 
> > >                     compatible = "arm,cortex-a9-twd-timer";
> > >                     reg = <0xfffec600 0x100>;
> > >                     interrupts = <1 13 0xf04>;
> > > +                   clocks = <&mpu_periph_clk>;
> > 
> > Otherwise, this looks fine and I wouldn't expect much input on a change
> > that doesn't add a new binding.
> > 
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Thanks Rob!

Looks good to me too. Can you respin it with the fix for 'timer' and
I'll take it in?

Thanks,
Mike

> 
> Dinh
> > 
> > Rob
> > 
> > >             };
> > >  
> > >             timer0: timer0 at ffc08000 {
> > > 
> > 
> > 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
