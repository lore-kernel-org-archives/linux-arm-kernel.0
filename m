From: grundler@chromium.org (Grant Grundler)
Date: Tue, 6 Aug 2013 09:07:19 -0700
Subject: [PATCH v8 06/12] ARM: dts: Add description of System MMU of
 Exynos SoCs
In-Reply-To: <5200F781.9020300@samsung.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <27536111.odlCO093Zi@amdc1032>
 <003c01ce91cd$427fad70$c77f0850$@samsung.com>
 <1429191.3FDem6vW0S@amdc1032>
 <002001ce928a$f5a7f390$e0f7dab0$@samsung.com>
 <5200F781.9020300@samsung.com>
Message-ID: <CANEJEGtQuKG5err-R7SxD6m+aJWVmn47X9NJLx7UzaRkKhUMoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Aug 6, 2013 at 6:17 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
...
> IMHO it is much better to have a simple driver, which binds to a single
> IOMMU controller and leave it to the driver whether to have a same virtual address
> space for all parts of FIMC-IS or MFC submodules/memory ports or not.

I understand this part. I having written the IOMMU support for 4
different IOMMUs, all of which had exactly one IO Page Table and one
IOMMU shared by many devices.

> Just make sure that it will be possible to attach more than one sysmmu
> controller to one iommu domain.

I don't understand how this is possible. Can someone explain this
better in the IOMMU documentation please?

"iommu domain" to me means one virtual IO address space for attached
devices that can master DMA transactions. The IOMMU then uses it's IO
Page Table to translate the DMA address to the system physical address
space and forwards the transaction.

What is the role of the sysmmu in all of this?
Is the sysmmu just the MMU (or collection of MMU) for host DRAM?
Or is sysmmu responsible for "other stuff"? (clocks, power domains, MMU, etc)

I can understand we might have multiple MMUs in a system...e.g. every
range of memory might have it's own MMU. But they share the same
physical address space and generally live under one page table.
Because of "one page table" I would consider them one entity from the
the IOMMUs perspective.

thanks,
grant
