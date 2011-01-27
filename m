From: agust@denx.de (Anatolij Gustschin)
Date: Thu, 27 Jan 2011 09:22:55 +0100
Subject: [PATCH 2/2] dma: ipu_idmac: do not lose valid received data in
	the irq handler
In-Reply-To: <1296031789-1721-3-git-send-email-agust@denx.de>
References: <1296031789-1721-1-git-send-email-agust@denx.de>
	<1296031789-1721-3-git-send-email-agust@denx.de>
Message-ID: <20110127092255.2cb6f0a3@wker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reading the commit message again I now realize that there is
a mistake. 

On Wed, 26 Jan 2011 09:49:49 +0100
Anatolij Gustschin <agust@denx.de> wrote:
...
> received data. DMA_BUFx_RDY won't be set by the IPU, so waiting
> for this event in the interrupt handler is wrong.

This should read 'DMAIC_x_CUR_BUF flag won't be flipped here by
the IPU, so waiting for this event in the EOF interrupt handler
is wrong.'

I'll submit another patch fixing the commit message.

Anatolij
