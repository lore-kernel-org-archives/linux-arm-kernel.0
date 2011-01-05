From: rees@umich.edu (Jim Rees)
Date: Wed, 5 Jan 2011 09:29:02 -0500
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <20110105134045.GS25121@pengutronix.de>
References: <20101230171453.GA5787@pengutronix.de>
	<1293731992.4919.5.camel@heimdal.trondhjem.org>
	<20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
	<20110105134045.GS25121@pengutronix.de>
Message-ID: <20110105142902.GA9278@merit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:

  > The "fileid changed" messages popped up after mounting an export with
  > 'nolock,intr,rsize=4096,soft', and then trying to use bash completion
  > and 'ls' in a few subdirectories - and entries were missing from the
  > directory lists without 'ls' reporting any errors (which I think is bad
  > behaviour in itself.)
  There was a bug in at least -rc5[1] that was considered already fixed in
  -rc4[2]. The later announcements didn't mention it anymore. 
  
  > I don't know why it's stopped producing the errors, although once it
  > went I never investigated it any further (was far too busy trying to
  > get AMBA DMA support working.)
  It seems it was fixed for most users though. Trond?

Trond sent a fix to the nfs list on 27 Nov for "fileid changed" but I don't
know if this is the same bug you're seeing.  The patch was to
nfs_same_file() and I can send it if you want.  As far as I know the patch
made it upstream.
