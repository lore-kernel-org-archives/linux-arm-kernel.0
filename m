From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jul 2015 11:58:20 +0100
Subject: [PATCH 0/7] Another posting of the Dove PMU series
In-Reply-To: <20150725201723.GD604@lunn.ch>
References: <20150715185859.GC7557@n2100.arm.linux.org.uk>
 <20150725201723.GD604@lunn.ch>
Message-ID: <20150731105820.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 25, 2015 at 10:17:23PM +0200, Andrew Lunn wrote:
> I took at look at Russell's patches. I rebased them onto -rc1. There
> were a few minor merge problems, all easy to fix. I added
> Signed-off-by: since i did make changes, but 99.9% of the credit for
> these patches is definitely to Russell.

Thanks.

If you're committing patches into git to be sent upstream, you _should_
_always_ add your signed-off-by.  Signed-off-by not only tracks who has
touched the patch, but also the people who were responsible for it
being committed into git.

So, by committing patches into git, you should always add your S-o-b.

> With mvebu_v7_defconfig i get:
> 
>   CC      drivers/soc/dove/pmu.o
> drivers/soc/dove/pmu.c: In function dove_init_pmu_legacy?:
> drivers/soc/dove/pmu.c:400:46: error: IRQ_DOVE_PMU_START undeclared (first use in this function)
>    irq_domain_associate_many(pmu->irq_domain, IRQ_DOVE_PMU_START,
>                                               ^
> drivers/soc/dove/pmu.c:400:46: note: each undeclared identifier is reported only once for each function it appears in
> 
> and dove_defconfig:
> 
>   CC      arch/arm/mach-dove/common.o
> arch/arm/mach-dove/common.c:381:15: error: PWR_VPU_PWR_DWN_MASK undeclared here (not in a function)
>    .pwr_mask = PMU_PWR_VPU_PWR_DWN_MASK,
>                ^
> arch/arm/mach-dove/common.c:382:15: error: PMU_SW_RST_VIDEO_MASK undeclared here (not in a function)
>    .rst_mask = PMU_SW_RST_VIDEO_MASK,
>                ^
> arch/arm/mach-dove/common.c:383:15: error: PMU_ISO_VIDEO_MASK undeclared here (not in a function)
>    .iso_mask = PMU_ISO_VIDEO_MASK,
>                ^
> arch/arm/mach-dove/common.c:386:15: error: PMU_PWR_GPU_PWR_DWN_MASK undeclared here (not in a function)
>    .pwr_mask = PMU_PWR_GPU_PWR_DWN_MASK,
>                ^
> arch/arm/mach-dove/common.c:387:15: error: PMU_SW_RST_GPU_MASK undeclared here (not in a function)
>    .rst_mask = PMU_SW_RST_GPU_MASK,
>                ^
> arch/arm/mach-dove/common.c:388:15: error: PMU_ISO_GPU_MASK undeclared here (not in a function)
>    .iso_mask = PMU_ISO_GPU_MASK,
> 
> So i've dropped the last patch.

That's fine.  I'll work on resolving those.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
