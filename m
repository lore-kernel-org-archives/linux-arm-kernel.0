From: gxt@pku.edu.cn (Guan Xueao)
Date: Mon, 19 Mar 2012 17:05:35 +0800
Subject: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4F66F6DF.8010609@pku.edu.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2012 05:03 AM, Stephen Warren wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
>
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.
>
> Signed-off-by: Stephen Warren<swarren@wwwdotorg.org>
> ---
> v2:
> * Fix blackfin's UIMAGE_LOADADDR in the ROMKERNEL case.
> * Fix missing ) on a variable reference in avr32 and sparc.
> * Only set those UIMAGE_* variables that the arch-specific Makefile hasn't
>    already set.
> * The patch series is now just this single patch which removes duplication;
>    I've dropped the Kconfig feature to allow use of -T kernel_noload for
>    now, since it looks like U-Boot is gaining direct zImage support.
>
>
Tested on unicore32.

Tested-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
