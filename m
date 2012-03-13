From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Mar 2012 12:33:52 -0500
Subject: [PATCH v4 08/11] ep93xx: Make syscon access functions private
 to SoC
In-Reply-To: <1331592502-9083-9-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-9-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020695AB9832@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 12, 2012 3:48 PM, Ryan Mallon wrote:
>
> The syscon access functions are no longer used outside of the core
> EP93xx code. Move their definitions into the SoC code.
>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
> ---

<snip>

> diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
> index a22e11b..1273013 100644
> --- a/arch/arm/mach-ep93xx/soc.h
> +++ b/arch/arm/mach-ep93xx/soc.h
> @@ -104,4 +104,18 @@
>  #define EP93XX_WATCHDOG_PHYS_BASE	EP93XX_APB_PHYS(0x00140000)
>  #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
>  
> +/* EP93xx System Controller software locked register write */
> +void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg);
> +void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits);
> +
> +static inline void ep93xx_devcfg_set_bits(unsigned int bits)
> +{
> +	ep93xx_devcfg_set_clear(bits, 0x00);
> +}
> +
> +static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
> +{
> +	ep93xx_devcfg_set_clear(0x00, bits);
> +}
> +
>  #endif /* _EP93XX_PHYS_BASE_H */

Ryan,

I just noticed that the comment after the #endif is wrong.

It should either be /* _EP93XX_SOC_H */ or should just be removed.

Regards,
Hartley
