From: monstr@monstr.eu (Michal Simek)
Date: Mon, 19 Mar 2012 07:46:10 +0100
Subject: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4F66D632.5070107@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
> 
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> v2:
> * Fix blackfin's UIMAGE_LOADADDR in the ROMKERNEL case.
> * Fix missing ) on a variable reference in avr32 and sparc.
> * Only set those UIMAGE_* variables that the arch-specific Makefile hasn't
>   already set.
> * The patch series is now just this single patch which removes duplication;
>   I've dropped the Kconfig feature to allow use of -T kernel_noload for
>   now, since it looks like U-Boot is gaining direct zImage support.
> 
>  arch/arm/boot/Makefile          |   23 +++++++++--------------
>  arch/avr32/boot/images/Makefile |    9 +++------
>  arch/blackfin/boot/Makefile     |   19 ++++++++-----------
>  arch/microblaze/boot/Makefile   |   10 +++-------
>  arch/sh/boot/Makefile           |    8 ++------
>  arch/sparc/boot/Makefile        |    9 +++------
>  arch/unicore32/boot/Makefile    |   12 ++----------
>  scripts/Makefile.lib            |   24 ++++++++++++++++++++++++
>  8 files changed, 54 insertions(+), 60 deletions(-)

No problem for Microblaze.

Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
