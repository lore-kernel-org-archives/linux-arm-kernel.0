From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 26 May 2013 10:34:30 +0200
Subject: [GIT PULL] at91: USBA DT support for 3.11
Message-ID: <20130526083430.GP24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

Second AT91 pull-request for 3.11

This add the DT support the USBA present in the most recents AT91 SoC
As agree with Arnd and Filipe we send the drivers via arm-soc

this is base on previous pull request at91-3.11-cleanup1+resolved

Best Regards,
J.

The following changes since commit 7a76f53b01685eda605fa15ccaa1ca90a7aa2c33:

  ARM: at91: udpate defconfigs (2013-05-24 18:02:06 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-3.11-dt-usba

for you to fetch changes up to e6a2ba4b6fc828917c66cd7ffafdfb7a889d7bee:

  ARM: at91: sam9m10g45ek add udc DT support (2013-05-26 16:35:55 +0800)

----------------------------------------------------------------
ARM: at91: dt: add USBA support

This patch serie finish to add the usb device support to dt for at91
with the usba support present on the last at91 generation since sam9g45

update driver & dt

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (7):
      USB: gadget: atmel_usba: move global struct usba_ep usba_ep to struct usba_udc
      USB: gadget: atmel_usba: allow multi instance
      USB: gadget: atmel_usba: add DT support
      ARM: at91: sam9x5 add udc DT support
      ARM: at91: sam9x5ek add udc DT support
      ARM: at91: sam9g45 add udc DT support
      ARM: at91: sam9m10g45ek add udc DT support

 Documentation/devicetree/bindings/usb/atmel-usb.txt |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                  |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts              |    5 +++++
 arch/arm/boot/dts/at91sam9x5.dtsi                   |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi                 |    5 +++++
 arch/arm/mach-at91/at91sam9g45.c                    |    2 ++
 arch/arm/mach-at91/at91sam9x5.c                     |    2 ++
 drivers/usb/gadget/Kconfig                          |    2 +-
 drivers/usb/gadget/atmel_usba_udc.c                 |  264 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
 drivers/usb/gadget/atmel_usba_udc.h                 |    2 ++
 10 files changed, 407 insertions(+), 81 deletions(-)
