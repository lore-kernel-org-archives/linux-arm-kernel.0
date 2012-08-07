From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 00:23:01 -0700
Subject: [PATCH] OMAP2+: Fix random config build break with
 !ARM_CPU_SUSPEND
In-Reply-To: <1342176307-6435-1-git-send-email-santosh.shilimkar@ti.com>
References: <1342176307-6435-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120807072300.GM11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120713 03:50]:
> The random config builds with PM and !ARM_CPU_SUSPEND breaks with below
> error on omap2plus_defconfig.
> 
> arch/arm/mach-omap2/sleep44xx.S:323: undefined reference to `cpu_resume'
> arch/arm/mach-omap2/omap-mpuss-lowpower.c:278: undefined reference to `cpu_suspend'
> 
> This is because recently merged OMAP5 platform shares the common files
> with OMAP4 but doesn't select ARM_CPU_SUSPEND. Without the ARM_CPU_SUSPEND
> the sleep code is meaningless.
> 
> Fix the same by adding ARM_CPU_SUSPEND for OMAP5. The suggestion came from
> Russell King in an off-list discussion.

Thanks applying into fixes.

Tony
