From: monstr@monstr.eu (Michal Simek)
Date: Wed, 25 Jul 2018 09:20:50 +0200
Subject: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead
 of LD
In-Reply-To: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
 <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <542827d9-38fe-b145-234b-764ab6b7f612@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3.7.2018 03:22, Masahiro Yamada wrote:
> With the recent syntax extension, Kconfig is now able to evaluate the
> compiler / toolchain capability.
> 
> However, accumulating flags to 'LD' is not compatible with the way
> it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
> from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
> CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
> between Makefile and Kconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/microblaze/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index d269dd4b..7333036 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
>  ifdef CONFIG_CPU_BIG_ENDIAN
>  KBUILD_CFLAGS += -mbig-endian
>  KBUILD_AFLAGS += -mbig-endian
> -LD += -EB
> +LDFLAGS += -EB
>  else
>  KBUILD_CFLAGS += -mlittle-endian
>  KBUILD_AFLAGS += -mlittle-endian
> -LD += -EL
> +LDFLAGS += -EL
>  endif
>  
>  CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
> 

Applied to next.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180725/12f8c158/attachment.sig>
