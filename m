From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Nov 2011 18:46:19 +0000
Subject: [PATCH v3 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111130155800.GF2045@localhost.localdomain>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-4-git-send-email-pawel.moll@arm.com>
 <20111130155800.GF2045@localhost.localdomain>
Message-ID: <1322678779.3180.36.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 15:58 +0000, Dave Martin wrote:
> Now that a person may fail to boot on a supported board simply due to
> failing to supply a device tree, it may be a good idea to have a more
> helpful panic message for that situation, perhaps something like the
> following.
> 
> If you don't think this fits in this series, I can always follow up 
> later.
> 
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 6965f64..9dda482 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -434,8 +434,11 @@ static void __init v2m_populate_ct_desc(void)
>  			ct_desc = ct_descs[i];
>  
>  	if (!ct_desc)
> -		panic("vexpress: failed to populate core tile description "
> -		      "for tile ID 0x%8x\n", current_tile_id);
> +		panic("vexpress: this kernel does not support core tile ID "
> +		      "0x%08x when booting via ATAGs.\n"
> +		      "You may need a device tree blob or a different kernel "
> +		      "to boot on this board.\n",
> +		      current_tile_id);
>  }
>  
>  static void __init v2m_map_io(void)
> 

No, that's cool with me, will add that. Thanks!

Pawel
