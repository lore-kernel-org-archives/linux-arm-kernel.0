From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 Dec 2009 15:22:34 -0500 (EST)
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
References: <20091207175608.GE26821@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<20091215171440.GA15855@n2100.arm.linux.org.uk>
	<cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
	<cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0912181517120.28241@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Dec 2009, christian pellegrin wrote:

> On Wed, Dec 16, 2009 at 5:35 PM, christian pellegrin <chripell@gmail.com> wrote:
> 
> >
> > I'm trying some more elaborate tests where just one case of
> > inconsistency will stop the counting.
> >
> 
> Here is the program that implements Russell's ideas (at least I think
> so) but is easier to use. By giving the parameter 1 or -1 you can test
> different kind of consistency issues (missing flush in r/w or
> inconsistent mapping's cacheness). It is also quite fun to watch at
> with the buggy kernel on an idle system: it looks like that every
> couple of seconds the 256kb L2 cache get flushed anyway (so even on
> the kernel without the patch every now and then you get some
> progress). I had it running for tens of minutes on a patched kernel
> without stops.

Could you please repost your patch, adding CONFIG_CPU_CACHE_VIVT to the 
conditional code flushing the L2 cache in flush_dcache_page()?

I think this would be a good thing to have merged.  If I'm not mistaken, 
this patch appears to fix all identified coherency cases so far.


Nicolas
