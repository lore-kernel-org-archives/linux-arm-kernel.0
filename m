From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 22:54:58 +0100
Subject: [PATCH v3 0/7] USB EHCI multiplatform series again
Message-ID: <1364507705-22012-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

These are the current patches from Manjunath, after I helped him address
the remaining review comments and found a few more in the process.

Unfortunately, Manjunath is currently on vacation and I will be away for
the next couple of days when he returns, so I took the liberty to send
the patches myself to have a chance of getting them merged in time for
3.10.

The patches are all based on today's usb-next branch, which includes
my earlier patch to remove the vt8500 backend. They are sorted by
priority: the first one obviously should have been in 3.9 but didn't
make it. The second one will be needed in 3.10, and the third one
quite likely as well. The atmel and msm patches can wait for 3.11
since we don't plan to have multiplatform support for those SoCs
in 3.10. Manjunath also did patches for the tegra, mv and w90X900
back-ends, but there are still known bugs in them so we don't submit
them yet. Tegra might become multiplatform in 3.10, but that will
still work as long as it's the only platform defining the
PLATFORM_DRIVER macro.

Please review the latest version so we can get at least the first
three patches merged for 3.10, or more if you are happy with them.
I'm not sure what to do about OHCI, the last patch in this series
is the best I could think of, given that nobody has worked on a
proper series.

Nicolas and David: the at91 and msm patches have no maintainer
Ack so far and are build-tested only. Please let us know if you
want to get them merged for 3.10, or if we should drop them for
now and let you pick them up when you get around to adding
multiplatform support for your SoCs. The at91 patch requires
"USB: EHCI: export ehci_shutdown", which will also be needed
for the upcoming Tegra patch.

	Arnd

Arnd Bergmann (2):
  USB: EHCI: export ehci_shutdown
  USB: OHCI: avoid conflicting platform drivers

Manjunath Goudar (5):
  USB: EHCI: make ehci-orion a separate driver
  USB: EHCI: make ehci-spear a separate driver
  USB: EHCI: make ehci-s5p a separate driver
  USB: EHCI: make ehci-atmel a separate driver
  USB: EHCI: make ehci-msm a separate driver

 drivers/usb/host/Kconfig      |  33 ++++++++-
 drivers/usb/host/Makefile     |   5 ++
 drivers/usb/host/ehci-atmel.c |  85 +++++++++++------------
 drivers/usb/host/ehci-hcd.c   |  33 ++-------
 drivers/usb/host/ehci-msm.c   |  85 ++++++++++-------------
 drivers/usb/host/ehci-orion.c |  82 ++++++++++------------
 drivers/usb/host/ehci-s5p.c   | 153 +++++++++++++++++++++---------------------
 drivers/usb/host/ehci-spear.c |  88 +++++++++++-------------
 drivers/usb/host/ehci.h       |   1 +
 drivers/usb/host/ohci-hcd.c   | 136 ++++++++++++++++++++++++++++++++-----
 10 files changed, 391 insertions(+), 310 deletions(-)

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Greg KH <greg@kroah.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-usb at vger.kernel.org
Cc: spear-devel at list.st.com


-- 
1.8.1.2
