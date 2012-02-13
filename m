From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Feb 2012 16:16:26 -0600
Subject: [PATCH 11/15] ARM: ep93xx: clean-up mach/io.h
In-Reply-To: <1329169408-17253-12-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-12-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB4EB4@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2012 2:43 PM, Rob Herring wrote:
>
> Move ep93xx specifics in mach/io.h to ep93xx-regs.h.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index c4a7b84..8933c62 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -25,6 +25,12 @@
>   *	http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
>   */
>  
> +#ifdef __ASSEMBLER__
> +#define IOMEM(p)                p
> +#else
> +#define IOMEM(p)                ((void __iomem __force *)(p))
> +#endif
> +
>  #define EP93XX_CS0_PHYS_BASE_ASYNC	0x00000000	/* ASDO Pin = 0 */
>  #define EP93XX_SDCE3_PHYS_BASE_SYNC	0x00000000	/* ASDO Pin = 1 */
>  #define EP93XX_CS1_PHYS_BASE		0x10000000

Can you please keep the comment from io.h with this move?

Also, the definition in io.h should be also be removed in this patch so that
git bisect works.

Other than that, this works on EP93xx.

I'll hold my Ack until I hear back.

Thanks,
Hartley
