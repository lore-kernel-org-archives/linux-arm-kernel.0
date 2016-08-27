From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 27 Aug 2016 21:15:22 +0200 (CEST)
Subject: [PATCH RFC 0/3] mmc: mxs-mmc: Implement DDR support
In-Reply-To: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1082892691.24336.3dd5cc50-579f-4f46-b1de-7868392729ec.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 6. August 2016 um 14:55
> geschrieben:
> 
> 
> Based on these discussions: [1], [2] this patch series implements
> DDR support for the MXS MMC host driver. This feature has never been
> ported from the vendor kernel.
> 
> It has been tested on a i.MX28 board with eMMC which is currently
> not in mainline (Duckbill 2).
> 
> * without DDR support
> dd if=/dev/zero of=test bs=8k count=10000
> 81920000 bytes (82 MB) copied, 14.3321 s, 5.7 MB/s
> 
> * with DDR support:
> dd if=/dev/zero of=test bs=8k count=10000
> 81920000 bytes (82 MB) copied, 13.4781 s, 6.1 MB/s
> 
> [1] - http://www.spinics.net/lists/linux-mmc/msg32285.html
> [2] - http://www.spinics.net/lists/linux-mmc/msg34418.html

do you want to add some comments about this series?

Regards
Stefan

> 
> Stefan Wahren (3):
>   DT: bindings: mmc: Add property for 3.3V only support
>   mmc: core: add new cap for 3.3V only DDR MMCs
>   mmc: mxs-mmc: Implement DDR support
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++--
>  drivers/mmc/core/host.c                       |    2 ++
>  drivers/mmc/core/mmc.c                        |    6 ++++++
>  drivers/mmc/host/mxs-mmc.c                    |   22 ++++++++++++++++++++++
>  include/linux/mmc/host.h                      |    1 +
>  5 files changed, 36 insertions(+), 2 deletions(-)
> 
> -- 
> 1.7.9.5
