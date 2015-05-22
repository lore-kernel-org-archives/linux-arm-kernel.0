From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 16:33:01 +0200
Subject: [GIT PULL] Broadcom SoC changes for 4.2 (take 2)
In-Reply-To: <1432167259-3116-1-git-send-email-f.fainelli@gmail.com>
References: <1432167259-3116-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <2336307.CfrRYyL1zr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 17:14:19 Florian Fainelli wrote:
> This pull request contains the following changes:
> 
> - Rafal adds an additional fault code to be ignored by the kernel on BCM5301X SoC
> 
> - BCM63138 SMP support which:
>         * common code to control the PMB bus, to be shared with a reset
>           controller driver in drivers/reset
>         * secondary CPU initialization sequence using PMB helpers
>         * small changes suggested by Russell King to allow platforms to disable VFP
> 
> ----------------------------------------------------------------
> Changes in v2, based on Arnd's feedback:
> 
> - incorporated Rafal's change, had been missed before
> - fix build error by including include/linux/errno.h
> - moved bcm63xx_pmb.h to include/linux/reset/
> - used readl/writel I/O accessors instead of __raw_{read,write}l
> - removed comment above bcm63xx_pmb.h about spinlock
> 

Pulled into next/soc, thanks addressing my comments!

	Arnd
