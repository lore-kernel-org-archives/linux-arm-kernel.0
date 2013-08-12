From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Aug 2013 00:36:41 +0100
Subject: [PATCH 10/18] spi: s3c64xx: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <1376243970-6489-11-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-11-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130812233641.GL6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 07:59:22PM +0200, Tomasz Figa wrote:
> With support for amba-pl08x driver, on S3C64xx the generic DMA engine
> API can be used instead of the private s3c-dma interface.

I'm still getting issues for SPI with this:

[   50.952845] s3c64xx-spi s3c6410-spi.0: Failed to get RX DMA channel
[   50.953520] spi_master spi0: failed to prepare transfer hardware

when I test (with -next with this series applied on top), this is from
the first transfer that tries to DMA - there's actually no RX data.  No
errors are reported by the DMA controller itself.  I'm also getting
crashes setting up the audio DMA while derferencecing the channel.

This is without DT - are there any hookups missing because of that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/8a2b0c80/attachment.sig>
