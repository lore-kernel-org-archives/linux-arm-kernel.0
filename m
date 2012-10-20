From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 21 Oct 2012 11:10:30 +1300
Subject: [PATCH v2 0/2] Update ehci-platform driver to support devicetree
Message-ID: <1350771032-11527-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the ehci-platform.c driver to allow device tree probing.
I have dropped support for the three function pointers (power_on, power_off
and power_suspend). If someone has knowledge of the power sequence functions
that are being implemented, these functions could be replaced (Sorry, I don't
know anything about implementing it).

port_power_(on_off) properties are not supported in DT as Alan Stern indicated
they are going to be removed.

v2:
* Add error checking for pdata memory allocation, and memory freeing in remove()

* Add no_io_watchdog field to usb_ehci_pdata as required by Florian Fainelli's
upcoming patchset and DT parsing for the field. This means we don't need to
patch this driver again after applying Florian's patchset, but will create a
minor merge-conflict.

* Changed compatible string to 'linux,ehci-platform' as a lot of the DT
properties are linux-specific.

* Changed properties to match those expected in usb-ehci binding.


Tony Prisk (2):
  USB: Update EHCI-platform driver to devicetree.
  USB: doc: Binding document for ehci-platform driver

 .../devicetree/bindings/usb/ehci-platform.txt      |   27 ++++
 drivers/usb/host/ehci-hcd.c                        |    5 -
 drivers/usb/host/ehci-platform.c                   |   61 ++++++-
 drivers/usb/host/ehci-vt8500.c                     |  171 --------------------
 include/linux/usb/ehci_pdriver.h                   |    1 +
 5 files changed, 88 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-platform.txt
 delete mode 100644 drivers/usb/host/ehci-vt8500.c

-- 
1.7.9.5
