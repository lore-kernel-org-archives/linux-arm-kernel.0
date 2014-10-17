From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 17 Oct 2014 09:54:39 -0700
Subject: ARM: issue with memory reservation from DT
In-Reply-To: <5440EDC6.70300@ti.com>
References: <543EAC5A.6050209@ti.com>
 <20141015175025.GJ27405@n2100.arm.linux.org.uk> <54400123.7040806@ti.com>
 <5440DD02.9020103@codeaurora.org> <5440EDC6.70300@ti.com>
Message-ID: <544149CF.5080809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2014 3:21 AM, Grygorii Strashko wrote:
> Hi Laura,
>
> As I mentioned in first e-mail I've 1G Mem node initially:
>    reg = <0x8 0x00000000 0x0 0x40000000>;
>
> and have memory reservation of 512M in the upper part of memory:
>    reserved-memory {
> 	reg = <0x8 0x20000000 0x0 0x20000000>;
>
> then in sanity_check_meminfo() initial mem configuration calculated as following:
>
> [    0.000000] ======= memblock_limit=0x000000082f800000 arm_lowmem_limit=0x000000082f800000 vmalloc_limit=ef800000 high_memory=0x000000082f800000
> and memblock.current_limit == arm_lowmem_limit=0x000000082f800000
>
> then in arm_memblock_init()->early_init_fdt_scan_reserved_mem() 512M of memory removed
> (not reserved!, because "no-map;" is defined).
>
> After that Kernel will have only 512M of accessible memory
>   memory[0x0]	[0x00000800000000-0x0000081fffffff]
>
> I've checked of_reserved_mem.c and saw no issues there :(
>

Yes, I suspect the issue is not with of_reserved_mem.c and instead with
sanity_check_meminfo in mmu.c . I'm still traveling so I'll probably
take a look on Monday unless I find some time sooner.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
