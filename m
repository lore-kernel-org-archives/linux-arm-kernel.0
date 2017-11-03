From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 3 Nov 2017 10:06:29 +0000
Subject: next-20171102: ARM64 dies on boot
In-Reply-To: <20171103041806.ya7e7vfrau3dx5de@yury-thinkpad>
References: <20171103041806.ya7e7vfrau3dx5de@yury-thinkpad>
Message-ID: <143b679d-11bb-00df-04c0-5719b5103de5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/11/17 04:18, Yury Norov wrote:
> Hi all,
> 
> I reproduce it with qemu. The exact reason of panic is the NULL-dereference
> in memory_present:
> (gdb) bt
> #0  0xffff000008dd8c6c in sparse_index_init (nid=<optimized out>, section_nr=<optimized out>)
>     at mm/sparse.c:80
> #1  memory_present (nid=0, start=18446462598881083392, end=0) at mm/sparse.c:215
> #2  0xffff000008dc518c in arm64_memory_present () at arch/arm64/mm/init.c:307
> #3  bootmem_init () at arch/arm64/mm/init.c:500
> #4  0xffff000008dc28fc in setup_arch (cmdline_p=<optimized out>) at arch/arm64/kernel/setup.c:287
> #5  0xffff000008dc083c in start_kernel () at init/main.c:530
> #6  0x0000000000000000 in ?? ()
> 

[...]

> This is very early stage, so there's no messages in console.
> Config is attached. If no ideas, I can bisect it later.
> 

Reported and fixed[1], may be not in -next yet.

-- 
Regards,
Sudeep

[1] https://marc.info/?l=linux-kernel&m=150962592016250&w=2
