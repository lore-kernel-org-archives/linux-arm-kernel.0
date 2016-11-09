From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 09 Nov 2016 19:55:21 +0100
Subject: [PATCH 00/13] mmc: dw_mmc: cleans the codes for dwmmc controller
In-Reply-To: <20161103062135.10697-1-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Message-ID: <1862686.MpoeR9Brjy@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. November 2016, 15:21:22 CET schrieb Jaehoon Chung:
> This patchset is modified the some minor fixing and cleaning code.
> If needs to split the patches, i will re-send the patches.
> 
> * Major changes
> - Use the cookie enum values like sdhci controller.
> - Remove the unnecessary codes and use stop_abort() by default.
> - Remove the obsoleted property "supports-highspeed"
> - Remove the "clock-freq-min-max" property. Instead, use "max-frequency"
> - Minimum clock value is set to 100K by default.
> 
> Jaehoon Chung (13):
>   mmc: dw_mmc: display the real register value on debugfs
>   mmc: dw_mmc: fix the debug message for checking card's present
>   mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
>   mmc: dw_mmc: use the hold register when send stop command
>   mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
>   mmc: core: move the cookie's enum values from sdhci.h to mmc.h
>   mmc: dw_mmc: use the cookie's enum values for post/pre_req()
>   mmc: dw_mmc: remove the unnecessary mmc_data structure

patches 1-8 on rk3036, rk3288, rk3368 and rk3399 Rockchip platforms
Tested-by: Heiko Stuebner <heiko@sntech.de>
