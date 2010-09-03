From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Sep 2010 20:29:07 +0100
Subject: [BUG?] rename patch accepted with --dry-run, rejected without
	(Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
In-Reply-To: <20100903184351.GC2341@burratino>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
Message-ID: <20100903192907.GA2978@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 01:43:51PM -0500, Jonathan Nieder wrote:
> (+cc: bug-patch)
> 
> Hi,
> 
> Uwe Kleine-K?nig wrote:
> > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
> 
> >> Using --dry-run is fine, but omitting dry-run gives me:
> >> 
> >> ...
> >> patching file arch/arm/common/clkdev.c
> >> patching file arch/sh/include/asm/clkdev.h
> >> Hunk #1 FAILED at 1.
> >> Hunk #2 FAILED at 11.
> >> 2 out of 2 hunks FAILED -- saving rejects to file
> >> arch/sh/include/asm/clkdev.h.rej
> >> 
> >> I guess this is caused by the last "renaming" hunk, see below.
> 
> Yep, I can reproduce this.  Patch applies with "git apply",
> "patch --dry-run -p1" accepts it, "patch -p1" fails.

git patches include additional metadata for renaming files, which gnu patch
will not understand.

If you want GNU patch compatible diffs, don't use -C or -M when generating
patches out of git.
