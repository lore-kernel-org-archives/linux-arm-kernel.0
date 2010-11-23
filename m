From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 23 Nov 2010 10:44:31 +0000
Subject: [PATCH v2 9/9] ARM: kprobes: Don't HAVE_KPROBES when
	CONFIG_THUMB2_KERNEL is selected
In-Reply-To: <4CEAF661.3000907@ru.mvista.com>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-10-git-send-email-dave.martin@linaro.org>
	<4CEAF661.3000907@ru.mvista.com>
Message-ID: <AANLkTi=brzvrj4L_+sHC+T2gsVP2zmpf1XRnmonOUKAH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 22, 2010 at 11:01 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.

[...]

>> @@ -9,7 +9,7 @@ config ARM
>> ? ? ? ?select GENERIC_ATOMIC64 if (!CPU_32v6K || !AEABI)
>> ? ? ? ?select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>> ? ? ? ?select HAVE_ARCH_KGDB
>> - ? ? ? select HAVE_KPROBES if (!XIP_KERNEL)
>> + ? ? ? select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)
>
> ? These parens are useless.

Maybe so, but I prefer to keep the style consistent with the rest of the file...

Cheers
---Dave
