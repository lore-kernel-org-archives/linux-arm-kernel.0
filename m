From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 May 2011 15:09:52 +0200 (CEST)
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap
	kernel BSS
In-Reply-To: <20110513112120.GO31483@atomide.com>
References: <20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
	<alpine.LFD.2.00.1105040936040.24613@xanadu.home>
	<20110509111929.GA11410@atomide.com>
	<20110509144949.GE30958@atomide.com>
	<20110512125952.GN31483@atomide.com>
	<alpine.LFD.2.00.1105130930330.2762@xanadu.home>
	<20110513112120.GO31483@atomide.com>
Message-ID: <alpine.LFD.2.00.1105131507150.5787@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 May 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [110513 00:35]:
> > On Thu, 12 May 2011, Tony Lindgren wrote:
> > >
> > > +		str	r1, [sp, #0]		@ save offset into stack
> > 
> > This is actually outside the stack area if you want to be strictly 
> > correct.  Should be "str r1, [sp, #-4]!".
> 
> Thanks, yes we should use it like stack now. Updated patch below.
>  
> > Anyway, both this patch tand the DT append patch won't apply or work 
> > correctly anymore due to my latest cleanup series without minor 
> > adjustments.
> 
> OK, no problem. Got those cleanup patches available somewhere?

They,re available in branch 'zImage_fixes' of git://git.linaro.org/people/nico/linux
and in RMK's devel-stable branch as well.


Nicolas
