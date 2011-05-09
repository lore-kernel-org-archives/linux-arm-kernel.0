From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2011 17:49:50 +0300
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap
	kernel BSS
In-Reply-To: <20110509111929.GA11410@atomide.com>
References: <20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
	<alpine.LFD.2.00.1105040936040.24613@xanadu.home>
	<20110509111929.GA11410@atomide.com>
Message-ID: <20110509144949.GE30958@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110509 14:16]:
> Do this before relocating the compressed kernel + device tree data.
> Otherwise we would have to split the copying into two parts, or copy
> the device tree data twice.
> 
> As we only have one register available, pass the size of kernel BSS
> via linker and do the following calculation using r1.

Blah, this still needs a bit more work.. The calculation is wrong
and we can get multiple relocations now.

Tony
