From: marex@denx.de (Marek Vasut)
Date: Thu, 4 Jun 2015 00:53:29 +0200
Subject: [PATCH 00/11] Enable access to SPI NOR flash on Samsung Snow board
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <201506040053.29482.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 03, 2015 at 11:26:39 PM, Michal Suchanek wrote:
> Hello,

Hi,

> this patch series makes it possible to access the SPI NOR flash in the
> Samsung XE303 'Snow' Chromebook.
> 
> Unfortunately not all issues are resolved. To work around an issue with the
> pl330 dma engine I respun the patch for limiting transfer size in m25p80
> driver.

Looks like fixing a bug at the wrong place to me ...

> As the flash does not contain any sane filesystem and is only likely to be
> accessed with mtd_debug or similar tool the limit of the dma engine is
> easily reached. Filesystems using shorter data transfers are less likely
> to be affected.

Sounds like the DMA engine driver should be fixed.

Best regards,
Marek Vasut
