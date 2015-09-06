From: ijc@debian.org (Ian Campbell)
Date: Sun, 06 Sep 2015 13:11:44 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20150905210846.GF6040@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
Message-ID: <1441541504.23553.46.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-09-05 at 23:08 +0200, Andrew Lunn wrote:
> On Fri, Aug 21, 2015 at 01:24:17PM +0100, Ian Campbell wrote:
> > Hi kirkwood-upstream,
> > 
> > We (Debian) have had a couple of reports of I/O errors running 
> Debian
> > on kirkwood, specifically it seems to relate to later kernels (e.g.
> > 4.0+) and I _suspect_ (without proof) that it may be due to the 
> switch
> > from board files to the DTS based kernel, or some change implied by
> > this (e.g. different SATA driver now or timeouts have changed
> > perhaps?).
> 
> Hi Ian
> 
> I've not reproduced this exactly, but something similar.

It sounds likely to be the same underlying issue.

> I do a find / and in parallel a cat /dev/mtdblock3 > /dev/null

FYI it was reported this morning[0] that using flashcp doesn't exhibit
this behaviour. Since AIUI flashcp goes directly at the /dev/mtdN
device, rather than via mtdblockN, this seems to point towards
something in the mtdblock layer perhaps?

> While the cat is active, the find grinds to a halt. I don't get any
> SATA timeouts, but that could be because /dev/mtdblock3 is small
> enough that the timers don't expire.

Agreed.

Thanks,
Ian.

[0] http://article.gmane.org/gmane.linux.debian.ports.arm/15767

> So i will now try to track down if there is a lock getting contended,
> or at least why only the cat process makes progress.
> 
>    Andrew
> 
> 
