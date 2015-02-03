From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Feb 2015 22:44:53 +0100
Subject: [Linaro-mm-sig] [RFCv3 2/2] dma-buf: add helpers for sharing
 attacher constraints with dma-parms
In-Reply-To: <CAF6AEGuf6XBe3YOjhtbBcSyqJrkZ7sNMfc83hZdnKsE3P=vSuw@mail.gmail.com>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <20150203165829.GW8656@n2100.arm.linux.org.uk>
 <CAF6AEGuf6XBe3YOjhtbBcSyqJrkZ7sNMfc83hZdnKsE3P=vSuw@mail.gmail.com>
Message-ID: <19028710.jGRCggLuRk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 12:35:34 Rob Clark wrote:
> 
> I can't think of cases outside of GPU's..  if it were more common I'd
> be in favor of teaching dma api about multiple contexts, but right now
> I think that would just amount to forcing a lot of churn on everyone
> else for the benefit of GPU's.

We have a couple of users of the iommu API at the moment outside of
GPUs:

* drivers/media/platform/omap3isp/isp.c
* drivers/remoteproc/remoteproc_core.c
* drivers/infiniband/hw/usnic/usnic_uiom.c
* drivers/vfio/

I assume we will see a few more over time. The vfio case is the most
important one here, since that is what the iommu API was designed for.

	Arnd
