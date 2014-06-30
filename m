From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 15:45:07 +0100
Subject: [PATCH] arm: vmlinux.lds.S: drop redundant .comment
In-Reply-To: <1403630948-30702-1-git-send-email-mark.rutland@arm.com>
References: <1403630948-30702-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20140630144507.GB8756@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 24, 2014 at 06:29:08PM +0100, Mark Rutland wrote:
> Commit 78d7530ac3 ("ARM: Clean up linker script using new linker script
> macros.") modified the arm kernel linker script to use the STABS_DEBUG
> macro, but left a .comment section definition. As STABS_DEBUG defines
> the .comment section in an identical way, the second section definition
> is redundant and can be removed.
> 
> This patch removes the redundant .comment section definition.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm/kernel/vmlinux.lds.S | 1 -
>  1 file changed, 1 deletion(-)

On the assumption that the below patch is fine I've dropped it into the
patch system as 8088/1.

Thanks,
Mark.

> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 7bcee5c..6f57cb9 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -318,7 +318,6 @@ SECTIONS
>  	_end = .;
>  
>  	STABS_DEBUG
> -	.comment 0 : { *(.comment) }
>  }
>  
>  /*
> -- 
> 1.9.1
> 
