From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 13 Sep 2011 17:56:17 +0530
Subject: [PATCH v2 0/2] Add device tree support for Samsung's keypad controller
	driver
Message-ID: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Addressed comments from Dmitry Torokhov.
  - Type of controller is cached in driver's private data and the function
    that determines the type of the controller for each keypad scan is
    removed.
  - pdata allocated during probe is explicitly freed after probe completes
    without any error. In case of exit from probe due a error, no explicit
    deallocation of pdata memory is performed and it is left to devres to
    handle that.
  - The generic code to translate KEY(x,y,code) is retained in the driver
    itself. I am unsure of a right common place for it.
  - Driver continues with the probe even if one or more gpio configuration
    fails.
  - Patch 1 that adds a new config option is still retained in this patchset.


This patchset adds device tree support for samsung's keypad controller driver.
First patch adds a new config option to be used by device tree enabled platforms
for selecting the samsung's keypad controller driver. The second patch adds device
tree support for the keypad driver.

Thomas Abraham (2):
  input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config option
  input: samsung-keypad: Add device tree support

 .../devicetree/bindings/input/samsung-keypad.txt   |   88 ++++++++++
 drivers/input/keyboard/Kconfig                     |    9 +-
 drivers/input/keyboard/samsung-keypad.c            |  177 ++++++++++++++++++--
 3 files changed, 261 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
