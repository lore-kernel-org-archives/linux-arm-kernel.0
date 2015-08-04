From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 14:01:01 +0000
Subject: [PATCH v2 0/9] usb: Simplify return statements
Message-ID: <cover.1438695318.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

This patch series is created using simple_return.cocci coccinelle script.
It replaces the redundant instances where variable is first assigned
return value from a function call and then used in return statement,
by direct function call in the return statement.

Changes for v2:
- corrected indentation issues [Patch 06/09, 08/09, 09/09]
- Patch 04/09 Acked by Patrice Chotard <patrice.chotard@st.com>

Saurabh Karajgaonkar (9):
  usb: phy: phy-mxs-usb: Simplify return statement
  usb: phy: phy-keystone: Simplify return statement
  usb: musb: musb_dsps: Simplify return statement
  usb: host: ehci-st: Simplify return statement
  usb: host: oxu210hp-hcd: Simplify return statement
  usb: host: u132-hcd: Simplify return statement
  usb: host: xhci: Simplify return statement
  usb: serial: mxuport: Simplify return statement
  usb: misc: ftdi-elan: Simplify return statement

 drivers/usb/host/ehci-st.c      |  7 +------
 drivers/usb/host/oxu210hp-hcd.c |  7 +------
 drivers/usb/host/u132-hcd.c     | 35 +++++++++--------------------------
 drivers/usb/host/xhci.c         |  6 +-----
 drivers/usb/misc/ftdi-elan.c    | 12 ++----------
 drivers/usb/musb/musb_dsps.c    |  6 +-----
 drivers/usb/phy/phy-keystone.c  |  6 +-----
 drivers/usb/phy/phy-mxs-usb.c   |  6 +-----
 drivers/usb/serial/mxuport.c    | 10 +++-------
 9 files changed, 20 insertions(+), 75 deletions(-)

-- 
1.9.1
