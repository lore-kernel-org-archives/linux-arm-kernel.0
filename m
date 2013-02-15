From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Feb 2013 09:25:34 -0700
Subject: [RFC 1/2] Makefile: Add arch/arch/$(hdr-arch)/boot in header
 include path
In-Reply-To: <1360918364-27960-1-git-send-email-hdoyu@nvidia.com>
References: <1360918364-27960-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <511E617E.6080206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2013 01:52 AM, Hiroshi Doyu wrote:
> With a new feature dtc+cpp, DT can introduces some definitions in its
> header files for their own. Some of those DT info can be used in
> kernel source as well, instead of having the duplicate info in kernel
> headers. This patch allows kernel source to include those DT
> headers. For example:
> 
> + #include <dts/tegra20-car.h>

Since this is devicetree-related, the DT maintainers should also be
CC'd. I've added them on this email, hence quoting the entire patch.

> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 0b4bf62..7f54cdb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -364,7 +364,7 @@ LINUXINCLUDE    := \
>  		-I$(srctree)/arch/$(hdr-arch)/include \
>  		-Iarch/$(hdr-arch)/include/generated \
>  		$(if $(KBUILD_SRC), -I$(srctree)/include) \
> -		-Iinclude \
> +		-Iinclude -Iarch/$(hdr-arch)/boot \
>  		$(USERINCLUDE)
>  
>  KBUILD_CPPFLAGS := -D__KERNEL__
> 
