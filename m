From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Sep 2010 22:45:27 +0100
Subject: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <201009042333.51419.agruen@suse.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<20100903193309.GC29821@pengutronix.de>
	<20100904000348.GA7498@n2100.arm.linux.org.uk>
	<201009042333.51419.agruen@suse.de>
Message-ID: <20100904214527.GA20444@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 04, 2010 at 11:33:51PM +0200, Andreas Gruenbacher wrote:
> On Saturday 04 September 2010 02:03:48 Russell King - ARM Linux wrote:
> > As I say, it's because GNU patch doesn't (currently) understand GIT
> > patches.  I wouldn't call that a bug in GNU patch.
> 
> GNU patch in the version used does understand GIT patch headers and does 
> support things like renames.
> 
> The --dry-run option often will not work when the same file is modified more 
> than once in the same patch, though.  This is because GNU patch doesn't 
> remember the intermediary states of files.
> 
> In this case, the patch itself is broken.

GIT has many options to control how it produces patches, and -C or -M
allow it to reduce the size of patches making them more reviewable.  It
also makes them incompatible with GNU patch, whether or not GNU patch
understands the GIT headers.

As I've already said - if you want GNU compatible patches, don't generate
GIT patches using -C or -M.

Simples.
