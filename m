From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2011 23:28:22 +0000
Subject: [PATCH] ARM: Add Cortex A7 proc info
In-Reply-To: <1323186497-31306-1-git-send-email-pawel.moll@arm.com>
References: <1323186497-31306-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20111206232822.GB16212@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Tue, Dec 06, 2011 at 03:48:17PM +0000, Pawel Moll wrote:
> This patch adds processor infos for ARM Ltd. Cortex A7.

You could elaborate a bit here :) Maybe mention that the A7 is
architecturally identical to A15?

> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/mm/proc-v7.S |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 2c559ac..ea679ec 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -284,6 +284,7 @@ __v7_ca5mp_setup:
>  __v7_ca9mp_setup:
>  	mov	r10, #(1 << 0)			@ TLB ops broadcasting
>  	b	1f
> +__v7_ca7mp_setup:
>  __v7_ca15mp_setup:
>  	mov	r10, #0
>  1:
> @@ -463,6 +464,16 @@ __v7_ca5mp_proc_info:
>  	.size	__v7_ca5mp_proc_info, . - __v7_ca5mp_proc_info
>  
>  	/*
> +	 * ARM Ltd. Cortex A7 processor.
> +	 */
> +	.type	__v7_ca7mp_proc_info, #object
> +__v7_ca7mp_proc_info:
> +	.long	0x410fc070
> +	.long	0xff0ffff0
> +	__v7_proc __v7_ca7mp_setup, hwcaps = HWCAP_IDIV
> +	.size	__v7_ca7mp_proc_info, . - __v7_ca7mp_proc_info
> +
> +	/*
>  	 * ARM Ltd. Cortex A9 processor.
>  	 */
>  	.type   __v7_ca9mp_proc_info, #object

Tested-by: Will Deacon <will.deacon@arm.com>

Will
