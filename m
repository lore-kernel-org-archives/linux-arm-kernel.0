From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 28 Oct 2015 10:54:58 +0000
Subject: [PATCH] ARM64: juno: disable NOR flash node by default
In-Reply-To: <1446025195-9264-1-git-send-email-linus.walleij@linaro.org>
References: <1446025195-9264-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5630A982.5080505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/10/15 09:39, Linus Walleij wrote:
> After discussing on the mailing list it turns out that
> accessing the flash memory from the kernel can disrupt CPU
> sleep states and CPU hotplugging, so let's disable this
> DT node by default. Setups that want to access the flash
> can modify this entry to enable the flash again.
>
> Quoting Sudeep Holla: "the firmware assumes the flash is
> always in read mode while Linux leaves NOR flash in
> "read id" mode after initialization."
>
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Thanks for the patch. I too wrote one last night after I found
NOR flash was added in arm-soc -next.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
