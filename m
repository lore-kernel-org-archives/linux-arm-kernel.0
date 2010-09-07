From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:37:00 +0100
Subject: [PATCH 1/2] s3c24xx: DMA: don't use autoreload feature
In-Reply-To: <1283901799-20461-1-git-send-email-anarsoul@gmail.com>
References: <1283872143-32492-1-git-send-email-anarsoul@gmail.com>
	<1283901799-20461-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4C86CC9C.9070506@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/10 00:23, Vasily Khoruzhick wrote:
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

I found this really necessary, especially on systems where some
drivers can keep the cpu irq load high, such as pio hard-discs.

Can this be changed to a flag that is set to control the behaviour
on a per driver basis?
