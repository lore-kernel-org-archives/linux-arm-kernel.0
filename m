From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Apr 2017 15:55:15 +0200
Subject: [PATCH v3 06/32] avr32: include default ioremap_nopost()
 implementation
In-Reply-To: <20170411122923.6285-7-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-7-lorenzo.pieralisi@arm.com>
Message-ID: <d6124409-3603-4702-9684-419247856b27@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/04/2017 ? 14:28, Lorenzo Pieralisi a ?crit :
> The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Posting")
> mandate non-posted configuration transactions. As further highlighted in
> the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
> Enhanced Configuration Access Mechanism"), through ECAM and
> ECAM-derivative configuration mechanism, the memory mapped transactions
> from the host CPU into Configuration Requests on the PCI express fabric
> may create ordering problems for software because writes to memory
> address are typically posted transactions (unless the architecture can
> enforce through virtual address mapping non-posted write transactions
> behaviour) but writes to Configuration Space are not posted on the PCI
> express fabric.
> 
> Include the asm-generic ioremap_nopost() implementation (currently
> falling back to ioremap_nocache()) to provide a non-posted writes
> ioremap interface to kernel subsystems.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> ---
>  arch/avr32/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)

You probably need to remove this one as the avr32 architecture will be
removed in kernel 4.12:

https://lkml.org/lkml/2017/3/27/422

Best regards,

> diff --git a/arch/avr32/include/asm/io.h b/arch/avr32/include/asm/io.h
> index f855646..b2ff522 100644
> --- a/arch/avr32/include/asm/io.h
> +++ b/arch/avr32/include/asm/io.h
> @@ -298,6 +298,7 @@ extern void __iounmap(void __iomem *addr);
>  #define ioremap_wc ioremap_nocache
>  #define ioremap_wt ioremap_nocache
>  #define ioremap_uc ioremap_nocache
> +#include <asm-generic/ioremap-nopost.h>
>  
>  #define cached(addr) P1SEGADDR(addr)
>  #define uncached(addr) P2SEGADDR(addr)
> 


-- 
Nicolas Ferre
