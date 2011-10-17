From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Oct 2011 16:10:22 +0200
Subject: [PATCH v3] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1318859861.23438.137.camel@vkoul-udesk3>
References: <1318844199-19303-1-git-send-email-Barry.Song@csr.com>
	<1318859861.23438.137.camel@vkoul-udesk3>
Message-ID: <CACRpkdadRanBUNQZQMEX6En8A-=spqJUojOOrGAmTCJzMfvo7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 3:57 PM, Vinod Koul <vinod.koul@intel.com> wrote:

>> + ? ? if (sdesc->cyclic) {
>> + ? ? ? ? ? ? writel((1 << cid) | 1 << (cid + 16) |
>> + ? ? ? ? ? ? ? ? ? ? readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL),
>> + ? ? ? ? ? ? ? ? ? ? sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
>> + ? ? ? ? ? ? schan->happened_cyclic = schan->completed_cyclic = 0;
>> + ? ? }
>
> any reason why we have mixed use of writel_relaxes and writel?
> Shouldn't all the DMA register writes be done only using writel?

We has a lengthy discussion on the subject here:
http://marc.info/?l=linux-arm-kernel&m=130588591415130&w=2

Yours,
Linus Walleij
