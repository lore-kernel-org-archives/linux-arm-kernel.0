From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 14 May 2014 10:15:38 +0100
Subject: [PATCH v6 05/11] drivers: of: add automated assignment of
 reserved regions to client devices
In-Reply-To: <20140302054043.4F48AC414EF@trevor.secretlab.ca>
References: <1393594976-16728-1-git-send-email-m.szyprowski@samsung.com>
 < 1393594976-16728-6-git-send-email-m.szyprowski@samsung.com>
 <20140302054043.4F48AC414EF@trevor.secretlab.ca>
Message-ID: <1400058938.3395.13.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-03-02 at 13:40 +0800, Grant Likely wrote:
> On Fri, 28 Feb 2014 14:42:50 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > This patch adds code for automated assignment of reserved memory regions
> > to struct device. reserved_mem->ops->device_init()/device_cleanup()
> > callbacks are called to perform reserved memory driver specific
> > initialization and cleanup
> > 
> > Based on previous code provided by Josh Cartwright <joshc@codeaurora.org>
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Hi Marek,
> 
> I've not applied this one yet, only because there is still the open
> issue of whether or not these functions should be called from drivers or
> from core code. I don't actually have any problems with the content of
> this patch. Once the user is sorted out I'll merge it.

Has anything more come of these patches? I see some of the series is now
in Linux 3.15, but the actual patches to let people use the feature
aren't there yet, namely patches 5 though 8.

My personal immediate interest in these is as a mechanism on arm64 to
limit CMA to a region of memory that is actually DMA-able devices (e.g.
below 4GB for 32-bit devices without an iommu).

For reference, the mail archives for this series is at
http://lkml.org/lkml/2014/2/28/237

-- 
Tixy
