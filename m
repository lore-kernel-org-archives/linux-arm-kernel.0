From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 11 Jun 2012 11:31:19 +0200
Subject: [PATCHv2 04/12] ARM: OMAP4: hwmod data: fix 32k sync timer idle
 modes
In-Reply-To: <20120611004602.20034.73590.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004602.20034.73590.stgit@dusk>
Message-ID: <4FD5BAE7.7080805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> The 32k sync timer IP block target idle modes are incorrect in the
> hwmod data are incorrect.

Nit: Is there too many "incorrect" in this sentence?

> The IP block does not support any
> smart-idle modes.  Update the data to reflect the correct modes.
>
> This problem was initially identified and a diff fragment posted to
> the lists by Beno?t Cousson <b-cousson@ti.com>.

Thanks for taking care of that patch.

Benoit

>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 4aaaa84..6b0aedc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -393,8 +393,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_counter_sysc = {
>   	.rev_offs	= 0x0000,
>   	.sysc_offs	= 0x0004,
>   	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   SIDLE_SMART_WKUP),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
>   	.sysc_fields	= &omap_hwmod_sysc_type1,
>   };
>
>
>
