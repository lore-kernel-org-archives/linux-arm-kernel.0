From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Dec 2017 17:21:24 -0800
Subject: [PATCH] [v2] ARM: B15: fix unused label warnings
In-Reply-To: <20171218165307.1472231-1-arnd@arndb.de>
References: <20171218165307.1472231-1-arnd@arndb.de>
Message-ID: <608efeca-c913-5f38-565f-9f792b51fae3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2017 08:52 AM, Arnd Bergmann wrote:
> The new conditionally compiled code leaves some labels and one
> variable unreferenced when CONFIG_HOTPLUG_CPU and CONFIG_PM_SLEEP
> are disabled:
> 
> arch/arm/mm/cache-b15-rac.c: In function 'b15_rac_init':
> arch/arm/mm/cache-b15-rac.c:353:1: error: label 'out_unmap' defined but not used [-Werror=unused-label]
>  out_unmap:
>  ^~~~~~~~~
> arch/arm/mm/cache-b15-rac.c:351:1: error: label 'out_cpu_dead' defined but not used [-Werror=unused-label]
>  out_cpu_dead:
>  ^~~~~~~~~~~~
> At top level:
> arch/arm/mm/cache-b15-rac.c:53:12: error: 'rac_config0_reg' defined but not used [-Werror=unused-variable]
> 
> This replaces the existing #ifdef conditionals with IS_ENABLED()
> checks that let the compiler figure out for itself which code to
> drop.
> 
> Fixes: 55de88778f4b ("ARM: 8726/1: B15: Add CPU hotplug awareness")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Arnd!
-- 
Florian
