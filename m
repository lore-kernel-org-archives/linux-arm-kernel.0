From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 14 Aug 2017 20:40:42 +0200 (CEST)
Subject: [PATCH] ARM: bcm2836: Send event when onlining other cores
In-Reply-To: <1168905996.270506.1502730695418@email.1und1.de>
References: <1502190295-53391-1-git-send-email-phil@raspberrypi.org>
 <1502190295-53391-2-git-send-email-phil@raspberrypi.org>
 <fdecf317-d20b-1a5d-046f-56ef40c55d82@gmail.com>
 <1168905996.270506.1502730695418@email.1und1.de>
Message-ID: <399697756.271804.1502736043014@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 14. August 2017 um 19:11 geschrieben:
> 
> 
> Hi Florian,
> 
> > Florian Fainelli <f.fainelli@gmail.com> hat am 14. August 2017 um 18:25 geschrieben:
> > 
> > 
> > 
> > 
> > On 08/08/2017 04:04 AM, Phil Elwell wrote:
> > > Secondary cores should enter a low-power idle state when waiting to
> > > be started. The "wfe" instruction causes a core to wait until an event
> > > or interrupt arrives before continuing to the next instruction, and
> > > the "sev" instruction sends a wakeup event to the other cores.
> > > 
> > > Add an "sev" (and a memory barrier) to bcm2836_boot_secondary, the
> > > function that wakes the waiting cores during booting. This is required
> > > if the secondary cores are sitting in "wfe", and harmless if not.
> > 
> > Eric, should I just pick this up for the upcoming ARM SoC pull requests
> > that I am preparing, or do you have more changes aside from the two tags
> > I already merged?
> 
> this patch depends on series "ARM: bcm2836: Move SMP startup code to arch/arm".
> 
> I didn't had the time to test Phil's patch in all relevant cases. But i could at least prepare a branch with my changes with the acks.

i prepared the branches bcm2835-dt-next-v2 and bcm2835-soc-next.

Stefan
