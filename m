From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 20:04:06 +0000
Subject: [PATCH 0/5] SA1111 USB cleanups
Message-ID: <20120203200406.GI14129@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the final set for this evening; this is a smaller set of cleanups
and updates for the SA1111 OHCI driver.  This series depends on the
SA1111 patch series.

One of the things it completes is the work in 64a21d025d3 (USB: Properly
unregister reboot notifier in case of failure in ehci hcd) by adding
the shutdown methods.  (That commit notes that it omitted SA1111 due to
no shutdown callback.  And there is now.)

 drivers/usb/host/ohci-sa1111.c |  244 ++++++++++++++++++----------------------
 1 files changed, 108 insertions(+), 136 deletions(-)
