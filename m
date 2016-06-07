From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 7 Jun 2016 10:33:09 -0300
Subject: next-20160607 build: 2 failures 9 warnings (next-20160607)
In-Reply-To: <5756CAB2.5030701@samsung.com>
References: <E1bABXS-0001YX-Cz@optimist> <20160607105823.GT7510@sirena.org.uk>
 <5756CAB2.5030701@samsung.com>
Message-ID: <20160607103309.0b9a48fc@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, 07 Jun 2016 15:22:58 +0200
Sylwester Nawrocki <s.nawrocki@samsung.com> escreveu:

> On 06/07/2016 12:58 PM, Mark Brown wrote:
> > On Tue, Jun 07, 2016 at 08:35:02AM +0100, Build bot for Mark Brown wrote:
> > 
> > Today's -next fails to build an arm64 allmodconfig due to:
> >   
> >> 	arm64-allmodconfig
> >> ../drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h:19:27: fatal error: asm/dma-iommu.h: No such file or directory  
> > 
> > introduced by 04f776734c4e (media: s5p-mfc: add iommu support) which
> > relies on a header which is only available on 32 bit ARM.  I suspect the
> > driver should be using linux/dma-iommu.h instead.  
> 
> Since the mfc topic branch got already pulled to the samsung-soc tree,
> as discussed in other thread [1], there is a build break in -next.
> There is a patch to fix this issue and to include it in next, as we
> agreed  on irc, could you please pull this branch into your "for-next"
> tree:
> 
> git://linuxtv.org/snawrocki/samsung.git for-v4.8/media/exynos-mfc
> 
> and then apply that patch [2] ?
> "media: s5p-mfc: fix compilation issue on archs other than ARM (32bit)"

Sure. Applied, thanks!

Mauro
