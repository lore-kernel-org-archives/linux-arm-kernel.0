From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Nov 2013 17:27:40 +0000
Subject: [PATCH] arm: add support for the Cortex-A12 processor
In-Reply-To: <1382532376-22758-1-git-send-email-jonathan.austin@arm.com>
References: <1382532376-22758-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <20131106172740.GA4524@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 01:46:16PM +0100, Jonathan Austin wrote:
> The A12 behaves as the A7/A15 does with respect to setting the SMP bit, and
> doesn't require TLB ops broadcasting to be explicitly enabled like the A9 does.
> 
> Note that as the ACTLR cannot (usually) be written from non-secure, it is the
> responsibility of the bootloader/firmware to set this bit per core - it is
> done here in Linux as last resort in case of bad firmware.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---
>  arch/arm/mm/proc-v7.S |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 3a5922d..9745288 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -164,6 +164,7 @@ __v7_cr7mp_setup:
>  	mov	r10, #(1 << 0)			@ Cache/TLB ops broadcasting
>  	b	1f
>  __v7_ca7mp_setup:
> +__v7_ca12mp_setup:
>  __v7_ca15mp_setup:
>  	mov	r10, #0
>  1:
> @@ -440,6 +441,16 @@ __v7_ca7mp_proc_info:
>  	.size	__v7_ca7mp_proc_info, . - __v7_ca7mp_proc_info
>  
>  	/*
> +	 * ARM Ltd. Cortex A12 processor.
> +	 */
> +	.type	__v7_ca12mp_proc_info, #object
> +__v7_ca12mp_proc_info:
> +	.long	0x410fc0d0

Great, looks like we can't count.

Please put this into the patch system:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
