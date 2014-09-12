From: yangyingliang@huawei.com (Yang Yingliang)
Date: Fri, 12 Sep 2014 17:03:42 +0800
Subject: [PATCH v2] arm64: add guard macros of unistd.h to prevent double
 inclusion
In-Reply-To: <20140911150212.GP6158@arm.com>
References: <1410235185-16652-1-git-send-email-yangyingliang@huawei.com>
 <20140909123938.GL1754@arm.com> <54115583.8080306@huawei.com>
 <5411698E.3000402@huawei.com> <20140911150212.GP6158@arm.com>
Message-ID: <5412B6EE.1040405@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/11 23:02, Will Deacon wrote:
> On Thu, Sep 11, 2014 at 10:21:18AM +0100, Yang Yingliang wrote:
>> From: Yang Yingliang <yangyingliang@huawei.com>
>>
>> Add guard macros for uapi/asm/unistd.h, asm/unistd.h and
>> asm/unistd32.h.
> 
> Hmm, so I applied this and now my machine panics when we hit userspace. I
> think the issue is that we no longer generate our syscall table in
> arch/arm64/kernel/sys.c, because unistd.h is already included via
> linux/syscalls.h but without the __SYSCALL definition.
> 
> So, a couple of questions:
> 
>   (1) Is the lack of header guards actually causing you a problem?
>   (2) How did you test this?
> 
> I've dropped the patch.
> 
> Will
> 
> 
Oh, my bad, sorry for that.

I found asm/unistd.h have no guard macro when I was migrate a userspace
program from x86_64 to arm64. The program uses the macro _ASM_X86_UNISTD_64_H,
but arm64 does not have this(arm has __ASM_ARM_UNISTD_H). So I tried to add
the guard macro.

Regards,
Yang
