From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 14 May 2010 09:51:22 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <20100513151245.GA21251@quack.suse.cz>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<20100512150057.GA29867@atrey.karlin.mff.cuni.cz>
	<1273709714.21352.138.camel@pasglop>
	<20100513151245.GA21251@quack.suse.cz>
Message-ID: <1273794682.21352.199.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-13 at 17:12 +0200, Jan Kara wrote:

> If you look at the array more in detail, you'll notice that 'offs' part of
> structure is sometimes identical. That should never happen because 'offs'
> contains offset of the corresponding directory entry in a block. So when
> offsets are identical in this array, subsequent move will copy some entries
> several times and leave entries that should be moved in the old block,
> resulting in a corruption we see.
>   The question is, how could offsets be the same? dx_make_map seems to get
> it right and dx_sort_map as well. Maybe I'd peek into disassembly of
> dx_sort_map to see whether swap() macro does what it should... If that
> looks OK, you could try adding some debug checks into dx_sort_map and try
> to catch the moment when duplicate offsets are created...

Ok so a very quick test with another compiler and the problem -appears-
gone. I'll investigate more in depth later tonight or this week-end.

Looks like it may all have been a false alarm, just don't use
gcc-4.4.0 :-)

Cheers,
Ben.
