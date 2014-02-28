From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 10:27:13 +0100
Subject: [PATCH 3/3] PCI: imx6: ventana: fixup for IRQ mismapping
In-Reply-To: <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
Message-ID: <7755759.E1g1jlxbyc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 17:19:54 Tim Harvey wrote:
> The TI XIO2001 PCIe-to-PCI bridge used on Ventana expansion boards
> has its slot-to-bridge IRQ mapping reversed from the PCI specification:
> 
>   INTA->INTD
>   INTB->INTC
>   INTC->INTB
>   INTD->INTA
> 
> Implement a custom swizzle function that does a fixup on the interrupt for
> devices on the first TI XIO2001 bridge in the tree.
> 

I'm pretty sure you can express that by using a more specific
'interrupt-map' property that defines the correct mapping for
the PCIe-to-PCI bridge in the board file.

	Arnd
