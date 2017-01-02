From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon,  2 Jan 2017 14:06:56 -0300
Subject: [PATCH 0/3] crypto: picoxcell - Cleanups removing non-DT code
Message-ID: <1483376819-26726-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small series contains a couple of cleanups that removes some driver's code
that isn't needed due the driver being for a DT-only platform.

The changes were suggested by Arnd Bergmann as a response to a previous patch:
https://lkml.org/lkml/2017/1/2/342

Patch #1 allows the driver to be built when the COMPILE_TEST option is enabled.
Patch #2 removes the platform ID table since isn't needed for DT-only drivers.
Patch #3 removes a wrapper function that's also not needed if driver is DT-only.

Best regards,


Javier Martinez Canillas (3):
  crypto: picoxcell - Allow driver to build COMPILE_TEST is enabled
  crypto: picoxcell - Remove platform device ID table
  crypto: picoxcell - Remove spacc_is_compatible() wrapper function

 drivers/crypto/Kconfig            |  2 +-
 drivers/crypto/picoxcell_crypto.c | 28 +++-------------------------
 2 files changed, 4 insertions(+), 26 deletions(-)

-- 
2.7.4
