From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 22 Sep 2010 08:52:18 -0300
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <AANLkTik6Nwt3O9hG971nzzEtiCLobSaWasZ4hjWCketh@mail.gmail.com>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>
	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>
	<1285106546.30449.158.camel@pasglop>
	<AANLkTik6Nwt3O9hG971nzzEtiCLobSaWasZ4hjWCketh@mail.gmail.com>
Message-ID: <6ff62ca4-128a-436f-b85a-987849804a6e@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



"Shaju Abraham" <shajuabraham@gmail.com> wrote:

>On Wed, Sep 22, 2010 at 3:32 AM, Benjamin Herrenschmidt
><benh@kernel.crashing.org> wrote:
>> The main grief one could have with my scheme is the naming of irq_host
>> which has confused people in the past. It should probably be irq_domain
>> to make clear what it is. It generally have a 1:1 relationship to the
>> irq_chip but there are cases where that isn't the case (essentially
>> where you have multiple irq_chip per domain) for various reasons so it's
>> better to keep those separate.
>>
>
>How do we handle multiplexed interrupts ? For example a single interrupt line
>representing multple irq sources.
>We have ARM systems with  single interrupt line on a VIC  muxed to
>192 different GPIO sources (each capable of generating interrupts). For such a
>system the virq to hw irq mapping can get complex.

Assign a separate irq number to each gpio.  In effect, this makes the gpio controller an irq controller.

g.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
