From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 27 Aug 2010 23:03:01 +0300
Subject: [PATCH 1/2] s3c24xx: DMA: don't use autoreload feature
In-Reply-To: <1282143866-8068-2-git-send-email-anarsoul@gmail.com>
References: <1282143866-8068-1-git-send-email-anarsoul@gmail.com>
	<1282143866-8068-2-git-send-email-anarsoul@gmail.com>
Message-ID: <201008272303.10803.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 18 ??????? 2010 18:04:25 ????? Vasily Khoruzhick ???????:
> Some integrated DMA-capable hardware doesn't like autoreload
> feature of s3c24xx DMA-engine, that's why s3cmci driver
> didn't work with DMA transfers enabled.
> 
> I rewrote DMA driver not to use autoreload feature and removed
> all pre-loading features. Buffer re-load is fast enought to perform
> it in IRQ handler, and anyway I don't see any reason to waste CPU
> cycles on waiting for buffer load. Driver is much simplier now,
> it was tested with s3cmci and s3c24xx-i2s drivers on s3c2442 and
> s3c2410 SoCs and works just nice.
 
Patch has problem with suspend/resume (chan->dcon is clobbered by
dma_sel->select())

Will resend fixed version soon.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100827/ac1c701a/attachment.sig>
