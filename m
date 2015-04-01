From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Apr 2015 21:33:42 +0100
Subject: [PATCH] ASoC: atmel-pcm-dma: increase buffer_bytes_max
In-Reply-To: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150401203342.GH6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 09:40:37PM +0200, Alexandre Belloni wrote:
> atmel-pcm-dma is not limited to a buffer size of 64kB like atmel-pcm-pdc.
> Increase buffer_bytes_max to 512kB to allow for higher bit rates (i.e. 32bps at
> 192kHz) to work correctly. By default, keep the prealloc at 64kB.

Applied, but please look into Lars' suggestion - we should be able to
just figure everything out from the DMA controller.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/d3163527/attachment.sig>
