From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Jan 2012 09:57:47 +0000
Subject: [PATCH] ARM: GIC: fix non-SMP builds
In-Reply-To: <1327312291-9457-1-git-send-email-m.szyprowski@samsung.com>
References: <1327312291-9457-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F1D2F1B.2090904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/12 09:51, Marek Szyprowski wrote:
> This patch fixes the build break introduced by commit db0d4db22. It
> happen only if SMP support has been disabled:
> 
> arch/arm/common/gic.c: In function 'gic_init_bases':
> arch/arm/common/gic.c:679: error: implicit declaration of function 'cpu_logical_map'
> make[1]: *** [arch/arm/common/gic.o] Error 1
> make: *** [arch/arm/common] Error 2
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Please have a look at Will's patches:
http://patchwork.ozlabs.org/patch/136504/

which fix this problem in a far more elegant way.

	M.
-- 
Jazz is not dead. It just smells funny...
