From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 16 Feb 2012 21:01:43 +0100
Subject: [RFC PATCH 00/11] Cortex-M3 support
In-Reply-To: <20120207201810.GF8621@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
 <20120207201810.GF8621@pengutronix.de>
Message-ID: <20120216200143.GS14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 09:18:10PM +0100, Uwe Kleine-K?nig wrote:
> On Sun, Jan 22, 2012 at 12:12:30PM +0100, Uwe Kleine-K?nig wrote:
> > this series is mostly a port of patches done by Catalin Marinas for
> > 2.6.33. It's based on 3.3-rc1. There are still a few rough edges and I'm
> > sure I'm not aware of all of them as this deep architecture stuff is
> > mostly news for me. Some things are noted in the respective patches, I'm
> > sure you can find more.
> > 
> > My target machine is the EFM32 Giant Gecko by Energy Micro and my
> > complete tree can be found at
> > 
> > 	git://git.pengutronix.de/git/ukl/linux.git efm32
> > 
> > (with a gitweb being available at
> > 
> > 	http://git.pengutronix.de/?p=ukl/linux.git;a=shortlog;h=efm32
> > 
> > ).
> > 
> > I look forward to your comments.
> I didn't get much comments apart from a few trivial ones. I'd like to
> plan how to go forward here.
> 
> Catalin, Russell, I guess it's just lack of time on your side that you
> didn't comment?
> 
> There are a few things to fix and follow up (e.g. platform support,
> ftrace, adapt unwinding to the v7m model), but I first want to see the
> base patches in before I invest the time to address these.
I improved a few things, most notably I fixed a stack overflow. Other
than that the following changes are included, too:

 - update to 3.3-rc3
 - only check bit 3 of lr to determine which mode the machine was in
   when the current exception triggered
 - several updates to the efm32 platform (that should IMHO only go in
   when the M3 support is available in mainline)

I'd be really happy to get some feedback on Catalin's and my patches and
will repost the patches I think are mature enough to go in for a start.

The updated and complete stack is available from the URLs above.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
