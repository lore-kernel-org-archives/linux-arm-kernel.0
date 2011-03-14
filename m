From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Mar 2011 14:32:19 +0100
Subject: [PATCH 3/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <AANLkTimagS1vBXEYjXQDx=OGhTRm=n0yO4n+kHTAqBOz@mail.gmail.com>
References: <1299229274-9753-4-git-send-email-m.szyprowski@samsung.com>
	<201103111700.17373.arnd@arndb.de>
	<AANLkTimagS1vBXEYjXQDx=OGhTRm=n0yO4n+kHTAqBOz@mail.gmail.com>
Message-ID: <201103141432.19614.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 March 2011, KyongHo Cho wrote:
> I think we can consider another solution for the various requirements.
> I think one of the most possible solutions is VCMM.
> Or we can enhance include/linux/iommu.h with reference of VCMM.

I think extending or changing the existing interface would be much
preferred. It's always better to limit the number of interfaces
that do the same thing, and we already have more duplication than
we want with the two dma-mapping.h and iommu.h interfaces.

Note that any aspect of the existing interface can be changed if
necessary, as long as there is a way to migrate all the existing
users. Since the iommu API is not exported to user space, there
is no requirement to keep it stable.

	Arnd
