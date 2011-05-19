From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 19 May 2011 14:08:24 +0200
Subject: [PATCH 0/6 V2] ARM: tegra: paz00 patches for 2.6.40
Message-ID: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Collin, Olof,

the following patches are intended for 2.6.40 merge. They are mostly similar
to the TrimSlice patches sent by Mike a few days ago.

We are still stuggling with the sound codec (alc5632) and the nvec, so there
is nothing to connect to the i2c yet. On the other hand, I'm wondering what's
up with the atd7461 included in most (all?) boards. It's compatible with lm90,
but the driver will never register because of the wrong name.

May I ask if there is some timeline for framebuffer integration? A netbook
without display is of not much use (ok, same holds for keyboard/mouse).

Thanks!

Marc

Changes in V2:
    - add some more blurb to the commit messages
    - change the machine to some neater name (patch 5)
    - enable the wifi board during boot (patch 6)


Marc Dietrich (6):
  ARM: tegra: paz00: whitespace cleanup
  ARM: tegra: paz00: register i2c busses
  ARM: tegra: paz00: enable usb ports
  ARM: tegra: paz00: cleanup sdhci ports
  ARM: tegra: paz00: change the machine name
  ARM: tegra: paz00: enable wifi card

 arch/arm/mach-tegra/board-paz00-pinmux.c |   12 ++--
 arch/arm/mach-tegra/board-paz00.c        |   96 ++++++++++++++++++++++++++----
 arch/arm/mach-tegra/board-paz00.h        |   17 ++++--
 3 files changed, 102 insertions(+), 23 deletions(-)

-- 
1.7.4.2
