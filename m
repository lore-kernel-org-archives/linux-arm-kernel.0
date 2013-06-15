From: balbi@ti.com (Felipe Balbi)
Date: Sat, 15 Jun 2013 18:06:50 +0300
Subject: [PATCH 3/8] ARM: OMAP2+: hwmod: Remove remaining DMA channel
 definitions
In-Reply-To: <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
 <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <20130615150650.GB27629@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 11:31:04AM +0300, Jarkko Nikula wrote:
> Last remaining DMA channel definitions in arch/arm/mach-omap2/dma.h
> are used only by omap_hwmod_2xxx_3xxx_ipblock_data.c and
> omap_hwmod_3xxx_data.c. Remove them by using directly DMA channel number in
> hwmod data and drop definitions with a following script:
> 
> egrep '#define [OMAP|AM35XX].*DMA' arch/arm/mach-omap2/dma.h | cut -f 1,3 \
> 	| while read i; do \
> 		DEF=`echo $i |cut -d ' ' -f 2`; \
> 		CH=`echo $i |cut -d ' ' -f 3`; \
> 		echo "removing" $DEF; \
> 		sed -i "s/${DEF}/${CH}/" arch/arm/mach-omap2/omap_hwmod_*.c; \
> 		sed -i "/${DEF}/d" arch/arm/mach-omap2/dma.h; \
> 	done
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/dma.h                          |   19 -------------------
>  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   20 ++++++++++----------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   18 +++++++++---------
>  3 files changed, 19 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dma.h b/arch/arm/mach-omap2/dma.h
> index 8a71c7b..aa735a4 100644
> --- a/arch/arm/mach-omap2/dma.h
> +++ b/arch/arm/mach-omap2/dma.h
> @@ -21,27 +21,8 @@
>  
>  
>  /* DMA channels for 24xx */

could remove the comments too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130615/688f85ad/attachment-0001.sig>
