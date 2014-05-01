From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 May 2014 12:11:25 -0700
Subject: [PATCH 13/15] ASoC: SND_S3C_DMA_LEGACY needs S3C24XX_DMA
In-Reply-To: <1398770316-19715-14-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-14-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501191125.GB3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:34PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> SND_S3C_DMA_LEGACY can only be set on S3C24xx, which does not
> (yet) support the dmaengine framework, so samsung_dma_get_ops()
> fails to link if S3C24XX_DMA is disabled:

Why is the fix for this not to ensure that s3c24xx always enables the
DMA controller - how likely is it that it would be sane to build a
kernel without DMA after all?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/940051e4/attachment.sig>
