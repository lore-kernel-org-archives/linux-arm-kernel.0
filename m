From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 09:38:58 +0100
Subject: [PATCHv2] ARM: zImage: Use $(CROSS_COMPILE)size to get .bss size
In-Reply-To: <1318488622-20023-1-git-send-email-weber@corscience.de>
References: <1318488622-20023-1-git-send-email-weber@corscience.de>
Message-ID: <20111013083858.GH21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 08:50:22AM +0200, Thomas Weber wrote:
> Use $(CROSS_COMPILE)size to determine the bss size
> from vmlinux.
> 
> The problem is introduced in:
> 
> commit 5ffb04f6690d71fab241b3562ebf52b893ac4ff1
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
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Thomas Weber <weber@corscience.de>

This is going to totally break my ability to build any kernels at the
moment - for some reason I don't have an arm-linux-size with all the
other bits of binutils, so I've been relying on the x86 version so far.
I'll add it to the list of things to look at...
