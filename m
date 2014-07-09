From: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 9 Jul 2014 19:38:34 +0200
Subject: [PATCH 1/3] asm-generic/io.h: Implement generic {read,write}s*()
In-Reply-To: <1404918699-17284-1-git-send-email-thierry.reding@gmail.com>
References: <1404918699-17284-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140709173834.GA31974@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 05:11:37PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This patch implements generic versions of readsb(), readsw(), readsl(),
> readsq(), writesb(), writesw(), writesl() and writesq(). Variants of
> these string functions for I/O accesses (ins*() and outs*() as well as
> ioread*_rep() and iowrite*_rep()) are now implemented in terms of the
> new functions.
> 
> While at it, also make sure that any of the functions provided as
> fallback for architectures that don't override them can't be overridden
> subsequently.
> 
> This is compile- and runtime-tested on 32-bit and 64-bit ARM and compile
> tested on Microblaze, s390, SPARC and Xtensa. For ARC, Blackfin, Metag,
> OpenRISC, Score and Unicore32 which also use asm-generic/io.h I couldn't
> find or build a cross-compiler that would run on my system. But by code
> inspection they shouldn't break with this patch.

Looks good. When this is in mainline I will try to convert sparc64
to use asm-generic/io.h too.
Last I tried this did not fly because there were some #define
missing and then I lost track of it.

	Sam
