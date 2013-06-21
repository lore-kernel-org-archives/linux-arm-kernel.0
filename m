From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 21 Jun 2013 18:03:44 +0200
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
In-Reply-To: <51C3FE27.5070702@samsung.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
 <51C3FE27.5070702@samsung.com>
Message-ID: <20130621160344.GM11309@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 09:17:59AM +0200, Marek Szyprowski wrote:
> Using DMA attributes for this seems to be a bad idea. The dma direction
> parameter is much more appropriate. Will Deacon recently posted a patch
> which does it right, see:
> 
> https://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commit;h=8fc3749bd31d139db58f874e093255fe62505968

Agreed, that is one usecase the dma-direction parameter was made for. In
particular:

	DMA_FROM_DEVICE		-> Write only mapping
	DMA_TO_DEVICE 		-> Read only mapping
	DMA_BIDIRECTIONAL	-> Read/Write mapping

So no need to use the dma attributes for that.


	Joerg
