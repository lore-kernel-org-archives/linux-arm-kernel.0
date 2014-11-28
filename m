From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Nov 2014 17:52:24 +0000
Subject: [PATCH 0/9] irqchip: gic: kill gic_arch_extn
In-Reply-To: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
References: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <5478B658.8090809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/14 17:26, Marc Zyngier wrote:
> The gic_arch_extn hack that Tegra uses has been nagging me for too
> long. It is only there for the benefit of a single platform, and yet
> it impacts all GIC users. Moreover, it gives people the wrong idea
> ("let's use it to put some new custom hack in there"...).

Of course, just after sending this I realised that quite a lot of
platform are now using this crap:

arch/arm/mach-exynos/pm.c
arch/arm/mach-imx/gpc.c
arch/arm/mach-omap2/omap-wakeupgen.c
arch/arm/mach-shmobile/intc-sh73a0.c
arch/arm/mach-shmobile/setup-r8a7779.c
arch/arm/mach-ux500/cpu.c
arch/arm/mach-zynq/common.c

Yes, I intend to address them as well...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
