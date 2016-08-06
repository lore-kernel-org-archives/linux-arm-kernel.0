From: marex@denx.de (Marek Vasut)
Date: Sat, 6 Aug 2016 15:10:16 +0200
Subject: [PATCH RFC 0/3] mmc: mxs-mmc: Implement DDR support
In-Reply-To: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <ef08cd86-8366-31b3-1f05-d0c7251cded6@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2016 02:55 PM, Stefan Wahren wrote:
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

Not much of a speedup, how so ?

> [1] - http://www.spinics.net/lists/linux-mmc/msg32285.html
> [2] - http://www.spinics.net/lists/linux-mmc/msg34418.html
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


-- 
Best regards,
Marek Vasut
