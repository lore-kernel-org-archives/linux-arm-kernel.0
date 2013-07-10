From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 10 Jul 2013 11:48:19 +0200
Subject: [PATCH] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <20130710093055.GW24642@n2100.arm.linux.org.uk>
References: <1373446263-7772-1-git-send-email-jonas.jensen@gmail.com>
 <20130710093055.GW24642@n2100.arm.linux.org.uk>
Message-ID: <CACmBeS1SQ=nuYqrMiQmSr6ANfZD9cGyeHQ1+zZyfPeTjoFtgQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2013 11:30, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> Do you actually make any use what so ever of the vchan support?

Only because it was inspired by the edma driver:

static inline struct moxart_dma_chan *to_moxart_dma_chan(struct dma_chan *c)
{
        return container_of(c, struct moxart_dma_chan, vchan.chan);
}

It could use struct dma_chan instead I think.


Best regards,
Jonas
