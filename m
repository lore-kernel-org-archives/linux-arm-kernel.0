From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 30 Jun 2011 11:25:34 +0200
Subject: [PATCH 0/7] ARM: SAMSUNG: Cleanup SPI platform specific code
In-Reply-To: <1309436723-662-1-git-send-email-padma.v@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
Message-ID: <005701cc3707$aa914e50$ffb3eaf0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, June 30, 2011 2:25 PM Padmavathi Venna wrote:

> This patchset does the following:
> 
> 1. Move duplicated code to common place
> [PATCH 1/7] ARM: SAMSUNG: Move SPI device definitions to plat-samsung
> SPI platform devices are defined in respective machine folder of
> Samsung S3C64XX and S5P series SoCs.This is duplicated for every SoC.
> So all SPI platform devices are moved to a common place.
> 
> [PATCH 2/7] ARM: SAMSUNG: Define common macro for SPI physical address
> 
> [PATCH 3/7] ARM: SAMSUNG: Add SPI clock definitions for SAMSUNG SoCs
> Each SoC has it's own set of clock sources for SPI.So they are defined in
> respective machine folder.
> 
> [PATCH 4/7] ARM: SAMSUNG: Create SPI device setup files in
> respective machine folder
> 
> [PATCH 5/7] ARM: SAMSUNG: Add SPI platform specific code
> As SPI platform devices are moved to common place some platform specific
> code need to be initialized in the respective machine file.
> 
> [PATCH 6/7] SPI: S5PC100: Enable the SPI driver for S5PC100
> 
> [PATCH 7/7] SPI: S5PV210: Enable the SPI driver for S5PV210

These patch set improves a bit platform part of SPI driver, but I really
wonder if we really need to pass so many SoC version specific data 
with platform data. Are all these data (clock list, fifo parameters)
specific to SoC version or particular board configuration/implementation?

Maybe it will be much easier to convert the SPI driver to use driver id 
feature and use different platform id's for each SoC version? (please 
refer to drivers/video/s3c-fb.c and plat-samsung/include/plat/fb-core.h
for more information). This will remove the need for SoC specific
parameters in platform data and will group all version dependent 
information in the driver.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
