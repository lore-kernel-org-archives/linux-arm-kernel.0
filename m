From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 24 Jun 2013 17:19:46 +0800
Subject: [PATCH] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for
 aarch32_break_handler()
In-Reply-To: <20130624084744.GA23779@mudshark.cambridge.arm.com>
References: <51C53C06.7050205@asianux.com>
 <20130624084744.GA23779@mudshark.cambridge.arm.com>
Message-ID: <51C80F32.4060500@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 04:47 PM, Will Deacon wrote:
> On Sat, Jun 22, 2013 at 06:54:14AM +0100, Chen Gang wrote:
>> > 
>> > If 'COMPAT' not defined, aarch32_break_handler() cannot pass compiling,
>> > so need add '#ifdef' for it just like the header file has done.
>> > 
>> > The related make:
>> > 
>> >   make ARCH=arm64 randconfig
>> >   make ARCH=arm64 menuconfig
>> >   make ARCH=arm64 V=1 EXTRA_CFLAGS=-W
>> > 
>> > The related error:
>> > 
>> >   arch/arm64/kernel/debug-monitors.c:249:5: error: redefinition of ?aarch32_break_handler?
>> >   In file included from arch/arm64/kernel/debug-monitors.c:29:0:
>> >   /root/linux-next/arch/arm64/include/asm/debug-monitors.h:89:12: note: previous definition of ?aarch32_break_handler? was here
> Actually, can we just kill the static definition in debug-monitors.h
> instead? I don't see anything in the full-blown aardch32_break_handler that
> won't play nicely if !COMPAT.

It sounds good, I will send patch v2.

Thanks.
-- 
Chen Gang

Asianux Corporation
