From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 26 Sep 2010 00:08:57 +0100
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <20100924150608.GB30666@sirena.org.uk>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>	<alpine.LFD.2.00.1009212342580.2416@localhost6.localdomain6>	<AANLkTinrfJkK85v2epOY95YWaVyMBcxSF2xakHqsM7vh@mail.gmail.com>	<1285133481.30449.170.camel@pasglop>	<AANLkTik8tGUwbch4OLShac8AqMu5+A9XgOk4uAZsYjxs@mail.gmail.com>	<4C9BE69C.9070609@fluff.org>
	<20100924150608.GB30666@sirena.org.uk>
Message-ID: <4C9E8109.2000408@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/10 16:06, Mark Brown wrote:
> On Fri, Sep 24, 2010 at 12:45:32AM +0100, Ben Dooks wrote:
>> On 22/09/10 09:59, Eric Miao wrote:
> 
>>>> And i2c in many cases want to be called from sleep'able context... might
>>>> be a good idea to restrict some of these to threaded interrupts. A whole
>>>> different discussion I suppose.
> 
>> The i2c case, it is generally the code decoding the interrupt that needs
>> to do this, and is part of the i2c specific driver, and is written as
>> some form of thread or work-queue.
> 
> The standard thing these days is a threaded IRQ handler.

Yes, however my first point was really do we care the method
for the interrupt's detection when talking about mapping them?
