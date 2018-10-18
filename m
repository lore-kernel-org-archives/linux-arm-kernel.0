From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Oct 2018 13:14:05 +0200
Subject: DMA configuration in non-DT probed driver
Message-ID: <18dfef35-54f6-0e45-ff8e-f0c3e70b8580@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

i'm currently working on the VCHIQ driver ( drivers
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers?h=next-20181018>/staging
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging?h=next-20181018>/vc04_services
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/vc04_services?h=next-20181018>/interface
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/vc04_services/interface?h=next-20181018>/vchiq_arm
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/vc04_services/interface/vchiq_arm?h=next-20181018>
) in staging which is only used by the Raspberry Pi. The driver should
register at least 2 child devices (bcm2835-audio and bcm2835-camera)
instead of model these via DT binding. The reason is the VCHIQ driver is
a communication interface to the Video Core 4 GPU firmware, so a DT
binding wont be appropriate.

Since the DT probing usually handle the DMA configuration, i need some
kind of equivalent for non-DT probing. Looking at the kernel, i found in
drivers/gpu/drm/xen/xen_drm_front.c in combination of
of_dma_configure(dev, NULL, true) and manual setting of the coherent dma
mask.

So here are my questions:
Is this an acceptable way to setup dma ops and masks or is there a
better solution?
Which driver should do the dma configuration the parent (VCHIQ) or the
child device (bcm2835-audio, ...)?

Thanks
Stefan
