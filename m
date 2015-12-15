From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Dec 2015 15:22:43 +0530
Subject: [PATCH] ARM: davinci: only select WT cache if cache is enabled
In-Reply-To: <2043568.VG8xo4jr1Z@wuerfel>
References: <2043568.VG8xo4jr1Z@wuerfel>
Message-ID: <566FE2EB.4090505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 06:49 PM, Arnd Bergmann wrote:
> The DA830 chip only works if the dcache is in writethrough mode,
> but that produces a harmless Kconfig warning if the cache happens
> to be disabled:
> 
> warning: (ARCH_DAVINCI_DA830) selects CPU_DCACHE_WRITETHROUGH which has unmet direct dependencies ((CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_FA526) && !CPU_DCACHE_DISABLE)
> 
> This makes the select conditional so we don't have to worry
> about the warning in randconfig builds any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

Thanks,
Sekhar
