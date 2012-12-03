From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Mon, 3 Dec 2012 17:18:35 +0000
Subject: Replacing dma_alloc_writecombine for aarch64
Message-ID: <CAD0U-h+a6_1gtTS9pq-p7_BPmNnghUMMFZAHr8JdiK1kXrEHZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Some time ago, I converted the PL111 driver to use device tree [1].  I
gathered some feedback after an RFC and I was recently updating my
driver.  However, with my aarch64 work, I found that the driver
doesn't compile for aarch64 because I've been using
dma_alloc_writecombine in the driver.  As aarch64 doesn't use the
driver with DMA, I hacked it to get my aarch64 branch working.

Is there another API you can recommend I use for DMA that will work
with both flavours?

Regards,
Ryan.

[1] http://git.linaro.org/gitweb?p=landing-teams/working/arm/kernel.git;a=shortlog;h=refs/heads/tracking-armlt-clcd
