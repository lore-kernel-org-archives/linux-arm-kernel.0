From: vapier@gentoo.org (Mike Frysinger)
Date: Tue, 6 Mar 2012 22:56:07 -0500
Subject: [PATCH 1/3] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201203062256.16105.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 March 2012 19:30:36 Stephen Warren wrote:
> --- a/arch/blackfin/boot/Makefile
> +++ b/arch/blackfin/boot/Makefile
> 
> +ifeq ($(CONFIG_RAMKERNEL),y)
> +UIMAGE_LOADADDR = $(CONFIG_BOOT_LOAD)
> +else # CONFIG_ROMKERNEL must be set
> +UIMAGE_LOADADDR = $(CONFIG_BOOT_LOAD)
> +endif

this part is wrong :).  the else branch should be $(CONFIG_ROM_BASE).

> +UIMAGE_ENTRYADDR = $(shell $(NM) vmlinux | awk '$$NF == "__start" {print
> $$1}')

i feel like if we tried harder, we could automate the -e arg for all arches.  
i understand if you don't want to undertake that though.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/5db9b985/attachment-0001.sig>
