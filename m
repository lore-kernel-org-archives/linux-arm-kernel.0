From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 09:07:30 +0000
Subject: [PATCH 0/9] usb: Simplify return statements
Message-ID: <cover.1438678566.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

This patch series is created using simple_return.cocci coccinelle script.
It replaces the redundant instances where variable is first assigned
return value from a function call and then used in return statement,
by direct function call in the return statement.

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
 drivers/usb/host/u132-hcd.c     | 27 +++++----------------------
 drivers/usb/host/xhci.c         |  6 +-----
 drivers/usb/misc/ftdi-elan.c    | 10 ++--------
 drivers/usb/musb/musb_dsps.c    |  6 +-----
 drivers/usb/phy/phy-keystone.c  |  6 +-----
 drivers/usb/phy/phy-mxs-usb.c   |  6 +-----
 drivers/usb/serial/mxuport.c    |  6 +-----
 9 files changed, 14 insertions(+), 67 deletions(-)

-- 
1.9.1
