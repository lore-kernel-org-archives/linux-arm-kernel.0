From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 27 Jul 2015 10:44:26 +0100
Subject: [PATCH v2 0/6] Mailbox: Provide support STi based platforms
Message-ID: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's platforms currently support a maximum of 5 Mailboxes, one for
each of the supported co-processors situated on the platform.  Each
Mailbox is divided up into 4 instances which consist of 32 channels.
Messages are passed between the application and co-processors using
shared memory areas.

Also included in the set is an example Client which should be generic
enough to use as a testing environment for all Mailbox IPs which use
shared memory to pass messages.  With a small change, it should also
be able to test more extravagant implementations too.

v1 => v2:
 - New MACRO() to obtain base address for a given instance
 - Move locking into the structure it protects
 - Stop checking for 'ready' state when sending data
 - Don't clear channel data (that belongs to the API)
 - #define register offsets instead of providing via pdata
 - Register driver with module_platform_driver()

Lee Jones (6):
  mailbox: dt: Supply bindings for ST's Mailbox IP
  mailbox: dt-bindings: Add shared [driver <=> device tree] defines
  mailbox: Add support for ST's Mailbox IP
  ARM: STi: stih407-family: Add nodes for Mailbox
  mailbox: Add generic mechanism for testing Mailbox Controllers
  ARM: STi: DT: STiH407: Enable Mailbox testing facility

 .../devicetree/bindings/mailbox/sti-mailbox.txt    |  53 +++
 arch/arm/boot/dts/stih407-family.dtsi              |  40 ++
 drivers/mailbox/Kconfig                            |  14 +
 drivers/mailbox/Makefile                           |   4 +
 drivers/mailbox/mailbox-sti.c                      | 527 +++++++++++++++++++++
 drivers/mailbox/mailbox-test.c                     | 210 ++++++++
 include/dt-bindings/mailbox/mailbox.h              |  14 +
 7 files changed, 862 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-sti.c
 create mode 100644 drivers/mailbox/mailbox-test.c
 create mode 100644 include/dt-bindings/mailbox/mailbox.h

-- 
1.9.1
