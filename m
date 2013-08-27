From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 27 Aug 2013 03:48:51 +0000
Subject: [PATCH 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM
In-Reply-To: <521BB40D.7040001@wwwdotorg.org>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
 <1473340.OXSHEp7d4P@flatron>
 <1DD289F6464F0949A2FCA5AA6DC23F827D2244@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130822062610.GR31036@pengutronix.de> <20130823073612.GB3535@ulmo>
 <5217B807.7020800@wwwdotorg.org>
 <1DD289F6464F0949A2FCA5AA6DC23F827E11AC@039-SN2MPN1-012.039d.mgd.msft.net>
 <521BB40D.7040001@wwwdotorg.org>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827E61F2@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


> Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for
> Freescale FTM PWM
> 
> On 08/25/2013 11:35 PM, Xiubo Li-B47053 wrote:
> >> Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for
> ...
> >>> Why do you need to manipulate the pinctrl to en/disable a channel?
> >>
> >> This is because in Vybrid VF610 TOWER board, there are 4 leds, and
> >> each led's one point(diode's positive pole) is connected to 3.3V, and
> >> the other point is connected to pwm's one channel. When the 4
> >> pinctrls are configured as enable at the same time, the 4 pinctrls is
> >> low valtage, and the 4 leds will be lighted up as default, then when
> >> you enable/disable one led will effects others.
> >>
> >> These pinctrls are belong to pwm, and I don't think led or other
> >> customer could control them directly.
> >> So, here I authorize the 4 pinctrls to each channel controls.
> >>
> > "
> > For the reason above, I have to control the pinctrls separately.
> >
> > If all the pinctrls set as default state, the 8 pinctrls must be
> controlled together.
> > And the 4 leds will all be lighted up as default and will influence
> each other.
> 
> Sorry, that still doesn't make much sense. Either way though, having
> separate pinctrl setup for a single device isn't going to work. You'll
> either need to have all combinations of 4 (8?) PWMs represented as
> pinctrl states(!), or register separate PWM devices so that they get
> independant pinctrl states.
>
Well, I have ever thought about registering separate PWM device for each channel.
But, if so, how should I control the pinctrl of each PWM(actually one channel of FTM PWM) ?
I must select "default" state(the "default" state here, the pinctrl must be setup as "dsN" or "chN-idle" state we discussed before) when probing, and when customers .request-->.config-->.enable the PWM I also must select an "active" state to config the pinctrl...
Thus, this is still not static. I think this isn't much different from the current.

Also if having all combinations of 8 PWMs represented as pinctrl states, how could I deal with the problem about LEDs ?



Thanks very much,

--
Best Regards,
Xiubo
