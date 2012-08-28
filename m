From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Aug 2012 10:06:43 +0900
Subject: [PATCH] ARM: mach-shmobile: Add compilation support for dtbs
 using 'make dtbs'
In-Reply-To: <503C1818.7020402@kmckk.co.jp>
References: <1346113322-21133-1-git-send-email-horms@verge.net.au>
 <1346113322-21133-2-git-send-email-horms@verge.net.au>
 <503C1059.10300@codeaurora.org> <503C1818.7020402@kmckk.co.jp>
Message-ID: <20120828010643.GA24108@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 10:00:08AM +0900, Tetsuyuki Kobayashi wrote:
> Simon-san,
> 
> (2012/08/28 9:27), Stephen Boyd wrote:
> >On 8/27/2012 5:22 PM, Simon Horman wrote:
> >>+dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dts
> >>+dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dts
> >
> >Shouldn't these be dtb instead of dts?
> >
> 
> Please use my v2 patch.
> I paste v2 patch here. (It was posted on 2012/07/23)

Sorry about that. Please ignore this pull request.
I will repost.

> 
> ==============================================================
> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> Add compilation support for dtbs using 'make dtbs'
> 
> Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
> Sorry, I found mistake. it should be dtb insted of dts.
> 
> Changes for v2
> - replace dts to dtb in the 3rd and 4th line of patch.
> 
>  arch/arm/mach-shmobile/Makefile.boot |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/Makefile.boot
> b/arch/arm/mach-shmobile/Makefile.boot
> index 498efd9..5e41019 100644
> --- a/arch/arm/mach-shmobile/Makefile.boot
> +++ b/arch/arm/mach-shmobile/Makefile.boot
> @@ -7,3 +7,7 @@ __ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
>  #
>  #params_phys-y (Instead: Pass atags pointer in r2)
>  #initrd_phys-y (Instead: Use compiled-in initramfs)
> +
> +dtb-$(CONFIG_MACH_KZM9G) += sh73a0-kzm9g.dtb
> +dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dtb
> +dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dtb
> -- 1.7.9.5
> 
