From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 16 Feb 2015 15:16:46 +0100
Subject: [PATCH 08/11] ARM: ixp4xx: fix {in,out}s{bwl} data types
In-Reply-To: <1423770163-583064-9-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 12 Feb 2015 20:42:40 +0100")
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-9-git-send-email-arnd@arndb.de>
Message-ID: <m3fva6vt4h.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Most platforms use void pointer arguments in these functions, but
> ixp4xx does not, which triggers lots of warnings in device drivers like:
>
> net/ethernet/8390/ne2k-pci.c: In function 'ne2k_pci_get_8390_hdr':
> net/ethernet/8390/ne2k-pci.c:503:3: warning: passing argument 2 of 'insw' from incompatible pointer type
>    insw(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr)>>1);
>    ^
> In file included from include/asm/io.h:214:0,
>                  from /git/arm-soc/include/linux/io.h:22,
>                  from /git/arm-soc/include/linux/pci.h:31,
>                  from net/ethernet/8390/ne2k-pci.c:48:
> mach-ixp4xx/include/mach/io.h:316:91: note: expected 'u16 *' but argument is of type 'struct e8390_pkt_hdr *'
>  static inline void insw(u32 io_addr, u16 *vaddr, u32 count)
>
> Fixing the drivers seems hopeless, so this changes the ixp4xx code
> to do the same as the others to avoid the warnings.

Acked-by: Krzysztof Halasa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
