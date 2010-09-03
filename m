From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 19:22:01 -0700
Subject: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
	testing
In-Reply-To: <20100903000817.GG11597@atomide.com>
References: <20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<20100902192659.GW11597@atomide.com>
	<20100903000817.GG11597@atomide.com>
Message-ID: <20100903022201.GI11597@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100902 17:00]:
> * Tony Lindgren <tony@atomide.com> [100902 12:20]:
> 
> Heh, turns out there's a bit of a bug in the code snippet above :) It should
> be !((mpidr >> 30) & 1) instead, otherwise it always returns 0.

This too can check for value of 2. Also we probably want to do the
CPU type checks too. Updated patch below.

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smp-cpu.patch
Type: text/x-diff
Size: 2233 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100902/18515d65/attachment.bin>
