From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 09 Aug 2013 17:05:09 +0530
Subject: [PATCH RFC 46/51] ARM: DMA-API: better handing of DMA masks for
 coherent allocations
In-Reply-To: <E1V51EE-0006uO-C2@rmk-PC.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
 <E1V51EE-0006uO-C2@rmk-PC.arm.linux.org.uk>
Message-ID: <5204D3ED.70504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 03:50 AM, Russell King wrote:
> We need to start treating DMA masks as something which is specific to
> the bus that the device resides on, otherwise we're going to hit all
> sorts of nasty issues with LPAE and 32-bit DMA controllers in >32-bit
> systems, where memory is offset from PFN 0.
> 
> In order to start doing this, we convert the DMA mask to a PFN using
> the device specific dma_to_pfn() macro.  This is the reverse of the
> pfn_to_dma() macro which is used to get the DMA address for the device.
> 
> This gives us a PFN mask, which we can then check against the PFN
> limit of the DMA zone.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/dma-mapping.c |   49 ++++++++++++++++++++++++++++++++++++++++----
>  arch/arm/mm/init.c        |    2 +
>  arch/arm/mm/mm.h          |    2 +
>  3 files changed, 48 insertions(+), 5 deletions(-)
> 

Tested on Arndale board with ARM_LPAE enabled.

Tested-by: Tushar Behera <tushar.behera@linaro.org>

-- 
Tushar Behera
