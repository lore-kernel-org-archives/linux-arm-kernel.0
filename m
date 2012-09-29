From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Sep 2012 14:58:15 +0000
Subject: ARM SoC tree,
 Was: Re: [PATCH 05/12] ARM: ixp4xx: use __iomem for MMIO
In-Reply-To: <m3lift6rru.fsf_-_@intrepid.localdomain>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-6-git-send-email-arnd@arndb.de>
 <m3lift6rru.fsf_-_@intrepid.localdomain>
Message-ID: <201209291458.16112.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 September 2012, Krzysztof Halasa wrote:
> > I realize it won't make 3.7 any more since the base patches are not
> > in arm-soc, but it's bad if linux-next is broken.
> 
> Well, I'm not aware of any requirement to push my IXP4xx changes
> exclusively through arm-soc. I believe I can still send my tree straight
> to Linus.

No, we don't do that any more, all ARM related changes go either
through arm-soc (for mach-* and plat-* as well as a few related bits)
or through Russell's arm tree (for everything else).

We can make exceptions for stuff that has interdependencies with other
subsystems and can Ack patches if you want to have them included in
another subsystem tree.

> My tree is fairly isolated (with one trivial patch in need of ack from
> Russell, but I can remove that) and, to be honest, I can't see any
> benefit to anyone, caused by sending through intermediate trees. In
> fact, now that I have at last a bit of spare time to work on IXP4xx
> again (acquired some IXP435 devices), such requirement would only mean
> extra workload to me.
> 
> Could you please point me to a statement requiring eg. my changes to go
> through arm-soc?


We've been doing it like this for some time. Stephen Warren replied
to your request to add your tree to linux-next in

http://comments.gmane.org/gmane.linux.kernel/1356118

explaining how it works. Olof sent a mail last week in 

http://lkml.org/lkml/2012/9/21/31

explaining that we're closing the window for 3.7 except for a
few things that were already submitted earlier.

You are definitely welcome to send your pull request for arm-soc
after the merge window so we can integrate it into the 3.8 series,
and please send any bug fixes you have for immediate integration
at any time to arm at kernel.org. There may be a few other things 
in the process that are new to you, but we can work that out.

The arm-soc process is definitely meant to make your life easier
as well as help Linus understand what's going on with all of ARM
to the degree that he needs to know, but it only works if everyone
participates.

	Arnd
