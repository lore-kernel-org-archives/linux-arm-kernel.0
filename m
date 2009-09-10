From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 10 Sep 2009 15:09:59 +0200
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <Pine.LNX.4.64.0909101459370.4458@axis700.grange>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
	<20090910115439.GU9410@buzzloop.caiaq.de>
	<f17812d70909100523l5936e11bpd41354aed622d480@mail.gmail.com>
	<20090910123218.GV9410@buzzloop.caiaq.de>
	<f17812d70909100535r36b62ad5r2c32e2dcecba0c93@mail.gmail.com>
	<20090910124401.GW9410@buzzloop.caiaq.de>
	<Pine.LNX.4.64.0909101459370.4458@axis700.grange>
Message-ID: <20090910130959.GY9410@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 03:05:51PM +0200, Guennadi Liakhovetski wrote:
> On Thu, 10 Sep 2009, Daniel Mack wrote:
> 
> > I agree, and it would be even better to only set that field in case the
> > driver has actually been probed (and not just enabled in the kernel
> > config). But I see no clean way to do that - the gcu driver has no
> > access to the framebuffer driver and its data structs either.
> 
> Yeah, that doesn't look pretty. Maybe add a field to struct 
> pxafb_mach_info? You can put its assignment in respective platform data 
> instances under an #ifdef - that's more acceptable, IMHO. Of course, it is 
> still worse than beeing able to switch this at run-time. But you could 
> trick by setting that field at run-time if acceleration is available, 
> provided you have that info before pxafb initialises. Also consider, there 
> might be more PXA SoCs in the future using pxafb and providing hardware 
> acceleration.

Jep, that's a good idea. Will send a new patch for that later.

Thanks,
Daniel
