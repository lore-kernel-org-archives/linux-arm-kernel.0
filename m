From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Jan 2015 10:39:27 +0000
Subject: [PATCH] arm64: Add dtb files to archclean rule
In-Reply-To: <FF2CE3A3-56DA-4637-833F-264DD986F28C@gmail.com>
References: <FF2CE3A3-56DA-4637-833F-264DD986F28C@gmail.com>
Message-ID: <20150119103926.GC32131@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 01:59:31PM +0000, Jungseok Lee wrote:
> As dts files have been reorganised under vendor subdirs, dtb files
> cannot be removed with "make distclean" now. Thus, this patch adds
> dtb files to archclean rule.
> 
> Cc: Robert Richter <rrichter@cavium.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> ---
>  arch/arm64/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 1c43cec..0666888 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -85,6 +85,7 @@ vdso_install:
>  # We use MRPROPER_FILES and CLEAN_FILES now
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
> +	$(Q)$(MAKE) $(clean)=$(boot)/dts

Looks sensible. I think we can also remove the always/clean-files entries
from arch/arm64/boot/dts/Makefile.

Will
