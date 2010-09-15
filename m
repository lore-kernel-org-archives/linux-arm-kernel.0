From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 15 Sep 2010 11:21:19 +0200
Subject: [PATCH v5 0/7] native wl1271 support on ZOOM
In-Reply-To: <1283376410-9999-1-git-send-email-ohad@wizery.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
Message-ID: <AANLkTikedoL3HjohQfq2qa0TU5yMJR5p1GqyQJtQGrdb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 1, 2010 at 11:26 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> This patchset adds wl1271 support on ZOOM2/3 boards.

Tony, John, let me please suggest merging this through the wireless tree.

wl1271 is a moving target - it keeps changing in the wireless tree and
merging this patchset there will allow wl1271 developers to have
everything in a single tree (and prevent merge conflicts in
linux-next).

If that's ok with you, I will rebase this on top of wireless-testing
and resubmit.

>
> Only basic support is included; MMC power manipulation part is submitted separately as Runtime PM migration.
>
> Changes since v4:
> - Introduce a simple (yet safe) mechanism to pass platform-specific data to the driver, as suggested by Russell King. Currently only a single device is supported; multi-device support will be introduced only when/if required
>
> Patches are based on 2.6.36-rc3 and tested on ZOOM3.
>
> Thanks,
>
> Ohad Ben-Cohen (7):
> ?wireless: wl1271: make wl12xx.h common to both spi and sdio
> ?wireless: wl1271: support return value for the set power func
> ?wireless: wl12xx: add platform data passing support
> ?wireless: wl1271: take irq info from private board data
> ?wireless: wl1271: make ref_clock configurable by board
> ?omap: zoom: add fixed regulator device for wlan
> ?omap: zoom: add mmc3/wl1271 device support
>
> ?arch/arm/mach-omap2/board-zoom-peripherals.c ? ? ? | ? 54 ++++++++++++++++++++
> ?drivers/net/wireless/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> ?drivers/net/wireless/wl12xx/Kconfig ? ? ? ? ? ? ? ?| ? ?5 ++-
> ?drivers/net/wireless/wl12xx/wl1251_sdio.c ? ? ? ? ?| ? ?2 +-
> ?drivers/net/wireless/wl12xx/wl1251_spi.c ? ? ? ? ? | ? ?2 +-
> ?drivers/net/wireless/wl12xx/wl1271.h ? ? ? ? ? ? ? | ? ?3 +-
> ?drivers/net/wireless/wl12xx/wl1271_boot.c ? ? ? ? ?| ? ?9 ++--
> ?drivers/net/wireless/wl12xx/wl1271_boot.h ? ? ? ? ?| ? ?1 -
> ?drivers/net/wireless/wl12xx/wl1271_io.h ? ? ? ? ? ?| ? ?9 ++-
> ?drivers/net/wireless/wl12xx/wl1271_main.c ? ? ? ? ?| ? ?4 +-
> ?drivers/net/wireless/wl12xx/wl1271_sdio.c ? ? ? ? ?| ? 19 ++++---
> ?drivers/net/wireless/wl12xx/wl1271_spi.c ? ? ? ? ? | ? ?8 ++-
> ?drivers/net/wireless/wl12xx/wl12xx_platform_data.c | ? 31 +++++++++++
> ?include/linux/spi/wl12xx.h ? ? ? ? ? ? ? ? ? ? ? ? | ? 34 ------------
> ?include/linux/wl12xx.h ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 38 ++++++++++++++
> ?15 files changed, 164 insertions(+), 57 deletions(-)
> ?create mode 100644 drivers/net/wireless/wl12xx/wl12xx_platform_data.c
> ?delete mode 100644 include/linux/spi/wl12xx.h
> ?create mode 100644 include/linux/wl12xx.h
>
>
