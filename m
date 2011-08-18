From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 18 Aug 2011 16:53:13 +0300
Subject: [PATCH 2/7] omap: iommu/iovmm: move to dedicated iommu folder
In-Reply-To: <201108181538.18480.arnd@arndb.de>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-3-git-send-email-ohad@wizery.com>
	<201108181538.18480.arnd@arndb.de>
Message-ID: <CAK=WgbY1qVSZVjk6y=xb152cV0QjeGaQbKc+zMTat8RW5vF5zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 4:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 August 2011, Ohad Ben-Cohen wrote:
>> ?arch/arm/plat-omap/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? | ? 14 --------------
>> ?arch/arm/plat-omap/Makefile ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 --
>> ?arch/arm/plat-omap/{ => include/plat}/iopgtable.h ?| ? ?0
>> ?drivers/iommu/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 18 ++++++++++++++++++
>> ?drivers/iommu/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?3 +++
>> ?.../iommu/omap-iommu-debug.c ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?.../iommu.c => drivers/iommu/omap-iommu.c ? ? ? ? ?| ? ?2 +-
>> ?.../iovmm.c => drivers/iommu/omap-iovmm.c ? ? ? ? ?| ? ?2 +-
>> ?drivers/media/video/Kconfig ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
>
> Do you need the header file to be globally visible?

Yeah; Unfortunately omap3isp is not yet completely decoupled from
omap's iommu, so it needs it.

Once the generic DMA-API will settle in, we will completely decouple
omap3isp and then will be able to move this header file into
drivers/iommu/, and remove omap-iovmm.c.

Thanks,
Ohad.
