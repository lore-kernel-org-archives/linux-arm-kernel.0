From: nm@ti.com (Nishanth Menon)
Date: Mon, 16 Jul 2018 13:06:01 -0500
Subject: [PATCH V2 0/6] mailbox: ti-msgmgr: Add support for AM654 Secure Proxy
Message-ID: <20180716180607.16526-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V2 of the series updates a minor comment in binding and picks up Rob's Reviewed-by

Since I have'nt seen additional comments, I am assuming things are fine for v4.19.

The following series enables support for Secure Proxy in newest addition in TI's SoC
portfolio - AM654 SoC (posted previously as RFC).

The series is based on v4.18-rc1 and is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-sproxy

There are a couple of follow on patches to be posted as well (Kconfig changes
for K3_ARCH and actual dts node changes).

Changes since RFC are highlighted in each of the patches, but overall:
* The K3 dependency has been broken out into a seperate series independent of
  this.
* Binding has been seperated out as it's own file (even though the driver is
  reused).

Consolidated all patches (including all series) are available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ

Full Boot log  on AM654 (integrated with all patch series) is available here:
   https://pastebin.ubuntu.com/p/bBFmnzYtCd/

Nishanth Menon (6):
  mailbox: ti-msgmgr: Get rid of unused structure members
  mailbox: ti-msgmgr: Allocate Rx channel resources only on request
  mailbox: ti-msgmgr: Change message count mask to be descriptor based
  mailbox: ti-msgmgr: Move the memory region name to descriptor
  dt-bindings: mailbox: Add support for secure proxy threads
  mailbox: ti-msgmgr: Add support for Secure Proxy

 .../bindings/mailbox/ti,secure-proxy.txt           |  50 +++
 drivers/mailbox/ti-msgmgr.c                        | 353 +++++++++++++++++----
 2 files changed, 336 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt

-- 
2.15.1
