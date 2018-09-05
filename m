From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 5 Sep 2018 13:36:40 -0700
Subject: [RESEND PATCHv2 3/4] arm64: dts: add support for building DT
 overlays
In-Reply-To: <1536048344-9995-4-git-send-email-t-kristo@ti.com>
References: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-4-git-send-email-t-kristo@ti.com>
Message-ID: <bbfcd3d0-d3ce-d499-f14d-e284008c959a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/18 01:05, Tero Kristo wrote:
> Add simple support for building DT overlays. This just compiles any
> given .dtso file under the base arch/arm64/boot/dts/*/ directory into
> a .dtbo.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 106039d..f04c814 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -127,7 +127,7 @@ Image.%: Image
>  zinstall install:
>  	$(Q)$(MAKE) $(build)=$(boot) $@
>  
> -%.dtb: scripts
> +%.dtb %.dtbo: scripts
>  	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
>  
>  PHONY += dtbs dtbs_install
> 

Same comments as for patch 1/4.
