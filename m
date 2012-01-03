From: joerg.roedel@amd.com ('Joerg Roedel')
Date: Tue, 3 Jan 2012 14:10:48 +0100
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <00dc01ccc9fb$4fcb7590$ef6260b0$%szyprowski@samsung.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <20120102134229.GZ29877@amd.com>
 <00dc01ccc9fb$4fcb7590$ef6260b0$%szyprowski@samsung.com>
Message-ID: <20120103131048.GD29877@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Jan 03, 2012 at 10:37:29AM +0100, Marek Szyprowski wrote:
> Yes, there is something a bit wrong with your kernel configuration. You get this error if 
> there is no board selected to be compiled-in. Please go to kernel configuration and select
> "System Type -> SAMSUNG EXYNOS SoCs Suppport". Then select some hardware board to be 
> compiled in, for example SMDKV310, SMDKC210 and "Mobile NURI board".

thanks for this info. I selected a board and compile of linux-next now
fails with:

  LD      .tmp_vmlinux1
arch/arm/mach-exynos/built-in.o: In function `exynos4_pm_resume':
/data/lemmy/linux.trees.git/arch/arm/mach-exynos/pm.c:385: undefined reference to `scu_enable'
make[1]: *** [.tmp_vmlinux1] Error 1

This is because scu_enable() is only available with CONFIG_SMP=y which
is not set for Exynos.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
