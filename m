From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 Jan 2012 11:16:31 +0100
Subject: [PATCH] ARM: GIC: fix non-SMP builds
In-Reply-To: <4F1D2F1B.2090904@arm.com>
References: <1327312291-9457-1-git-send-email-m.szyprowski@samsung.com>
 <4F1D2F1B.2090904@arm.com>
Message-ID: <003401ccd9b8$13d3a8b0$3b7afa10$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, January 23, 2012 10:58 AM Marc Zyngier wrote:

> On 23/01/12 09:51, Marek Szyprowski wrote:
> > This patch fixes the build break introduced by commit db0d4db22. It
> > happen only if SMP support has been disabled:
> >
> > arch/arm/common/gic.c: In function 'gic_init_bases':
> > arch/arm/common/gic.c:679: error: implicit declaration of function 'cpu_logical_map'
> > make[1]: *** [arch/arm/common/gic.o] Error 1
> > make: *** [arch/arm/common] Error 2
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Please have a look at Will's patches:
> http://patchwork.ozlabs.org/patch/136504/
> 
> which fix this problem in a far more elegant way.

Ok, thanks for the hint! I hope it will be merged to 3.3-rc2+ to fix the regression in
GIC code. If so, please ignore my patch. 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
