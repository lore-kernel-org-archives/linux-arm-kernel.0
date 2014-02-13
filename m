From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Feb 2014 19:53:17 +0000
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140213182654.GA20043@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <20140213110721.GC13576@mudshark.cambridge.arm.com>
 <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
 <4110788.UI9TADVhpa@wuerfel>
 <20140213182654.GA20043@obsidianresearch.com>
Message-ID: <20140213195317.GQ13576@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 06:26:54PM +0000, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2014 at 05:28:20PM +0100, Arnd Bergmann wrote:
> 
> > > Huh?  The reg property clearly has the size in it (as shown in the
> > > example below).  I guess I was just asking for the description
> > > here to say what the size was for the 2 compatibles since its
> > > fixed and known.
> > 
> > It's still an open question whether the config space in the reg
> > property should cover all 256 buses or just the ones in the
> > bus-range. In the latter case, it would be variable (but
> > predictable) size.
> 
> The 'describe the hardware principle' says the reg should be the
> entire available ECAM/CAM region the hardware is able to support.
> 
> This may be less than 256 busses, as ECAM allows the implementor to
> select how many upper address bits are actually supported.

Ok, but the ECAM/CAM base always corresponds to bus 0, right?

> IMHO, the bus-range should be used to indicate the range of busses
> discovered by the firmware, but we have historically tweaked it to
> indicate the max range of bus numbers available on this bus (I think
> to support the hack where two physical PCI domains were roughly glued
> into a single Linux domain).

Ok, so this answers Kumar's point about the reg property. I'll augment it
with a size.

Will
