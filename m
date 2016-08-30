From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 15:43:16 +0100
Subject: [PATCH v2 9/9] arm64: head.S: document the use of callee saved
 registers
In-Reply-To: <1472049366-10922-10-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472049366-10922-10-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160830144316.GL1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 04:36:06PM +0200, Ard Biesheuvel wrote:
> Now that the only remaining occurrences of the use of callee saved
> registers are on the primary boot path, add a comment to the code
> which register is used for what.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/head.S | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index ad1dc61d67ac..8bc9458f9add 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -208,6 +208,16 @@ efi_header_end:
>  
>  	__INIT
>  
> +	/*
> +	 * The following callee saved general purpose registers are used on the
> +	 * primary lowlevel boot path:
> +	 *
> +	 *  Register   Scope                      Purpose
> +	 *  x21        stext() .. start_kernel()  FDT pointer passed at boot in x0
> +	 *  x23        stext() .. start_kernel()  physical misalignment/KASLR offset
> +	 *  x28        __create_page_tables()     callee preserved temp register
> +	 *  x19/x20    __primary_switch()         callee preserved temp registers
> +	 */
>  ENTRY(stext)
>  	bl	preserve_boot_args
>  	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
> -- 
> 2.7.4
> 
