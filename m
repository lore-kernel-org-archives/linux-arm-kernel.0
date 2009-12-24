From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Dec 2009 12:23:17 +0100
Subject: please pull FTBFS fixes (Was: [PATCH v3] imx/mx3: depend on
	USB_ULPI for otg_ulpi_create)
In-Reply-To: <1261499465-21504-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1261410116-10382-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1261499465-21504-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091224112317.GA569@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the two patches sent in this thread together with the fix for

	arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
	arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'

that is already in your tree make the mx3 related defconfigs build
again.

Sascha is currently on vacation and won't be back until next year.

So you can pull from my tree:

The following changes since commit 55639353a0035052d9ea6cfe4dde0ac7fcbb2c9f:
  Linus Torvalds (1):
        Linux 2.6.33-rc1

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx-for-rmk

Uwe Kleine-K?nig (1):
      imx/mx3: depend on USB_ULPI for otg_ulpi_create

Valentin Longchamp (1):
      imx/mx31moboard: fix usbh device names

 arch/arm/mach-mx3/Kconfig                |    3 ++-
 arch/arm/mach-mx3/mx31lite.c             |    4 ++++
 arch/arm/mach-mx3/mx31moboard-devboard.c |    2 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c  |    2 +-
 arch/arm/mach-mx3/mx31moboard.c          |    7 ++++++-
 5 files changed, 14 insertions(+), 4 deletions(-)

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
