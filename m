From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 12 Oct 2011 10:37:22 -0400 (EDT)
Subject: [PATCH] ARM: zImage: Use $(CROSS_COMPILE)size to get .bss size
In-Reply-To: <1318419203-27165-1-git-send-email-weber@corscience.de>
References: <1318419203-27165-1-git-send-email-weber@corscience.de>
Message-ID: <alpine.LFD.2.02.1110121029470.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Oct 2011, Thomas Weber wrote:

> Use $(CROSS_COMPILE)size to determine the bss size
> from vmlinux.
> 
> The problem is introduced in:
> commit 8738646c02064d38f6fb056eb039ebf9138c5434
> 
> ARM: zImage: make sure appended DTB doesn't get
> overwritten by kernel .bss
> 
> This fixes following error message:
> 
> size: arch/arm/boot/compressed/../../../../vmlinux:
> File format is ambiguous
> 
> size: Matching formats:
> elf32-littlearm
> elf32-littlearm-symbian
> elf32-littlearm-vxworks
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

However I don't know where you picked up a reference to commit 
8738646c02 which is nonexistent in any of my repositories.  The right 
reference from RMK's devel-stable branch would be commit 5ffb04f669.  
Please fix that and send to the patch system.


Nicolas
