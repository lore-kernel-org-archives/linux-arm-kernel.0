From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 16:19:24 +0300
Subject: [RFC 0/6] adding SDIO Runtime PM support
Message-ID: <1281532770-27545-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDIO function drivers should be able to power down/up
their cards (e.g. a WLAN SDIO driver might want to
power down its card whenever wlan0 is down).

In the past few weeks we've been discussing how this
could be achieved, and I'd like to present a new approach,
which is based on runtime pm API.

The following few patches add runtime pm support for SDIO
devices, and demonstrate it with the wl1271_sdio driver.
Basic functionality is provided: The power state of the
device is now coupled with the state of the wlan0 interface.

The nice thing about this approach is how small it is,
as the runtime PM core is already taking care of everything
needed (usage counts, device hierarchy, established set of API,
synchronization, ...).

Having said that, I'd like to stress that these patches
are early submitted for RFC purposes only, as they
are still in a preliminary state and only lightly tested.

Please note that I will soon be leaving for the rest of August and
am going to have a very limited email access, so it might
take me some time to respond.

Appreciate your feedback,

Thank you,

Ohad Ben-Cohen (6):
  mmc: sdio: fully reconfigure oldcard on resume
  sdio: add power_restore support
  mmc: add general runtime PM support
  sdio: add general runtime PM support
  sdio: enable Runtime PM for SDIO cards
  wireless: wl1271_sdio: enable Runtime PM

 drivers/mmc/core/bus.c                    |   35 +++++++++++++++++++++++++++
 drivers/mmc/core/sdio.c                   |   24 +++++++++++++++---
 drivers/mmc/core/sdio_bus.c               |   10 ++++++++
 drivers/net/wireless/wl12xx/wl1271_sdio.c |   37 ++++++++++++++++++++++++++++-
 4 files changed, 101 insertions(+), 5 deletions(-)
