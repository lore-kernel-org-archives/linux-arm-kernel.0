From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 08:31:06 +0000
Subject: [PATCH 01/24] ARM: shmobile: use __iomem pointers for MMIO
In-Reply-To: <20120918071131.GB31953@verge.net.au>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-2-git-send-email-arnd@arndb.de>
 <20120918071131.GB31953@verge.net.au>
Message-ID: <201209180831.06572.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Simon Horman wrote:
> On Fri, Sep 14, 2012 at 11:34:29PM +0200, Arnd Bergmann wrote:
> > ARM is moving to stricter checks on readl/write functions,
> > so we need to use the correct types everywhere.
> > 
> > This patch is a bit ugly for shmobile, which is the only platform
> > that just uses integer literals all over the place, but I can't
> > see a better way to do this.
> > 
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Cc: linux-sh at vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Wow, thats a lot of chrun, but if we must
> 
> Acked-by: Simon Horman <horms@verge.net.au>
> 

I agree it's not nice to have to do this, but this is largely because
of shmobile doing things differently from all other ARM platforms, on
which the respective patches tend to clean up things and reduce the
number of type casts.

The only alternative I can see is for shmobile to introduce its own
mach/io.h file with the relaxed type checking, but that would only
defer the problem until the point where you want shmobile to be part
of the common multiplatform kernel binary.

	Arnd
