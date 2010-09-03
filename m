From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Sep 2010 21:33:09 +0200
Subject: [BUG?] rename patch accepted with --dry-run, rejected without
	(Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
In-Reply-To: <20100903192907.GA2978@n2100.arm.linux.org.uk>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<20100903192907.GA2978@n2100.arm.linux.org.uk>
Message-ID: <20100903193309.GC29821@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Russell,

On Fri, Sep 03, 2010 at 08:29:07PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 03, 2010 at 01:43:51PM -0500, Jonathan Nieder wrote:
> > Uwe Kleine-K?nig wrote:
> > > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
> > 
> > >> Using --dry-run is fine, but omitting dry-run gives me:
> > >> 
> > >> ...
> > >> patching file arch/arm/common/clkdev.c
> > >> patching file arch/sh/include/asm/clkdev.h
> > >> Hunk #1 FAILED at 1.
> > >> Hunk #2 FAILED at 11.
> > >> 2 out of 2 hunks FAILED -- saving rejects to file
> > >> arch/sh/include/asm/clkdev.h.rej
> > >> 
> > >> I guess this is caused by the last "renaming" hunk, see below.
> > 
> > Yep, I can reproduce this.  Patch applies with "git apply",
> > "patch --dry-run -p1" accepts it, "patch -p1" fails.
> 
> git patches include additional metadata for renaming files, which gnu patch
> will not understand.
> 
> If you want GNU patch compatible diffs, don't use -C or -M when generating
> patches out of git.
Still GNU patch should then already fail in --dry-run mode.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
