From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Sep 2010 01:03:48 +0100
Subject: [BUG?] rename patch accepted with --dry-run, rejected without
	(Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
In-Reply-To: <20100903193309.GC29821@pengutronix.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<20100903192907.GA2978@n2100.arm.linux.org.uk>
	<20100903193309.GC29821@pengutronix.de>
Message-ID: <20100904000348.GA7498@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 09:33:09PM +0200, Uwe Kleine-K?nig wrote:
> > git patches include additional metadata for renaming files, which gnu patch
> > will not understand.
> > 
> > If you want GNU patch compatible diffs, don't use -C or -M when generating
> > patches out of git.
> Still GNU patch should then already fail in --dry-run mode.

And now look at the patch - it touches arch/sh/include/asm/clkdev.h twice.
Once to remove it and once as a rename.

GNU patch not in --dry-run mode will first remove arch/sh/include/asm/clkdev.h,
and then not have a file to deal with when it tries to patch the rename
part.  Whereas with --dry-run, the file stays around.

As I say, it's because GNU patch doesn't (currently) understand GIT
patches.  I wouldn't call that a bug in GNU patch.
