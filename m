From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 19:22:19 +0100
Subject: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring issue
In-Reply-To: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
Message-ID: <20150930182219.GU15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 10:43:17PM +0800, yitian wrote:
> Designware I2S uses tx empty and rx available signals as the DMA
> handshaking signals. during music playing, if XRUN occurs,
> i2s_stop() function will be executed and both tx and rx irq are
> masked, when music continues to be played, i2s_start() is executed
> but both tx and rx irq are not unmasked which cause I2S stop
> sending DMA handshaking signal to DMA controller, and it finally
> causes music playing will be stopped once XRUN occurs for the first
> time.

I'm a bit concerned about how this code ever worked given the above
description - is there some race condition which allows things to work
if we're lucky?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/d3b82426/attachment.sig>
