From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 03 Jun 2011 11:01:35 +0530
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
	<BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
Message-ID: <4DE871B7.1080007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/3/2011 5:18 AM, Kyungmin Park wrote:
> Hi,
>
> Interesting, I also use the latest kernel and boot well.
> As I don't have the s3c2416 user manaul, I'm not sure it's support
> AUTO CMD12 or not. but at least it's support at s3c6410 and later.
>
> [    1.355000] sdhci: Secure Digital Host Controller Interface driver
> [    1.360000] sdhci: Copyright(c) Pierre Ossman
> [    1.365000] s3c-sdhci s3c-sdhci.0: clock source 2: sclk_mmc (50000000 Hz)
> [    1.375000] mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] using ADMA
> [    1.380000] s3c-sdhci s3c-sdhci.2: clock source 2: sclk_mmc (50000000 Hz)
> [    1.385000] mmc1: no vmmc regulator found
> [    1.390000] mmc1: SDHCI controller on samsung-hsmmc [s3c-sdhci.2] using ADMA
> [    1.400000] s3c-sdhci s3c-sdhci.3: clock source 2: sclk_mmc (50000000 Hz)
> [    1.405000] mmc2: no vmmc regulator found
> [    1.410000] mmc2: SDHCI controller on samsung-hsmmc [s3c-sdhci.3] using ADMA
> ...
> [    1.435000] Waiting for root device /dev/mmcblk0p3...
> [    1.650000] mmc0: new high speed MMC card at address 0001
> [    1.655000] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> [    1.660000] mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
> [    1.665000] mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
> [    1.675000]  mmcblk0: p1 p2 p3 p4<  p5 p6>
> [    1.680000]  mmcblk0boot1: unknown partition table
> [    1.685000]  mmcblk0boot0: unknown partition table
>
> I also check the external SD card.
>
There seems to some regression in MMC statck. I too observed
lot of interrupts from MMC and I2C with V3.0-rc1 on OMAP.

Regards
Santosh
