From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 Jan 2011 14:40:45 +0100
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <20110105112701.GA8638@n2100.arm.linux.org.uk>
References: <20101230171453.GA5787@pengutronix.de>
	<1293731992.4919.5.camel@heimdal.trondhjem.org>
	<20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
Message-ID: <20110105134045.GS25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Jan 05, 2011 at 11:27:01AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 05, 2011 at 12:05:17PM +0100, Uwe Kleine-K?nig wrote:
> > Hello Trond,
> > 
> > On Wed, Jan 05, 2011 at 09:40:14AM +0100, Uwe Kleine-K?nig wrote:
> > > On Mon, Jan 03, 2011 at 07:22:38PM -0500, Trond Myklebust wrote:
> > > > The question is whether this is something happening on the server or the
> > > > client. Does an older client kernel boot without any trouble?
> > > I will set up a boot test with 2.6.37 (for statistics) and 2.6.36 to
> > > compare with.  If you don't consider .36 to be old enough let me now.
> > > Once the setup is done it should be easy to test .35 (say), too.
> > > 
> > Marc (cc'd) saw similar[1] problems with .37, when using .36.2 the
> > problems didn't occur.  This was more reliable to trigger and he was so
> > kind to bisect the problem.
> > 
> > When testing v2.6.36-rc3-51-gafa8ccc init hanged.
> > (babddc72a9468884ce1a23db3c3d54b0afa299f0 is the first bad commit with
> > this hang.)  Commit 56e4ebf877b6043c289bda32a5a7385b80c17dee makes the
> > "init hangs" problem the "fileid changed on tab" problem.
> > 
> > I could only reproduce that on armv5 machines (imx27, imx28 and at91)
> > but not on armv6 (imx35).
> 
> FYI, I've seen the "fileid changed" problem, and it looked like a 32-bit
> truncation of the fileid.  It occurred several times on successive
> reboots, so I tried to capture a tcpdump trace off the server (Linux
> 2.6.23-rc8-ga64314e6 - its ancient because I've had issues with buggy
> IDE drivers trying to move it forward.)  However, for the last couple
> of weeks I've been unable to reproduce it.
> 
> The client was based on 2.6.37-rc6.
> 
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

Uwe

[1] http://lwn.net/Articles/418963/
[2] http://lwn.net/Articles/417704/
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
