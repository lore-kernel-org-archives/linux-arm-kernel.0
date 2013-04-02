From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  2 Apr 2013 18:23:58 +0200
Subject: [PATCH V5 0/6] USB: EHCI multiplatform for 3.10
Message-ID: <1364919844-1726-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here are the EHCI patches that I think are good for inclusion in 3.10,
I hope you are willing to include them after the debacle over these
patches in 3.9.

The patches are all logically independent but sorted by priority,
so decide for yourself how many you want to take, starting at the
first one. The first six patches all have an Ack from Alan Stern
and from the respective ARM platform maintainers.

* The first patch (Orion) fixes a preexisting bug because the driver
  conflicts with the OMAP and vt8500 back-ends in 3.9. Both of those
  are fixed in usb-next now, but the same problem comes back with
  any other platform we enable for ARM multiplatform support.
* The second patch fixes a problem that will happen in 3.10 as we
  enable SPEAr multiplatform support.
* S5P/Exynos multiplatform support is not yet part of linux-next, but
  I still have hope for 3.10, so the third patch will be needed as well
  then.
* The ehci-atmel patch will not be needed in 3.10 but quite likely
  in 3.11.
* I have no time line for MSM multiplatform support, but we will
  get there eventually and the driver is broken already so there
  is no risk of regressions.
* The final patch is from me and still waiting for an Ack from Alan
  Stern, so please wait for his feedback before applying that one.

There is one more patch coming for ehci-tegra. I've forwarded
Manjunath's work on that driver to the Tegra developers, who
will test it and send it directly to you. The version I had was
incomplete.

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
 drivers/usb/host/ehci-msm.c   |  89 +++++++++++------------
 drivers/usb/host/ehci-orion.c |  82 +++++++++------------
 drivers/usb/host/ehci-s5p.c   | 164 +++++++++++++++++++++---------------------
 drivers/usb/host/ehci-spear.c | 115 +++++++++++++----------------
 drivers/usb/host/ohci-hcd.c   | 136 ++++++++++++++++++++++++++++++-----
 9 files changed, 412 insertions(+), 337 deletions(-)

-- 
1.8.1.2
