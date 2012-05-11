From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 May 2012 14:24:10 +0200
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <1336705214.15424.1369.camel@vkoul-udesk3>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <20120504122611.GE26481@n2100.arm.linux.org.uk>
 <1336135550.1540.2.camel@vkoul-udesk3>
 <20120510225429.GG12727@n2100.arm.linux.org.uk>
 <1336705214.15424.1369.camel@vkoul-udesk3>
Message-ID: <CACRpkdZpC4pwSCLrZuVg9C=5u5pVQpm8c7HVmshs09wtEOcnqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 5:00 AM, Vinod Koul <vinod.koul@linux.intel.com> wrote:

> Yes this needs to be mandatory. Let me add that explicitly.
>
> ?* @last: last completed DMA cookie
> ?* @used: last issued DMA cookie (i.e. the one in progress)
> - * @residue: the remaining number of bytes left to transmit
> - * ? ? on the selected transfer for states DMA_IN_PROGRESS and
> - * ? ? DMA_PAUSED if this is implemented in the driver, else 0
> + * @residue: is defined as:
> + * ? - for completed descriptor: 0
> + * ? - for descriptors which are in DMA_PAUSED, DMA_IN_PROGRESS:
> + * ? ? length - (current_addr - start_addr), where:
> + * ? ? ? ? ? ? length = descriptor dma length
> + * ? ? ? ? ? ? current_addr = current dma pointer queried for dma channel
> + * ? ? ? ? ? ? start_addr: starting address of this descriptor
> + * ? This is mandatory and needs to be correctly filled by driver
> ?*/
> Does this make it clear?

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
