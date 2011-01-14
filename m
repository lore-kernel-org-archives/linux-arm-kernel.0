From: adi@hexapodia.org (Andy Isaacson)
Date: Thu, 13 Jan 2011 18:25:54 -0800
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <1294239193.3014.9.camel@heimdal.trondhjem.org>
References: <20101230171453.GA5787@pengutronix.de>
	<1293731992.4919.5.camel@heimdal.trondhjem.org>
	<20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
	<20110105134045.GS25121@pengutronix.de>
	<1294239193.3014.9.camel@heimdal.trondhjem.org>
Message-ID: <20110114022554.GA17397@hexapodia.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 09:53:13AM -0500, Trond Myklebust wrote:
> > There was a bug in at least -rc5[1] that was considered already fixed in
> > -rc4[2]. The later announcements didn't mention it anymore. 
> > 
> > > I don't know why it's stopped producing the errors, although once it
> > > went I never investigated it any further (was far too busy trying to
> > > get AMBA DMA support working.)
> > It seems it was fixed for most users though. Trond?
> 
> As I said, I can't reproduce it.
> 
> I'm seeing a lot of mention of ARM above. Is anyone seeing this bug on
> x86, or does it appear to be architecture-specific?

I'm seeing processes stuck in D with "fileid changed" in dmesg, on
x86_64 (both server and client).  The repro testcase is to run an
executable off of NFS, recompile it on the server, and then try to tab
complete the executable name.  The client prints

    NFS: server <hostname> error: fileid changed
    fsid 0:18: expected fileid 0x107aa4a, got 0x107ad3e

and /bin/zsh hangs in D.

My server is running 2.6.36.1, filesystem is ext3 on sda3 on AHCI,
client is currently running 2.6.37-rc1.  I'm assuming that 37a09f will
fix it.

-andy
