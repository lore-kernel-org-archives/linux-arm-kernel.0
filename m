From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 6 Dec 2010 18:17:05 +0000
Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	with CONFIG_THUMB2_KERNEL
In-Reply-To: <1291656937-24992-2-git-send-email-dave.martin@linaro.org>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
Message-ID: <AANLkTi=OhchW6rqMmTP5dpUF7aKwy9iArETaHdwi5cjN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2010 17:35, Dave Martin <dave.martin@linaro.org> wrote:
> ?* Explicitly build a few parts of sleep34xx.S as ARM.
>
> ? ? ?* lock_scratchpad_sem is kept as ARM because of the need to
> ? ? ? ?synchronise with hardware (?) using the SWP instruction.
>
> ? ? ?* save_secure_ram_context and omap34xx_cpu_suspend are built
> ? ? ? ?as ARM in case the Secure World firmware expects to decode
> ? ? ? ?the comment field from the SMC (aka smi) instructions.
>
> ? ? ? ?This can be undone later if the firmware is confirmed as
> ? ? ? ?able to decode the Thumb SMC encoding (or ignores the
> ? ? ? ?comment field).
>
> ? ? ?* es3_sdrc_fix should presumably only be called from the
> ? ? ? ?low-level wakeup code. ?To minimise the diff, switched this
> ? ? ? ?to ARM and demoted it to be a local symbol, since I believe
> ? ? ? ?it shouldn't be called from outside anyway.

I haven't checked the code but does this always work? The kernel isn't
built with interworking enabled, so it's either ARM or Thumb-2.

-- 
Catalin
