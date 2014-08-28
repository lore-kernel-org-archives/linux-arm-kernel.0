From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Aug 2014 18:02:01 +0100
Subject: [PATCHv3 1/7] arm64: Treat handle_arch_irq as a function pointer
In-Reply-To: <1408584039-12735-2-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140828170200.GD31111@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:20:33AM +0100, Laura Abbott wrote:
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -168,7 +168,8 @@ tsk	.req	x28		// current thread_info
>   * Interrupt handling.
>   */
>  	.macro	irq_handler
> -	ldr	x1, handle_arch_irq
> +	adrp x1, handle_arch_irq
> +	ldr x1, [x1, #:lo12:handle_arch_irq]

Nitpick: please keep the tabs between instructions and registers, it
looks nicer with the rest of the code.

-- 
Catalin
