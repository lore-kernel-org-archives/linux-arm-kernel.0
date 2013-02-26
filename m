From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Feb 2013 16:20:23 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <20130107113411.GV3392@lunn.ch>
References: <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch> <20130104183139.20492204@skate>
 <50E71356.3030203@lunn.ch> <20130104190345.460151d1@skate>
 <50E9EE7A.1080301@free-electrons.com>
 <20130106235312.0839a879@skate> <20130107094747.GR3392@lunn.ch>
 <20130107110712.GT3392@lunn.ch> <20130107122613.64f4ace5@skate>
 <20130107113411.GV3392@lunn.ch>
Message-ID: <20130226162023.3d7b2ffc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 7 Jan 2013 12:34:11 +0100, Andrew Lunn wrote:
> > Image is also with an initramfs + appended DTB. My boot command is:
> > 
> > tftp 1000000 192.168.0.14:uImage.armada-xp-openblocks-ax3-4; bootm
> > 
> > So I'm loading to a different address than you.
> 
> Hi Thomas
> 
> Uboot tells me:
> 
> DRAM:   3 GB
>        CS 0: base 0x00000000 size  1 GB
>        CS 2: base 0x40000000 size  1 GB
>        CS 3: base 0x80000000 size  1 GB
>        Addresses 14M - 0M are saved for the U-Boot usage.
> 
> 1000000 would be towards the beginning of this area reserved for uboot.
> 
> Could you try moving to somewhere outside of the first 14Mbytes and
> see if that helps.

Jumping back on this old topic of the OpenBlocks AX3 not being stable
with 3 GB of RAM for Gr?gory and me, but being stable for you. Could
you check which revision of the Armada XP you have? Is it A0 or B0?

I.e, check the message:

 SoC:   MV78460 B0

in U-Boot. Gr?gory and I are using OpenBlocks AX3 based on the A0
version of the silicon (so the message I copy/pasted above is *not*
from our OpenBlocks, but a different Armada XP board). However,
PlatHome has been shipping since some time B0 revisions. Maybe it could
explain the difference we're seeing?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
