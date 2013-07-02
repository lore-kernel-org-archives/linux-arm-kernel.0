From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Jul 2013 13:38:21 -0400
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <87vc4sho7j.fsf@natisbad.org>
References: <87fvvzfh70.fsf@natisbad.org>
 <20130702124639.GI19937@titan.lakedaemon.net>
 <87vc4sho7j.fsf@natisbad.org>
Message-ID: <20130702173821.GE17110@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 07:21:52PM +0200, Arnaud Ebalard wrote:
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> >>  - G762 PWM fan controller on I2C bus: it requires G762 driver which
> >>    is *currently sitting in hwmon maintainer tree* and will be available
> >>    in 3.11. Jason, as a side note I have a short patch for available for
> >>    ReadyNAS Duo v2 .dts file (the device also has a G762). I can hold
> >>    it until rc cycle if you prefer.
> >
> > Nope, post patches when you have them ready.  I am capable of holding
> > them until -rc1 drops ;-)
> 
> That's the one I sent yesterday (the patch tagged RESEND, i.e. w/o the
> fixes for space issue in .dts file)

Yep, I have it queued up.

> >> +			i2c at 11000 {
> >> +				compatible = "marvell,mv64xxx-i2c";
> >> +				clock-frequency = <100000>;
> >> +				status = "okay";
> >> +
> >> +				isl12057: isl12057 at 68 {
> >> +					compatible = "isil,isl12057";
> >> +					reg = <0x68>;
> >> +					wakeup-source;
> >> +				};
> 
> My main question is for ISL12057 RTC chip: I guess it's just pointless to
> push the .dts file for the RN102 w/o a working RTC clock?

Not necessarily.  Support for the rtc can be done in a follow on patch
once you have the driver mainlined.

I have a bunch of boards that boot up and think it's 1970...

Afterall, the mirabox doesn't have nand support :-P

thx,

Jason.
