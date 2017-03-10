From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 17:58:55 +0000
Subject: [PATCH 1/6] arm64: Use full path in KBUILD_IMAGE definition
In-Reply-To: <20161122213434.14788-1-mmarek@suse.com>
References: <20161122213434.14788-1-mmarek@suse.com>
Message-ID: <20170310175854.GE18894@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Tue, Nov 22, 2016 at 10:34:29PM +0100, Michal Marek wrote:
> The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
> expect it to point to the image file in the build directory. The
> builddeb script has a workaround for architectures which only provide
> the basename, but let's provide a clean interface for packaging tools.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Michal Marek <mmarek@suse.com>
> ---
>  arch/arm64/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

What's the plan for this patch? I'm happy to merge it, but I don't see
the rest of the series queued anywhere.

Thanks,

Will

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 3635b8662724..80b6866bcacb 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -94,12 +94,12 @@ libs-y		:= arch/arm64/lib/ $(libs-y)
>  core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
>  # Default target when executing plain make
> -KBUILD_IMAGE	:= Image.gz
> +boot		:= arch/arm64/boot
> +KBUILD_IMAGE	:= $(boot)/Image.gz
>  KBUILD_DTBS	:= dtbs
>  
> -all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
> +all:	Image.gz $(KBUILD_DTBS)
>  
> -boot := arch/arm64/boot
>  
>  Image: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> -- 
> 2.10.0
> 
