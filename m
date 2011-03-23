From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 23 Mar 2011 13:07:04 +0900
Subject: [PATCH] ARM: Use asm-generic/sizes.h
In-Reply-To: <4D896616.7070307@codeaurora.org>
References: <1300751462-1494-1-git-send-email-sboyd@codeaurora.org>
	<201103220934.50435.arnd@arndb.de>
	<20110322092113.GB17264@n2100.arm.linux.org.uk>
	<201103221110.20861.arnd@arndb.de>
	<00ec01cbe897$2eed7210$8cc85630$@mprc.pku.edu.cn>
	<4D88ECE3.1070209@codeaurora.org>
	<00fc01cbe8f9$cd807640$688162c0$@mprc.pku.edu.cn>
	<4D896616.7070307@codeaurora.org>
Message-ID: <20110323040704.GA15808@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 08:16:38PM -0700, Stephen Boyd wrote:
> On 03/22/2011 06:29 PM, Guan Xuetao wrote:
> > IMO, the content of asm-generic/sizes.h should only include
> > power-of-2 sizes definitions.  And SZ_48M could be replaced by
> > (SZ_32M | SZ_16M) or (SZ_32M + SZ_16M), or added to arch-specific
> > headers.
> 
> I'm hoping that kbuild gets asm-generic support sometime soon so files
> with only a "#include <asm-generic/*>" are generated instead of living
> in the tree. In that case I'd rather have the non power of 2 constants
> added to the generic sizes.h and be done with it. There isn't any strong
> technical reason to deny power of 2 constants from the generic header,
> right?
> 
> Note: SH could also move to this if SZ_26M is put in the generic header.
> 
I since dropped it and just open-coded it in the one place it was being
used. If it had been used in more places I would have stubbed it in the
asm/ version after the asm-generic include.

I'd say the simplest is to stay with powers of 2 unless you have a size
that is used in more than one place. If ARM uses SZ_48M commonly then
there's certainly a good case for adding it generically.
