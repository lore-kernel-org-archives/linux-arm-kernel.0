From: wangyufen@huawei.com (wangyufen)
Date: Fri, 21 Nov 2014 18:23:06 +0800
Subject: arm64:  dose arm64 support the sysfs system call?
In-Reply-To: <546EEFB8.10509@hisilicon.com>
References: <546EE946.1020905@huawei.com> <546EEFB8.10509@hisilicon.com>
Message-ID: <546F128A.5080705@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/21 15:54, Wei Xu wrote:
> 
> 
> On 2014/11/21 15:27, wangyufen wrote:
>> Hi,
> 
> Hi Yufen,
> 
>> I did ltp test on arm64, the sysfs testcases failed:
>>
>>     sysfs01     0  TWARN  :  This test can only run on kernels that support the sysfs system call
>>
>> because the __NR_sysfs didn't define in aarch64
> 
> Have you been enabled the *CONFIG_COMPAT* in your .config?
> 
*CONFIG_COMPAT* already enabled
CONFIG_COMPAT_BRK=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_COMPAT=y

> The __NR_sysfs is defined at arch/arm64/include/asm/unistd32.h
> and arch/arm64/kernel/sys32.S is including it.
> 
in arch/arm64/include/asm/unistd32.h  defined :
__SYSCALL(135, sys_sysfs)

So I used 135 to test sysfs, I straced sysfs01, 

the syscall called rt_sigprocmask not sysfs:
rt_sigprocmask(SIG_UNBLOCK, [], 0x8, 0) = -1 EINVAL (Invalid argument)

> Hope it will fix your issues.
> 
> Best Regards,
> Wei
> 
>> Dose anyone know what number the sysfs system call is in aarch64?
>>
>>
>> Thanks,
>> Wang
>>
>> _______________________________________________
>> linuxarm mailing list
>> linuxarm at huawei.com
>> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>>
>>
> 
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
> 
> 
