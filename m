From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2016 10:07:13 +0000
Subject: [RFC PATCH 09/11] ARM: NOMMU: define SECTION_xxx macros
In-Reply-To: <1479806768-39911-10-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-10-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20161122100713.GW1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 09:26:06AM +0000, Vladimir Murzin wrote:
> Pickup defines from pgtable-2level.h to make NOMMU build happy.

This needs more detail.

> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/pgtable-nommu.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
> index add094d..9115801 100644
> --- a/arch/arm/include/asm/pgtable-nommu.h
> +++ b/arch/arm/include/asm/pgtable-nommu.h
> @@ -35,6 +35,11 @@
>  
>  #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
>  #define PGDIR_MASK		(~(PGDIR_SIZE-1))
> +
> +#define SECTION_SHIFT           20
> +#define SECTION_SIZE            (1UL << SECTION_SHIFT)
> +#define SECTION_MASK            (~(SECTION_SIZE-1))
> +
>  /* FIXME */
>  
>  #define PAGE_NONE	__pgprot(0)
> -- 
> 1.7.9.5
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
