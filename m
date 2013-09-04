From: jwboyer@fedoraproject.org (Josh Boyer)
Date: Wed, 4 Sep 2013 10:13:16 -0400
Subject: 3.12 merge window exynos cpufreq driver fails to build
Message-ID: <CA+5PVA6SQ9JGBD3F=u5ysch-agp91oTK8ZbKsdQkz57yZ8OUHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using Linus' tree as of this morning (v3.11-2654-g458c3f6), the
exynos-cpufreq driver doesn't build because it includes a file that
doesn't exist.

+ make -s ARCH=arm V=1 -j4 bzImage KALLSYMS_EXTRA_PASS=1
arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO:
return_address should use unwind tables" [-Wcpp]
 #warning "TODO: return_address should use unwind tables"
  ^
arch/arm/mm/dma-mapping.c:253:2: warning: #warning ARM Coherent DMA
allocator does not (yet) support huge TLB [-Wcpp]
 #warning ARM Coherent DMA allocator does not (yet) support huge TLB
  ^
drivers/cpufreq/exynos-cpufreq.c:21:22: fatal error: plat/cpu.h: No
such file or directory
 #include <plat/cpu.h>
                      ^
compilation terminated.
make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1

I'm guessing that <plat/cpu.h> file is supposed to come from
arch/arm/plat-samsung/include/plat/, but I don't see anything that
specifies a -I there.

Thoughts?

josh
