From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2011 15:52:15 +0100
Subject: [PATCH 3/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <1299254660-15765-1-git-send-email-m.szyprowski@samsung.com>
References: <1299229274-9753-4-git-send-email-m.szyprowski@samsung.com>
	<1299254660-15765-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201103101552.15536.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 March 2011, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> 
> This patch performs a complete rewrite of sysmmu driver for Samsung platform:
> - the new version introduces an api to construct device private page
>   tables and enables to use device private address space mode
> - simplified the resource management: no more single platform
>   device with 32 resources is needed, better fits into linux driver model,
>   each sysmmu instance has it's own resource definition
> - added support for sysmmu clocks
> - some other minor API chages required by upcoming videobuf2 allocator
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Please explain why create a new IOMMU API when we already have two
generic ones (include/linux/iommu.h and include/linux/dma-mapping.h).

Is there something that cannot be done with the common code?
The first approach should be to extend the existing APIs to
do what you need.

	Arnd
