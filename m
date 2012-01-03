From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 03 Jan 2012 10:37:29 +0100
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20120102134229.GZ29877@amd.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <20120102134229.GZ29877@amd.com>
Message-ID: <00dc01ccc9fb$4fcb7590$ef6260b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, January 02, 2012 2:42 PM Joerg Roedel wrote:

> On Thu, Dec 29, 2011 at 09:24:18PM +0900, KyongHo Cho wrote:
> > Changes since v7:
> > - Rebased with the recent commits of the following git branches
> >   * git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/next
> >   * git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git/for-next
> > - Changed magic numbers into macros
> > - Setting owner of a System MMU in 'iommu' field of dev_archdata
> > - Verbose message in the default fault handler
> > - Some bug fixes.
> 
> I still get
> 
>   LD      .tmp_vmlinux1
> /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no
> machine record defined
> /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no
> machine record defined
> /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no
> machine record defined
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> when trying to compile ARM/Exynos with 3.2-rc7. Am I doing something
> wrong or is this not expected to work?

Yes, there is something a bit wrong with your kernel configuration. You get this error if 
there is no board selected to be compiled-in. Please go to kernel configuration and select
"System Type -> SAMSUNG EXYNOS SoCs Suppport". Then select some hardware board to be 
compiled in, for example SMDKV310, SMDKC210 and "Mobile NURI board".

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
