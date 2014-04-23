From: andy.nicholas.work@gmail.com (Andy Nicholas)
Date: Tue, 22 Apr 2014 17:18:39 -0700
Subject: kdump for ARM Linux?
Message-ID: <132601cf5e89$94556a70$bd003f50$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, hopefully this is the correct mailing list for this question:

I'm working on a derivative of the mainline Linux 3.8 kernel and I'm trying
to enable ARM kdump functionality to collect crashdumps when we have kernel
problems. But, there's some kind of unresolved issue in
arch/arm/mm/ioremap.c which prevents /proc/vmcore from being able to
function properly. I checked and this appears to still be in kernel.org
Linux 3.13. The target platform is a regular, recent ARMv7 compatible chip. 

Has this issue been addressed in any version of an ARM Linux kernel? Or, is
there a work-around? If not, how does a crashdump file get generated when/if
the kernel crashes or a driver faults?

>> WARNING: at arch/arm/mm/ioremap.c:244
__arm_ioremap_pfn_caller+0x1d8/0x1f0()
>> Modules linked in:
>> [<c0016660>] (unwind_backtrace+0x0/0x138) from [<c0020480>]
(warn_slowpath_common+0x4c/0x64)
>> [<c0020480>] (warn_slowpath_common+0x4c/0x64) from [<c00204b4>]
(warn_slowpath_null+0x1c/0x24)
>> [<c00204b4>] (warn_slowpath_null+0x1c/0x24) from [<c0018e9c>]
(__arm_ioremap_pfn_caller+0x1d8/0x1f0)
>> [<c0018e9c>] (__arm_ioremap_pfn_caller+0x1d8/0x1f0) from [<c0018f20>]
(__arm_ioremap_caller+0x54/0x5c)
>> [<c0018f20>] (__arm_ioremap_caller+0x54/0x5c) from [<c0018c58>]
(__arm_ioremap+0x18/0x1c)
>> [<c0018c58>] (__arm_ioremap+0x18/0x1c) from [<c00168fc>]
(copy_oldmem_page+0x34/0xc0)
>> [<c00168fc>] (copy_oldmem_page+0x34/0xc0) from [<c010350c>]
(read_from_oldmem+0xb8/0xe4)
>> [<c010350c>] (read_from_oldmem+0xb8/0xe4) from [<c05c37e0>]
(parse_crash_elf32_headers+0x184/0x43c)
>> [<c05c37e0>] (parse_crash_elf32_headers+0x184/0x43c) from [<c05c3b64>]
(vmcore_init+0xcc/0x198)
>> [<c05c3b64>] (vmcore_init+0xcc/0x198) from [<c000863c>]
(do_one_initcall+0x34/0x184)
>> [<c000863c>] (do_one_initcall+0x34/0x184) from [<c05b28dc>]
(kernel_init_freeable+0xfc/0x1c8)
>> [<c05b28dc>] (kernel_init_freeable+0xfc/0x1c8) from [<c04326d4>]
(kernel_init+0x8/0xe4)
>> [<c04326d4>] (kernel_init+0x8/0xe4) from [<c000ec58>]
(ret_from_fork+0x14/0x3c)
>>
>> arch/arm/mm/ioremap.c:244
>>??????? /*
>>????????? * Don't allow RAM to be mapped - this causes problems with
ARMv6+
>>????????? */
>>???????? if (WARN_ON(pfn_valid(pfn)))
>>???????????????? return NULL;

Thanks in advance for any help.

-andy
