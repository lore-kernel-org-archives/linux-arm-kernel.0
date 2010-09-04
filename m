From: agruen@suse.de (Andreas Gruenbacher)
Date: Sat, 4 Sep 2010 23:33:51 +0200
Subject: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <20100904000348.GA7498@n2100.arm.linux.org.uk>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<20100903193309.GC29821@pengutronix.de>
	<20100904000348.GA7498@n2100.arm.linux.org.uk>
Message-ID: <201009042333.51419.agruen@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 04 September 2010 02:03:48 Russell King - ARM Linux wrote:
> As I say, it's because GNU patch doesn't (currently) understand GIT
> patches.  I wouldn't call that a bug in GNU patch.

GNU patch in the version used does understand GIT patch headers and does 
support things like renames.

The --dry-run option often will not work when the same file is modified more 
than once in the same patch, though.  This is because GNU patch doesn't 
remember the intermediary states of files.

In this case, the patch itself is broken.

Andreas
