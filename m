From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 14:04:17 +0100
Subject: [PATCH v4 0/6] USB EHCI multiplatform conversion
Message-ID: <1364648663-29296-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

This is a quick update to v3, addressing all issues you pointed in
yesterday's review. Thanks for taking a thorough look on short notice
on a public holiday!

	Arnd

Arnd Bergmann (1):
  USB: OHCI: avoid conflicting platform drivers

Manjunath Goudar (5):
  USB: EHCI: make ehci-orion a separate driver
  USB: EHCI: make ehci-spear a separate driver
  USB: EHCI: make ehci-s5p a separate driver
  USB: EHCI: make ehci-atmel a separate driver
  USB: EHCI: make ehci-msm a separate driver

 drivers/usb/host/Kconfig      |  40 +++++++++--
 drivers/usb/host/Makefile     |   5 ++
 drivers/usb/host/ehci-atmel.c |  88 +++++++++++------------
 drivers/usb/host/ehci-hcd.c   |  30 ++------
 drivers/usb/host/ehci-msm.c   |  85 ++++++++++------------
 drivers/usb/host/ehci-orion.c |  82 +++++++++------------
 drivers/usb/host/ehci-s5p.c   | 164 +++++++++++++++++++++---------------------
 drivers/usb/host/ehci-spear.c | 115 +++++++++++++----------------
 drivers/usb/host/ohci-hcd.c   | 136 ++++++++++++++++++++++++++++++-----
 9 files changed, 408 insertions(+), 337 deletions(-)

-- 
1.8.1.2

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
