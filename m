From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2017 14:24:24 +0000
Subject: [PATCH 1/4] ARM: mmu: decouple VECTORS_BASE from Kconfig
In-Reply-To: <20170118203739.6400-1-afzal.mohd.ma@gmail.com>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203739.6400-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170119142424.GZ27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:07:39AM +0530, afzal mohammed wrote:
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 76cbd9c674df..9cc9f1dbc88e 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -83,6 +83,8 @@
>  #define IOREMAP_MAX_ORDER	24
>  #endif
>  
> +#define VECTORS_BASE		0xffff0000

This should be UL(0xffff0000)

> -			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
> -				(PAGE_SIZE)),
> +			MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),

which means you don't need it here, which will then fix the build error
reported by the 0-day builder.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
