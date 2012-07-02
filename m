From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Jul 2012 11:26:52 +0200
Subject: [PATCH v5] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <4FF16919.3090302@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <4FEB2CC3.7090305@codethink.co.uk> <20120702103016.28b2637e@skate>
 <4FF16797.8070405@codethink.co.uk> <20120702111947.2ce2b3cc@skate>
 <4FF16919.3090302@codethink.co.uk>
Message-ID: <20120702112652.77d5abbe@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 02 Jul 2012 10:25:45 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> Ah, thank you. I had it updating the dtb with the ATAGS before
> parsing the device tree in my previous setup.
> 
> Anyone looking into fixing the problem where it goes bang without
> a useful error message if there has been no memory registered?

Well, to some extent, the message:

Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

is a quite good indication that a memory allocation "below 0x0" is
failing, which so early in this boot, most likely means that you don't
have memory at all :-)

But yes, maybe there could be a more useful check at some point in the
boot process.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
