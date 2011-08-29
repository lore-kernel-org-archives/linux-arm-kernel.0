From: svenkatr@ti.com (S, Venkatraman)
Date: Mon, 29 Aug 2011 21:49:25 +0530
Subject: [RFC PATCH] arm: fiq: convert enable/disable_fiq to inline
	functions
In-Reply-To: <alpine.LFD.2.00.1108291112010.20358@xanadu.home>
References: <1314628177-3193-1-git-send-email-svenkatr@ti.com>
	<alpine.LFD.2.00.1108291112010.20358@xanadu.home>
Message-ID: <CANfBPZ-MbHP8zAqmi3m6=PjSkvBeWO=H18B+ALZToeHrQdbcfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 8:44 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 29 Aug 2011, Venkatraman S wrote:
>
>> FIQ_START is an platform specific constant used in the
>> implementation of enable_fiq and disable_fiq.
>> Converting then to inline functions enables different
>> architectures which use the FIQ module to exist in a single
>> zImage with different values of FIQ_START.
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>
> I fail to see how this patch inproves things. The asm/fiq.h file is just
> as global as kernel/fiq.c is.
>

Argh!! I intended this to be a macro like this
#define enable_fiq(x)  enable_irq((x) + FIQ_START)
so that the constant is needed only at places where it is expanded.

This way different platforms can have their local irqs.h supply the constant,
where the macros are used.

Somehow I thought inline functions are more readable and assumed the
same macro'ish behaviour.

Will a macro variant of this be more useful ?

Thanks,
Venkat.
