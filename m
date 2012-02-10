From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Fri, 10 Feb 2012 18:57:56 +0530
Subject: [PATCH 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
In-Reply-To: <CANfBPZ-pD55YgneQSyfs1kKB-DUH8g7TQkKO7O6B95Ydfc8cFg@mail.gmail.com>
References: <1328367090-10402-1-git-send-email-rnayak@ti.com>
 <CANfBPZ-pD55YgneQSyfs1kKB-DUH8g7TQkKO7O6B95Ydfc8cFg@mail.gmail.com>
Message-ID: <CANrkHUbXHrQ=LowgNq9nt+rnrcE-fTqLuOs2+MeCtodv_H-_Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2012 at 3:32 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> On Sat, Feb 4, 2012 at 8:21 PM, Rajendra Nayak <rnayak@ti.com> wrote:
>> This series mainly cleans up all instances of hardcoding's in
>> the driver based on pdev->id. This is cleanup leading to the
>> DT adaptation of omap_hsmmc driver.
>>
>> Patches are based on 3.3-rc2 and can be found here
>> git://gitorious.org/omap-pm/linux.git omap_hsmmc_cleanup
>>
>> Tested the patches on my omap4 boards (panda and SDP) but
>> haven't tested yet on omap3/2 since I did'nt have boards
>> handy. So any testing on any omap3/2 boards is really
>> appreciated.

Tested this series on 2430SDP with FS on SD card

>
> I gave it a spin on Beagleboard-XM (OMAP3630) with root filesystem
> on the SD card, and checked again on 4430SDP.
>
> Tested-by: Venkatraman S <svenkatr@ti.com>
>
>>
>> regards,
>> Rajendra
>>
>> Balaji T K (3):
>> ?mmc: omap_hsmmc: use platform_get_resource_byname for tx/rx DMA
>> ? ?channels
>> ?mmc: omap_hsmmc: remove unused .set_sleep function
>> ?mmc: omap_hsmmc: Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT flag to remove
>> ? ?host->id based hardcoding
>>
>> Rajendra Nayak (3):
>> ?mmc: omap_hsmmc: Get rid of omap_hsmmc_1_set_power function
>> ?mmc: omap_hsmmc: Get rid of omap_hsmmc_4_set_power function
>> ?mmc: omap_hsmmc: Don't expect MMC1 to always have vmmc supply
>>
>> ?arch/arm/plat-omap/include/plat/mmc.h | ? ?2 -
>> ?drivers/mmc/host/omap_hsmmc.c ? ? ? ? | ?158 +++------------------------------
>> ?2 files changed, 14 insertions(+), 146 deletions(-)
>>
