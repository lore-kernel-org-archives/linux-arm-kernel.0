From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Aug 2012 16:29:07 -0700
Subject: [PATCH v2 03/31] arm64: Exception handling
In-Reply-To: <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120814232907.GB19607@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This one is a bit denser, so just a quick first pass with a couple of minor
comments. I'll revisit the rest.

On Tue, Aug 14, 2012 at 06:52:04PM +0100, Catalin Marinas wrote:

> +el1_sp_pc:
> +	/*
> +	 *Stack or PC alignment exception handling
> +	 */
> +	mrs	x0, far_el1
> +	mov	x1, x25
> +	mov	x2, sp
> +	b	do_sp_pc_abort
> +el1_undef:
> +	/*
> +	 *Undefined instruction
> +	 */

Nit: Missing spaces in the comment here and the one above.

> +el0_undef:
> +	/*
> +	 *Undefined instruction
> +	 */
> +	mov	x0, sp
> +	b	do_undefinstr

Here too.

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> new file mode 100644
> index 0000000..8712a8e
> --- /dev/null
> +++ b/arch/arm64/kernel/traps.c
[...]
> +DEFINE_SPINLOCK(die_lock);

Should probably be static.
