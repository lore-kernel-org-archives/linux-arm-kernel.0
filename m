From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 3 Jun 2010 01:49:05 +0100
Subject: [PATCH] ARM: SAMSUNG: Make WDT driver dependency SoC specific
	instead of machine specific
In-Reply-To: <1275462611-21657-1-git-send-email-kgene.kim@samsung.com>
References: <1275462611-21657-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100603004905.GE30276@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 04:10:11PM +0900, Kukjin Kim wrote:
> From: Banajit Goswami <banajit.g@samsung.com>
> 
> This patch moves the dependency of watchdog timer driver from
> MACH_XXX(board) to ARCH_XXX(SoC). This will enable all machines
> using Samsung S3C64XX, S5P6440 and S5PV210/S5PC110 SoCs to use
> the WDT driver by default.
> 
> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig              |    3 +++

you'll be better off changing the arch/arm/mach-xxx/Kconfig files to avoid
having to change arch/arm/Kconfig and thus make the merge dependant on
Russell.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
