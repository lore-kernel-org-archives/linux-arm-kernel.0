From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 8 Dec 2010 16:56:40 +0800
Subject: [PATCH v2 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <20101207210352.GC14775@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
	<20101207210352.GC14775@pengutronix.de>
Message-ID: <AANLkTim4i1fo1ebKxONeu79-AMXevyhhqh-uV26Yb2aK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
[...]
>> +
>> + ? ? .macro ?disable_fiq
>> + ? ? .endm
> I think is isn't needed. ?Only when you start to actually use the fiq.
>
Without it, the compiler will complain when compiling
arch/arm/kernel/entry-armv.S.

[...]
>> + ? ? ldr ? ? \base, =icoll_base
>> + ? ? ldr ? ? \base, [\base]
>> +#elif defined (CONFIG_SOC_IMX23)
>> + ? ? ldr ? ? \base, =MX23_ICOLL_BASE_ADDR
>> +#else
>> + ? ? ldr ? ? \base, =MX28_ICOLL_BASE_ADDR
>> +#endif
> Mhh, you said the base addresses are different. ?Unless I'm mistaken
> they are not. ?So you can just remove icoll_base.
>
Something went wrong in my head.  The addresses are same.

-- 
Regards,
Shawn
