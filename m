From: sophian.yoma@gmail.com (yoma sophian)
Date: Mon, 15 Jun 2015 09:19:52 +0800
Subject: how aarch32 jump to aarch64
In-Reply-To: <10952759.0QA4gdRIiH@wuerfel>
References: <CADUS3okH9M-=zpeu_UH55sTT0wrPoxNzYxyT=Yzrb9NgUezgDg@mail.gmail.com>
 <10952759.0QA4gdRIiH@wuerfel>
Message-ID: <CADUS3o=VKkyXD-r8rPpgqe2+EtXeHjuVJJZ621aFL3iqp62BXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Arnd:

2015-06-15 3:39 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 14 June 2015 23:06:49 yoma sophian wrote:
>> hi all:
>> as far as I know, we can use pseudo eret to let aarch64 jump to aarch32.
>> But how could we let aarch32 --> aarch64?
>>
>
> I believe the only way is to trap into a higher privilege level, e.g. from
> user space to the kernel, or from kernel into hypervisor mode. If you
> want to implement mode switching within one binary, you would then add
> a syscall/hypercall/... that returns without switching back to aarch32.
Do you mean to use HVC, SVC, in aarch32?
But as far as I remember, they are exception instructions which let
processor jump to aarch32 hypervisio, and aarch32 supervisor mode
seperately.
Is there any exception instruction which will let aarch32 jump to aarch64?

Appreciate your help,
