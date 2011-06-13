From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jun 2011 03:49:41 -0700
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap
	kernel BSS
In-Reply-To: <alpine.LFD.2.00.1106120209450.2142@xanadu.home>
References: <20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
	<alpine.LFD.2.00.1105040936040.24613@xanadu.home>
	<20110509111929.GA11410@atomide.com>
	<20110509144949.GE30958@atomide.com>
	<20110512125952.GN31483@atomide.com>
	<alpine.LFD.2.00.1105130930330.2762@xanadu.home>
	<20110513112120.GO31483@atomide.com>
	<alpine.LFD.2.00.1106120209450.2142@xanadu.home>
Message-ID: <20110613104940.GF10951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110611 23:09]:
> On Fri, 13 May 2011, Tony Lindgren wrote:
> 
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Thu, 12 May 2011 05:29:49 -0700
> > Subject: [PATCH] ARM: zImage: Make sure appended device tree data won't overlap kernel BSS
> > 
> > Do this before relocating the compressed kernel + device tree data.
> > Otherwise we would have to split the copying into two parts, or copy
> > the device tree data twice.
> > 
> > As we only have one register available, pass the size of kernel BSS
> > via linker and do the calculation using r1, then save it to the stack.
> > 
> > Note that this patch now makes the stack also usable earlier for
> > CONFIG_ARM_APPENDED_DTB.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> [...]
> 
> Please tell me what you think of this alternative: 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/120182
> I think it is a cleaner solution.

Yeah that's nice, I acked that one in the thread.

Regards,

Tony
