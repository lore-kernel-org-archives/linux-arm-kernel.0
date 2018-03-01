From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 1 Mar 2018 10:51:37 +0100
Subject: [PATCH v4 0/2] usb: host: ehci-platform: add support for optional
 external vbus supply
Message-ID: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for optional external vbus supply per port in
ehci-platform.

On some boards, especially when vbus supply requires large current,
and the charge pump on the PHY isn't enough, an external vbus power switch
per port may be used.

---
Changes in v4:
 * Address Roger Quadros comments: split dt-bindings and driver changes.
 * Address Robin Murphy comments: simplify vbus_spplies initialization.

Changes in v3:
 * Address Felipe Balbi comments: reduce indentation in
   ehci_platform_port_power.
 * Address Roger Quadros and Alan Stern comments: platforms can have one
   external vbus supply per port, so add support to get as many optional
   regulator as implemented ports on the host controller.

Changes in v2:
 * Address Roger Quadros comments: move regulator_enable/disable from
   ehci_platform_power_on/off to ehci_platform_port_power.

Amelie Delaunay (2):
  dt-bindings: usb: ehci: add optional external vbus supply property
  usb: host: ehci-platform: add support for optional external vbus
    supply

 Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
 drivers/usb/host/ehci-platform.c                   | 51 +++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.7.4
