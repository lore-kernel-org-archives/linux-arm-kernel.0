From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jan 2014 09:59:58 +0000
Subject: [PATCHv2] arm64: Add CONFIG_CC_STACKPROTECTOR
In-Reply-To: <1390604955-6309-1-git-send-email-lauraa@codeaurora.org>
References: <1390604955-6309-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140127095958.GA6547@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Fri, Jan 24, 2014 at 11:09:15PM +0000, Laura Abbott wrote:
> arm64 currently lacks support for -fstack-protector. Add
> similar functionality to arm to detect stack corruption.

[...]

> +/*
> + * Initialize the stackprotector canary value.
> + *
> + * NOTE: this must only be called from functions that never return,
> + * and it must always be inlined.
> + */
> +static __always_inline void boot_init_stack_canary(void)
> +{
> +	unsigned long canary;
> +
> +	/* Try to get a semi random initial value. */
> +	get_random_bytes(&canary, sizeof(canary));
> +	canary ^= LINUX_VERSION_CODE;
> +
> +	current->stack_canary = canary;

Do we actually need this line now?

Will
