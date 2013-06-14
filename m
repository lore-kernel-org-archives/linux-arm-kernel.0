From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sat, 15 Jun 2013 00:47:47 +0200
Subject: [GIT PULL] at91: Device Tree update for 3.11 #2
In-Reply-To: <1370279139-7181-1-git-send-email-nicolas.ferre@atmel.com>
References: <1370279139-7181-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1371250067-19317-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Additional pull-request for AT91 DT patches.
It contains the remaining part of the USB gadget pull-request that I sent you
last week. After having split it, here is the DT part.
It also contains the update of DMA bindings: it is the AT91 part the should go
through arm-soc. I have included the patch (ARM: at91: dt: add header to define
at_hdmac configuration) so that we avoid build errors whichever git tree
(slave-dma or arm-soc) is merged first.
A SPI DT patch for at91sam9x5 is also added.

Thanks, best regards,

The following changes since commit 028633c238f91dc113520a7ad25d37b2ba9068af:

  ARM: at91/dt: add pinctrl definition for at91 tc blocks (2013-05-31 22:40:37 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt

for you to fetch changes up to 24ce10e142e7b063c4ae4437dd3b290fbfafe052:

  ARM: at91: sam9m10g45ek add udc DT support (2013-06-15 00:15:22 +0200)

----------------------------------------------------------------
Again some nice DT updates for AT91:
- DMA binding update with one patch shared with slave-dma tree
- more SPI DT activation
- enable the USB gadget HS for DT platforms

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (4):
      ARM: at91: sam9x5 add udc DT support
      ARM: at91: sam9x5ek add udc DT support
      ARM: at91: sam9g45 add udc DT support
      ARM: at91: sam9m10g45ek add udc DT support

Ludovic Desroches (2):
      ARM: at91: dt: add header to define at_hdmac configuration
      ARM: at91: dt: switch DMA DT bindings to pre-processor

Richard Genoud (1):
      ARM: at91: dt: at91sam9x5: add SPI DMA client infos

 arch/arm/boot/dts/at91sam9g45.dtsi     | 67 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9m10g45ek.dts |  5 ++
 arch/arm/boot/dts/at91sam9n12.dtsi     | 11 +++--
 arch/arm/boot/dts/at91sam9x5.dtsi      | 85 ++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/at91sam9x5ek.dtsi    |  5 ++
 arch/arm/boot/dts/sama5d3.dtsi         | 19 ++++----
 arch/arm/mach-at91/at91sam9g45.c       |  2 +
 arch/arm/mach-at91/at91sam9x5.c        |  2 +
 include/dt-bindings/dma/at91.h         | 27 +++++++++++
 9 files changed, 199 insertions(+), 24 deletions(-)
 create mode 100644 include/dt-bindings/dma/at91.h

-- 
Nicolas Ferre
