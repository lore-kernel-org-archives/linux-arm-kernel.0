From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 20 Oct 2012 16:17:31 +1300
Subject: [RFC PATCH 0/2] Update ehci-platform driver to support devicetree
Message-ID: <1350703053-4661-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the ehci-platform.c driver to allow device tree probing.
I have dropped support for the three function pointers (power_on, power_off
and power_suspend). If someone has knowledge of the power sequence functions
that are being implemented, these functions could be replaced (Sorry, I don't
know anything about implementing it).

port_power_(on_off) properties are not supported in DT as Alan Stern indicated
they are going to be removed.

I have included a binding document, but must admit most of the descriptions
for the properties are guessed. Quite likely some of these descriptions are
incorrect and/or need to be clarified.

Tony Prisk (2):
  USB: Update EHCI-platform driver to devicetree.
  USB: doc: Binding document for ehci-platform driver

 .../devicetree/bindings/usb/ehci-platform.txt      |   22 +++
 drivers/usb/host/ehci-hcd.c                        |    5 -
 drivers/usb/host/ehci-platform.c                   |   46 ++++++
 drivers/usb/host/ehci-vt8500.c                     |  171 --------------------
 4 files changed, 68 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-platform.txt
 delete mode 100644 drivers/usb/host/ehci-vt8500.c

-- 
1.7.9.5
