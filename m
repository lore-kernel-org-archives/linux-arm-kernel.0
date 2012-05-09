From: rubini@gnudd.com (Alessandro Rubini)
Date: Wed, 9 May 2012 10:41:02 +0200
Subject: Handling of modular boards
In-Reply-To: <CACRpkdbyp=BNGn8Eub6vcAgB9CS5PhYcGt2foi8kNxA3oU5Fzg@mail.gmail.com>
References: <CACRpkdbyp=BNGn8Eub6vcAgB9CS5PhYcGt2foi8kNxA3oU5Fzg@mail.gmail.com>
 <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <4FA432E9.9050606@wwwdotorg.org>
 <20120504204455.GR14230@opensource.wolfsonmicro.com>
Message-ID: <20120509084102.GA16228@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

>> This is another issue - a similar set of problems does apply to some PCI
>> type cards where the PCI device is essentially a bridge to a typical
>> embedded system - though practically speaking it's much less severe.
> 
> I think Alessandro is working on a board like that right now, so looping
> in Ale to this discussion to get his attention...

> I think Alessandro is working on a board like that right now, so looping
> in Ale to this discussion to get his attention...

Yes, that's it. The vendor of my thing has wrapped everything under
pci headers, so the "typical embedded system", which actually is a
demasculated ARM SoC is self-described by PCI (no need for device tree)

A previous poster said:
>>> b) Doesn't integrate well with hotplug; the DT for the board
>>> configuration is static at boot. What if a board can be unplugged and
>>> another plugged in; a reboot or similar would be needed to adjust the
>>> kernel to this.

I think you need some enumeration mechanism in this case. Actually, I
think this will become common in the near future, as you can reprogram
your FPGA devices while the system runs.

The issue is real, and I'm involved in a self-description project; it
allows to use the well-known bus abstraction (with bus controller,
devices, drivers) to ease handling soft cores that may come and go
while the system is alive.

Thank you Linus for involving me, I'll now go to read the whole thread
/alessandro
