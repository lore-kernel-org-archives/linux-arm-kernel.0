From: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 30 Sep 2009 23:39:25 +0200
Subject: [PATCH 2/2] arm: Clean up linker script using new linker
	script macros.
In-Reply-To: <1254345935-15958-3-git-send-email-tabbott@ksplice.com>
References: <1254345935-15958-1-git-send-email-tabbott@ksplice.com>
	<1254345935-15958-3-git-send-email-tabbott@ksplice.com>
Message-ID: <20090930213924.GB15732@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2009 at 05:25:35PM -0400, Tim Abbott wrote:
> From: Nelson Elhage <nelhage@ksplice.com>
> 
> This patch is mostly a straightforward translation. The primary side
> effect to the resulting vmlinux should be to increase the alignment on
> the initramfs to the standard PAGE_SIZE from 32 bytes.
> 
> Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tim Abbott <tabbott@ksplice.com>
> ---
>  arch/arm/kernel/vmlinux.lds.S |   75 +++++++++++-----------------------------
>  1 files changed, 21 insertions(+), 54 deletions(-)
> 
>  
> -	.bss : {
> -		__bss_start = .;	/* BSS				*/
> -		*(.bss)
> -		*(COMMON)
> -		__bss_stop = .;
> -		_end = .;

Where is _end in the new layout?
I think we lost it.

> -	}
> -					/* Stabs debugging sections.	*/
> -	.stab 0 : { *(.stab) }
> -	.stabstr 0 : { *(.stabstr) }
> -	.stab.excl 0 : { *(.stab.excl) }
> -	.stab.exclstr 0 : { *(.stab.exclstr) }
> -	.stab.index 0 : { *(.stab.index) }
> -	.stab.indexstr 0 : { *(.stab.indexstr) }
> +	BSS_SECTION(0, 0, 0)
> +	STABS_DEBUG
>  	.comment 0 : { *(.comment) }
>  }

Other than that.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
