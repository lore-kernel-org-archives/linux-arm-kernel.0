From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 05 Mar 2012 14:46:07 +0530
Subject: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card
 detect
In-Reply-To: <20120302172251.GJ18901@atomide.com>
References: <20120301185044.29210.44521.stgit@kaulin.local>
 <20120301185535.29210.71546.stgit@kaulin.local> <4F50643B.9050500@ti.com>
 <20120302172251.GJ18901@atomide.com>
Message-ID: <4F548457.5050205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012 10:52 PM, Tony Lindgren wrote:
> BTW, with -rc5, looks like re-inserting omap_hsmmc on omap4 fails
> to detect any cards, and then fails to unload. This works on omap3
> just fine. Any ideas why that would be?

Yeah, looks like thats broken. I am not sure whats going wrong though.
I just enabled CONFIG_MMC_DEBUG and saw these logs below.

Venkat/Balaji, care to look at this one?

# insmod omap_hsmmc.ko
[   43.358398] omap_hsmmc omap_hsmmc.0: context was not lost
[   43.364105] omap_hsmmc omap_hsmmc.0: enabled
[   44.434661] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 
timing 0
[   44.442352] omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
[   44.474365] omap_hsmmc omap_hsmmc.0: disabled
[   44.482208] omap_hsmmc omap_hsmmc.4: context was not lost
[   44.482208] omap_hsmmc omap_hsmmc.4: enabled
[   44.546600] omap_hsmmc omap_hsmmc.0: context was not lost
[   44.552276] omap_hsmmc omap_hsmmc.0: enabled
[   44.552276] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[   44.563720] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 18 width 0 
timing 0
[   44.572174] omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
[   44.613800] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 18 
width 0 timing 0
[   44.621887] omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
[   44.735290] mmc0: starting CMD52 arg 00000c00 flags 00000195
[   44.741271] omap_hsmmc omap_hsmmc.0: mmc0: CMD52, argument 0x00000c00
[   45.560241] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 
timing 0
[   45.567871] omap_hsmmc omap_hsmmc.4: Set clock to 0Hz
[   45.591491] omap_hsmmc omap_hsmmc.4: disabled
#
#
# rmmod omap_hsmmc
[  607.302307] omap_hsmmc omap_hsmmc.4: context was not lost
[  607.308044] omap_hsmmc omap_hsmmc.4: enabled
[  607.312591] omap_hsmmc omap_hsmmc.4: disabled
[  607.317199] omap_hsmmc omap_hsmmc.4: context was not lost
[  607.322875] omap_hsmmc omap_hsmmc.4: enabled
