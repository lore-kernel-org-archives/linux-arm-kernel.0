From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Dec 2011 16:33:38 +0100
Subject: [PATCH v2] ARM: net: JIT compiler for packet filters
In-Reply-To: <20111219152418.GF2031@linaro.org>
References: <1324284030-25540-1-git-send-email-mgherzan@gmail.com>
 <20111219125021.GA2031@linaro.org>
 <20111219151958.GU24496@pengutronix.de>
 <20111219152418.GF2031@linaro.org>
Message-ID: <20111219153338.GV24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Dec 19, 2011 at 03:24:18PM +0000, Dave Martin wrote:
> On Mon, Dec 19, 2011 at 04:19:58PM +0100, Uwe Kleine-K?nig wrote:
> > On Mon, Dec 19, 2011 at 12:50:21PM +0000, Dave Martin wrote:
> > > On Mon, Dec 19, 2011 at 09:40:30AM +0100, Mircea Gherzan wrote:
> > > > Based of Matt Evans's PPC64 implementation.
> > > Note that it's fine to have the JIT generating ARM code, even if the rest
> > > if the kernel is Thumb-2.  This would only start to cause problems if we
> > > want to do things like set kprobes in the JITted code, or unwind out of
> > > the JITted code.
> > or use a CPU that doesn't speak ARM (e.g. v7M)
> 
> Indeed... I was assuming though that that would be out of scope for the
> first iteration of this code.
Right, depending on !THUMB2 is fine. Only generating ARM code with
THUMB2=y is not.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
