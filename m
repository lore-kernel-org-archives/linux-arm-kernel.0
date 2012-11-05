From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Nov 2012 21:46:56 +0800
Subject: scheduler clock for MXS [Was: Re: Wakeup latency measured with
 SCHED_TRACER depends on HZ]
In-Reply-To: <50978370.9060001@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
Message-ID: <20121105134655.GB27260@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 10:14:24AM +0100, Stanislav Meduna wrote:
> On 05.11.2012 03:57, Shawn Guo wrote:
> 
> >> The patch in attach fixes this. I can only test the MX28 part -
> >> I don't have any timrot_is_v1() (MX23) hardware and I don't
> >> know whether a source that wraps after ~2 seconds is OK at all.
> > 
> > From my quick testing on imx23 with printk timestamp, it's not OK,
> > so we may need to leave imx23 out there.
> 
I should say it's practically not OK since it wraps in such a short
period.  But it actually works as expected.

> Hmm, does it wrap after 2 seconds?

Yes, it does wrap after ~2 seconds.

> From my grepping and googling
> the code should now adapt itself, the hardcoded limit is gone...
> What does the dmesg line such as
> 
>   sched_clock: 32 bits at 32kHz, resolution 31250ns,
>     wraps every 134217727ms
> 
> output on that hardware?
> 
Yes, something like:

  sched_clock: 16 bits at 32kHz, resolution 31250ns, wraps every 2047ms

Shawn
