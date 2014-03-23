From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 23 Mar 2014 01:47:16 +0100
Subject: [PATCH 16/62] ARM: ixp4xx: avoid use of PCIBIOS_MIN_MEM in io.h
In-Reply-To: <1395257399-359545-17-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 19 Mar 2014 20:29:13 +0100")
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-17-git-send-email-arnd@arndb.de>
Message-ID: <m3txaphhbf.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> When using CONFIG_IXP4XX_INDIRECT_PCI, we run into a recursive
> header file dependency between mach/io.h and asm/pci.h, resulting
> in a build failure:

> +++ b/arch/arm/mach-ixp4xx/include/mach/io.h
> @@ -48,9 +48,10 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
>   * fallback to the default.
>   */
>  
> +extern unsigned long pcibios_min_mem;
>  static inline int is_pci_memory(u32 addr)
>  {
> -	return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
> +	return (addr >= pcibios_min_mem) && (addr <= 0x4FFFFFFF);
>  }
>  

Not that I like externs very much, but since we're fixing things...
Polishing may be done later.

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
