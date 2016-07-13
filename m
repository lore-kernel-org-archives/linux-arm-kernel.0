From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2016 10:02:46 +0100
Subject: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160610145323.GO27142@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop> <20160609114107.GB1388@dell>
 <20160610131855.GG27142@ulmo.ba.sec> <20160610140635.GC1537@dell>
 <20160610145323.GO27142@ulmo.ba.sec>
Message-ID: <20160713090246.GA11154@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2016, Thierry Reding wrote:
> On Fri, Jun 10, 2016 at 03:06:35PM +0100, Lee Jones wrote:
> > On Fri, 10 Jun 2016, Thierry Reding wrote:
> > 
> > > > > > The second documentation adaption entails adding support for PWM
> > > > > > capture devices.  A new clock is required as well as an IRQ line.
> > > > > > We're also adding a new property similar to the one described
> > > > > > above, but for capture channels.  Typically, there will be less
> > > > > > capture channels than PWM-out, since all channels have the latter
> > > > > > capability, but only some have capture support.
> > > > > 
> > > > > Humm, sounds like all of this should be implied from compatible strings.
> > > > 
> > > > You mean have a bunch of of_machine_is_compatibles() scattered around?
> > > 
> > > I don't understand why you need this at all. Quite frankly I don't even
> > > know why st,pwm-num-devs exists. I probably missed it back at the time.
> > > Usually, like Rob suggests, this should be inferred from the compatible
> > > string. One commonly used way to avoid scattering explicit checks for
> > > the compatible string is to add this information to the of_device_id
> > > table. See a bunch of existing drivers for reference.
> > 
> > Yes, I am aware of the strategy, and happy to oblige if this is your
> > suggestion.  I'll move all platform data into the driver and eradicate
> > the DT properties.
> 
> Great!

Sorry it's taken so long to get back around to this.

So I just had a crack at implementing this solution and ran into
issues.  Unfortunately, the configuration isn't easy to describe using
compatible strings.

Unless we are prepared to have strings like:

  st,sti-pwm-stih407-pwm0
  st,sti-pwm-stih407-pwm1
  st,sti-pwm-stih416-pwm0
  st,sti-pwm-stih416-pwm1

Or perhaps:

  st,sti-pwm-4out-2cpt
  st,sti-pwm-1out-1cpt

... since some of the PWMs have an odd number of OUT and CPT
channels/devices.  In my opinion however, this is ugly.  I don't think
we do this for any other type of channel/device/port etc, do we?

Personally I think there isn't anything wrong with having DT
properties describing how many channels/devices there are, but I'm
okay with whatever you both decide.  No skin of my nose really. :)

What say you?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
