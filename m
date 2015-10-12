From: sam@ravnborg.org (Sam Ravnborg)
Date: Mon, 12 Oct 2015 22:04:23 +0200
Subject: [RFC] arm: add __initbss section attribute
In-Reply-To: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com>
References: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <20151012200422.GA29175@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
>  
> -#define BSS_SECTION(sbss_align, bss_align, stop_align)			\
> +#define BSS_SECTION(sbss_align, bss_align, initbss_align, stop_align)			\

A few comments:

1) - please align the backslash at the end of the
     line with the backslash above it.
2) - you need to fix all the remaining users of BSS_SECTION.
3) - do we really need the flexibility to specify an alignment (stop_align)?
        If not - drop the extra argument.

	Sam
