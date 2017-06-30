From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 30 Jun 2017 13:36:54 +0200
Subject: [PATCH 0/2] Follow-up on "ARM: Fix dma_alloc_coherent() and
 friends for NOMMU"
In-Reply-To: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
References: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CA+M3ks5OqDwdmz6dTR87zX+OH_F+dJgXwfo96EWBg8XbvhmY4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-06-28 11:16 GMT+02:00 Vladimir Murzin <vladimir.murzin@arm.com>:
> These two patches are folloups on "[PATCH v6 0/7] ARM: Fix
> dma_alloc_coherent() and friends for NOMMU" which has been partly
> merged in [1]. PATCH 1/2 is done per Christoph's suggestion [2] to
> eliminate duplication in dma-noop.c.  PATCH 2/2 is fixup for ARM's dma
> operations for NOMMU due to aforementioned change.
>
> @Benjamin, your Tested-by for ARM bits would be very appretiated!

I have been able to test on stm32f4 with drm/kms drivers which is
calling dma_alloc_coherent
and modetest doing mmap and it is working fine.

tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

>
> @Christoph, in case you decide to queue PATCH 1/2, can you put it
> before "ARM: NOMMU: Introduce dma operations for noMMU", so transition
> to the new dma operations won't break bisectability.
>
> [1] git://git.infradead.org/users/hch/dma-mapping.git for-next
> [2] https://www.spinics.net/lists/arm-kernel/msg590587.html
>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
>
> Thanks!
>
> Vladimir Murzin (2):
>   drivers: dma-mapping: allow dma_common_mmap() for NOMMU
>   fixup: ARM: NOMMU: Introduce dma operations for noMMU
>
>  arch/arm/mm/dma-mapping-nommu.c | 18 ------------------
>  arch/blackfin/Kconfig           |  1 +
>  arch/m32r/Kconfig               |  1 +
>  arch/m68k/Kconfig               |  1 +
>  arch/microblaze/Kconfig         |  1 +
>  arch/sh/Kconfig                 |  1 +
>  arch/xtensa/Kconfig             |  1 +
>  drivers/base/dma-mapping.c      |  4 ++--
>  8 files changed, 8 insertions(+), 20 deletions(-)
>
> --
> 2.0.0
>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
