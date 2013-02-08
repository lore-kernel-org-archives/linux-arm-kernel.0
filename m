From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Feb 2013 12:27:14 +0000
Subject: [PATCH v3 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <1360323892-2860-1-git-send-email-shawn.guo@linaro.org>
References: <20130206093236.GD17833@n2100.arm.linux.org.uk>
 <1360323892-2860-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130208122714.GP17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 07:44:52PM +0800, Shawn Guo wrote:
> Instead of giving zero support of uncompress debug for multiplatform
> build, the patch turns uncompress debug into one part of DEBUG_LL
> support.  When DEBUG_LL is turned on for a particular platform,
> uncompress debug works too for that platform.
> 
> It reuses the platform DEBUG_LL macros by creating a simple
> arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
> included there, and implements a generic putc() using those macros.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> ---
> Changes since v2:
>  * Build arch/arm/boot/compressed/debug.S only for multiplatform kernel
>    to fix the breakage on traditional platform build
>  * Include asm/assembler.h in arch/arm/boot/compressed/debug.S, as it
>    may commonly be needed by platforms to be converted to multiplatform
> 
> Russell,
> 
> I will put it into patch system if I do not receive any comment
> tomorrow.

This doesn't address the problem with OMAP, which is that the OMAP debug
code places data into the .data section, and that is not allowed in the
decompressor.
