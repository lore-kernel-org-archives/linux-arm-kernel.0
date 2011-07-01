From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 01 Jul 2011 15:12:16 +0400
Subject: [PATCH] ARM: DMA: Add missing semicolon for the define of
	dma_alloc_area
In-Reply-To: <1309509472.30642.1.camel@phoenix>
References: <1309509472.30642.1.camel@phoenix>
Message-ID: <4E0DAB90.9080708@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-07-2011 12:37, Axel Lin wrote:

> I got below build error by: make at91x40_defconfig;make
> Fix it by adding a missing semicolon for the define of dma_alloc_area.

>    CC      arch/arm/mm/dma-mapping.o
> arch/arm/mm/dma-mapping.c:309: warning: 'struct dma_coherent_area' declared inside parameter list
> arch/arm/mm/dma-mapping.c:309: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/mm/dma-mapping.c: In function '__dma_alloc':
> arch/arm/mm/dma-mapping.c:324: error: expected ';' before '}' token
> arch/arm/mm/dma-mapping.c: At top level:
> arch/arm/mm/dma-mapping.c:334: warning: 'struct dma_coherent_area' declared inside parameter list
> arch/arm/mm/dma-mapping.c:374: warning: 'struct dma_coherent_area' declared inside parameter list
> make[1]: *** [arch/arm/mm/dma-mapping.o] Error 1
> make: *** [arch/arm/mm] Error 2

    You didn't fix the warning though, so not clear why you cited them....

> Signed-off-by: Axel Lin<axel.lin@gmail.com>

WBR, Sergei
