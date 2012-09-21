From: mporter@ti.com (Matt Porter)
Date: Fri, 21 Sep 2012 14:24:33 -0400
Subject: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
 arm/common
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA8A6A9@DBDE01.ent.ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-2-git-send-email-mporter@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EA8A6A9@DBDE01.ent.ti.com>
Message-ID: <20120921182433.GG16522@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 07:10:52AM +0000, Hebbar, Gururaja wrote:
> On Thu, Sep 20, 2012 at 20:13:34, Porter, Matt wrote:
> > Move mach-davinci/dma.c to common/edma.c so it can be used
> > by OMAP (specifically AM33xx atm) as well. This just moves
> > the private EDMA API but does not support OMAP.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> >  arch/arm/Kconfig                           |    1 +
> >  arch/arm/common/Kconfig                    |    3 +
> >  arch/arm/common/Makefile                   |    1 +
> >  arch/arm/common/edma.c                     | 1588 ++++++++++++++++++++++++++++
> >  arch/arm/include/asm/mach/edma.h           |  267 +++++
> >  arch/arm/mach-davinci/Makefile             |    2 +-
> >  arch/arm/mach-davinci/devices.c            |    3 +-
> >  arch/arm/mach-davinci/dm355.c              |    2 +-
> >  arch/arm/mach-davinci/dm365.c              |    2 +-
> >  arch/arm/mach-davinci/dm644x.c             |    2 +-
> >  arch/arm/mach-davinci/dm646x.c             |    2 +-
> >  arch/arm/mach-davinci/dma.c                | 1588 ----------------------------
> 
> 
> Please use ?M option, while generating patches via git-format-patch. 
> This reduces the patch size if files are copied/renamed/moved.

Yes, I didn't notice until the arm kernel list caught the >100k post.
Will take care of this in v2.

-Matt
