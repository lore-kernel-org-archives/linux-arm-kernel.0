From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 Jan 2011 12:05:17 +0100
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <20110105084014.GN25121@pengutronix.de>
References: <20101230171453.GA5787@pengutronix.de>
	<1293731992.4919.5.camel@heimdal.trondhjem.org>
	<20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
Message-ID: <20110105110517.GQ25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Trond,

On Wed, Jan 05, 2011 at 09:40:14AM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Jan 03, 2011 at 07:22:38PM -0500, Trond Myklebust wrote:
> > The question is whether this is something happening on the server or the
> > client. Does an older client kernel boot without any trouble?
> I will set up a boot test with 2.6.37 (for statistics) and 2.6.36 to
> compare with.  If you don't consider .36 to be old enough let me now.
> Once the setup is done it should be easy to test .35 (say), too.
> 
Marc (cc'd) saw similar[1] problems with .37, when using .36.2 the
problems didn't occur.  This was more reliable to trigger and he was so
kind to bisect the problem.

When testing v2.6.36-rc3-51-gafa8ccc init hanged.
(babddc72a9468884ce1a23db3c3d54b0afa299f0 is the first bad commit with
this hang.)  Commit 56e4ebf877b6043c289bda32a5a7385b80c17dee makes the
"init hangs" problem the "fileid changed on tab" problem.

I could only reproduce that on armv5 machines (imx27, imx28 and at91)
but not on armv6 (imx35).

Best regards
Uwe

[1] similar means: not during boot, but when hitting tab to get command
completion in the shell.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
