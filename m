From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Sep 2013 17:36:54 +0100
Subject: [PATCH 28/51] DMA-API: sound: fix dma mask handling in a lot of
 drivers
In-Reply-To: <E1VMm9m-0007ij-ER@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm9m-0007ij-ER@rmk-PC.arm.linux.org.uk>
Message-ID: <20130920163654.GN21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 10:53:02PM +0100, Russell King wrote:
> This code sequence is unsafe in modules:
> 
> static u64 mask = DMA_BIT_MASK(something);
> ...
> 	if (!dev->dma_mask)
> 		dev->dma_mask = &mask;

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/4f16a3ab/attachment.sig>
