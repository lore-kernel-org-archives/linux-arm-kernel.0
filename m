From: vkoul@kernel.org (Vinod)
Date: Tue, 9 Oct 2018 14:27:57 +0530
Subject: [PATCH v3 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
In-Reply-To: <5d7a218c-9e96-3931-88ab-0b4dcb3ec4e5@st.com>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
 <20181007145722.GY2372@vkoul-mobl>
 <5d7a218c-9e96-3931-88ab-0b4dcb3ec4e5@st.com>
Message-ID: <20181009085757.GI2372@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre,

On 09-10-18, 09:18, Pierre Yves MORDRET wrote:

> >>  * DMA client
> >> @@ -68,7 +84,16 @@ channel: a phandle to the DMA controller plus the following four integer cells:
> >>  	0x1: 1/2 full FIFO
> >>  	0x2: 3/4 full FIFO
> >>  	0x3: full FIFO
> >> -
> >> + -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
> >> +	0: MDMA not used to generate an intermediate M2M transfer
> >> +	1: MDMA used to generate an intermediate M2M transfer.
> >> + -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.
> >> +	PAGE_SIZE is given by Linux at 4KiB: include/asm-generic/page.h.
> >> +	Order is given by those 2 bits starting at 0.
> >> +	Valid only whether Intermediate M2M transfer is set.
> > 
> > why do we need this as a property?
> 
> In some UC, we need more than 4KiB in case of chaining for better performances.
> Chaining has to be enabled by client if performance is at sacks.

Okay if that is the case why is the user not taking care of this?
Creating DMA txn and chaining them up and starting the chain? Why would
dmaengine driver need to do that?

-- 
~Vinod
