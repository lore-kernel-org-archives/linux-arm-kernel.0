From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 18 Jun 2015 08:16:07 -0400
Subject: how aarch32 jump to aarch64
In-Reply-To: <CADUS3o=mu7f9=_MMRt9ijdnC+saE-B+68hnyGtHeaAB=2Gd2DA@mail.gmail.com>
References: <CADUS3okH9M-=zpeu_UH55sTT0wrPoxNzYxyT=Yzrb9NgUezgDg@mail.gmail.com>
 <10952759.0QA4gdRIiH@wuerfel>
 <CADUS3o=VKkyXD-r8rPpgqe2+EtXeHjuVJJZ621aFL3iqp62BXA@mail.gmail.com>
 <CADUS3o=mu7f9=_MMRt9ijdnC+saE-B+68hnyGtHeaAB=2Gd2DA@mail.gmail.com>
Message-ID: <5582B687.40902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 08:08 AM, yoma sophian wrote:
> hi arnd:
> 
> 2015-06-15 9:19 GMT+08:00 yoma sophian <sophian.yoma@gmail.com>:
>> hi Arnd:
>>
>> 2015-06-15 3:39 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Sunday 14 June 2015 23:06:49 yoma sophian wrote:
>>>> hi all:
>>>> as far as I know, we can use pseudo eret to let aarch64 jump to aarch32.
>>>> But how could we let aarch32 --> aarch64?
>>>>
>>>
>>> I believe the only way is to trap into a higher privilege level, e.g. from
>>> user space to the kernel, or from kernel into hypervisor mode. If you
>>> want to implement mode switching within one binary, you would then add
>>> a syscall/hypercall/... that returns without switching back to aarch32.
>> Do you mean to use HVC, SVC, in aarch32?
>> But as far as I remember, they are exception instructions which let
>> processor jump to aarch32 hypervisio, and aarch32 supervisor mode
>> seperately.
>> Is there any exception instruction which will let aarch32 jump to aarch64?
> in so far aarch64 kernel enviornemnt, the kernel is running in
> Ns-aarch64-EL1 and user mode support aarch32 binary.
> so there should be some instruction, which can let processor jump from
> aarch32 --> aarch64, right?
> 
> appreciate your help,

The instruction is SVC, which has no ability to change the register width of
the destination exception level. If EL0 is AArch32 and EL1 is AArch64 then SVC
will cause an A32 -> A64 transition.

Chris

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
