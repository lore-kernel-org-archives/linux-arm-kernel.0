From: muni.anda@gmail.com (muni anda)
Date: Fri, 23 Oct 2009 21:03:16 -0700
Subject: cpu_vm_mask checks in ARM flush functions
Message-ID: <f20fa6c60910232103h5a3046fbmda23a093f94fa230@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was going though the cache flush functions in arch/arm/mm/flush.c
and found that cpu_isset() is used at a lot of places. I couldn't
understand the reason why there is a need for cpu_vm_mask checks? My
understanding was that those functions will be executed on the CPU for
which the cpu_mask is already set (in switch_mm call). Is there a
different calling sequence that I am missing?

Can someone please the need for those checks (For example
flush_ptrace_access() function running on vipt_non_aliasing caches).

Thanks,
-Muni
