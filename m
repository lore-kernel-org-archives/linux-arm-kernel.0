From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Jul 2010 18:29:19 +0200
Subject: [PATCH V2 0/6]
Message-ID: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series of patches prepares the i.mx tree for the flexcan driver.
Clock support is added or adjusted. Missing defines for the base addresses
and interrupts are added.

The 5th patch uses the newly introduced dynamic registration scheme to
provide the flexcan devices. This patch contains two ifdefs to replace the
"imx_add_flexcan()" function by a noop if the flexcan driver is not
activated. This is needed to compile this series before the actual flexcan
driver and it's header file have been merged. The ifdefs can be removed
after merging.

The last patch registers flexcan to the pcm043.

please consider to apply.

cheers, Marc


P.S.: this can be pulled:

The following changes since commit ed300d7a8d115ef721b1f69ddf733e4c4dba4eac:

  iomux-mx51: add 4 pin definitions (2010-07-22 15:19:45 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/mkl/linux-2.6.git for-imx-for-2.6.36

Marc Kleine-Budde (5):
      mx25: add flexcan address and interrupt definition
      mx35: adjust flexcan clock definition
      mx35: add flexcan address
      imx: dynamically register flexcan devices for mx25 and mx35
      pcm043: register flexcan device

Sascha Hauer (1):
      mx25: flexcan clock support
