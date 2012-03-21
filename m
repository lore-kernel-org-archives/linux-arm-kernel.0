From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Mar 2012 11:45:41 +0100
Subject: [PATCH v4 05/12] ARM: EXYNOS: add support uart for EXYNOS4 and
 EXYNOS5
In-Reply-To: <CAJuYYwTJsA1M1Qj2P1-1K=pWzi0BPo8YJNDSx4NqGC7NX0030g@mail.gmail.com>
References: <1331736138-28964-1-git-send-email-kgene.kim@samsung.com>
 <1331736138-28964-6-git-send-email-kgene.kim@samsung.com>
 <CAJuYYwTJsA1M1Qj2P1-1K=pWzi0BPo8YJNDSx4NqGC7NX0030g@mail.gmail.com>
Message-ID: <074401cd074f$c2946b90$47bd42b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, March 21, 2012 10:14 AM Thomas Abraham wrote:

> On 14 March 2012 20:12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Actually, the base address of uart is different between EXYNOS4
> > and EXYNOS5 and this patch enables to support uart for EXYNOS4
> > and EXYNOS5 SoCs at runtime.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> 
> [...]
> 
> > diff --git a/arch/arm/mach-exynos/include/mach/debug-macro.S b/arch/arm/mach-
> exynos/include/mach/debug-macro.S
> > index 6cacf16..6c857ff 100644
> > --- a/arch/arm/mach-exynos/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-exynos/include/mach/debug-macro.S
> > @@ -21,8 +21,13 @@
> > ? ? ? ? */
> >
> > ? ? ? ?.macro addruart, rp, rv, tmp
> > - ? ? ? ? ? ? ? ldr ? ? \rp, = S3C_PA_UART
> > - ? ? ? ? ? ? ? ldr ? ? \rv, = S3C_VA_UART
> > + ? ? ? ? ? ? ? mov ? ? \rp, #0x10000000
> 
> This is physical address of Exynos4/5 CPUID register which cannot be
> used here. And virtual address S5P_VA_CPUID also cannot be used here
> since this will be called before paging_init when earlyprintk boot
> param is used. So, with this change, earlyprintk does not work for
> both Exynos4 and Exynos5.

I confirm, printascii freeze the system on EXYNOS4 after that patch,
tested on Exynos4210 Nuri board.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
