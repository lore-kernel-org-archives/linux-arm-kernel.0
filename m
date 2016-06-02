From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Jun 2016 19:09:48 +0100
Subject: [PATCH] arm64: fix the wrong comment
In-Reply-To: <1464574369-22618-1-git-send-email-shijie.huang@arm.com>
References: <1464574369-22618-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20160602180948.GE7697@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 10:12:49AM +0800, Huang Shijie wrote:
> Currently, we use the 48-bit for the kernel and user by default.
> The comment becomes stale. This patch fixes the wrong comment.
> 
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> ---
>  arch/arm64/mm/proc.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index c431787..421386759 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -209,8 +209,8 @@ ENTRY(__cpu_setup)
>  	bic	x0, x0, x5			// clear bits
>  	orr	x0, x0, x6			// set bits
>  	/*
> -	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
> -	 * both user and kernel.
> +	 * Set/prepare TCR. We use VA_BITS of address range for both
> +	 * kernel and user.
>  	 */

To be honest, all three of these comments (including the two in the
context) are totally useless. Can we just remove them instead?

Will
