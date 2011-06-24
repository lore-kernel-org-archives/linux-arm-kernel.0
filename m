From: joro@8bytes.org ('Joerg Roedel')
Date: Fri, 24 Jun 2011 10:39:09 +0200
Subject: [Linaro-mm-sig] [PATCH 3/8] ARM: dma-mapping: use
	asm-generic/dma-mapping-common.h
In-Reply-To: <002501cc3008$f000d600$d0028200$%szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
	<BANLkTimHE2jzQAav465WaG3iWVeHPyNRNQ@mail.gmail.com>
	<002501cc3008$f000d600$d0028200$%szyprowski@samsung.com>
Message-ID: <20110624083909.GB29299@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 01:47:03PM +0200, Marek Szyprowski wrote:
> > I also think that it is better to attach and to detach dma_map_ops
> > dynamically.
> 
> What's the point of such operations? Why do you want to change dma
> mapping methods in runtime?

That is dangerous. You have to make sure that there are no mappings
granted to the the device driver before changing the dma_ops of a device
at runtime. Otherwise existing mappings for a device may disappear and
confuse the driver and the device.

Joerg
