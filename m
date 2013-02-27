From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Feb 2013 09:33:53 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <20130227070333.GK17242@lunn.ch>
References: <20130104183139.20492204@skate> <50E71356.3030203@lunn.ch>
 <20130104190345.460151d1@skate>
 <50E9EE7A.1080301@free-electrons.com>
 <20130106235312.0839a879@skate> <20130107094747.GR3392@lunn.ch>
 <20130107110712.GT3392@lunn.ch> <20130107122613.64f4ace5@skate>
 <20130107113411.GV3392@lunn.ch> <20130226162023.3d7b2ffc@skate>
 <20130227070333.GK17242@lunn.ch>
Message-ID: <20130227093353.03e63046@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 27 Feb 2013 08:03:33 +0100, Andrew Lunn wrote:

> > in U-Boot. Gr??gory and I are using OpenBlocks AX3 based on the A0
> > version of the silicon (so the message I copy/pasted above is *not*
> > from our OpenBlocks, but a different Armada XP board). However,
> > PlatHome has been shipping since some time B0 revisions. Maybe it
> > could explain the difference we're seeing?
> 
> Hi Thomas
> 
> My machine is an A0.

Hum, ok, so that doesn't explain the problem.

> I know you recently found some issue with windows. Could that explain
> something?

No, the issue with the window was only that devices can only access the
first 32 bits of the physical address space, so if there is a DRAM CS
configured with a base address higher than 4 GB, then devices shouldn't
configure a window to access this part of the DRAM, because it creates
two overlapping windows (both starting at base 0x0, since in the device
address decoding window registers, the base only has 32 bits, while it
has 35 bits for the SDRAM address decoding registers). And the issue
with window was that the devices were really not working at all. What
we're seeing with the OpenBlocks is some instability: sometimes it
boots, sometimes not.

We're going to discuss this issue further with PlatHome.

Thanks for reporting!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
