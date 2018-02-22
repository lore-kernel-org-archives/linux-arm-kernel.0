From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 12:13:01 +0000
Subject: [PATCH] perf: arm_spe: include linux/vmalloc.h for vmap()
In-Reply-To: <20180222114716.1356279-1-arnd@arndb.de>
References: <20180222114716.1356279-1-arnd@arndb.de>
Message-ID: <20180222121301.GA1591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 12:47:05PM +0100, Arnd Bergmann wrote:
> On linux-next, I get a build failure in some configurations:
> 
> drivers/perf/arm_spe_pmu.c: In function 'arm_spe_pmu_setup_aux':
> drivers/perf/arm_spe_pmu.c:857:14: error: implicit declaration of function 'vmap'; did you mean 'swap'? [-Werror=implicit-function-declaration]
>   buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>               ^~~~
>               swap
> drivers/perf/arm_spe_pmu.c:857:37: error: 'VM_MAP' undeclared (first use in this function); did you mean 'VM_MPX'?
>   buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>                                      ^~~~~~
>                                      VM_MPX
> drivers/perf/arm_spe_pmu.c:857:37: note: each undeclared identifier is reported only once for each function it appears in
> drivers/perf/arm_spe_pmu.c: In function 'arm_spe_pmu_free_aux':
> drivers/perf/arm_spe_pmu.c:878:2: error: implicit declaration of function 'vunmap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
> 
> vmap() is declared in linux/vmalloc.h, so we should include that header file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, Arnd. I'll pick this up for 4.17.

Will
