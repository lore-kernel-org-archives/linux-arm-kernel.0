From: okhaliq@caviumnetworks.com (Omer Khaliq)
Date: Tue, 23 Aug 2016 16:27:13 -0700
Subject: [PATCH v2 0/2] HWRNG/PCI: Add driver for Cavium Thunder RNG
Message-ID: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a hardware error rendering the FDL field incorrect for the some
Thunder RNG devices. The first patch adds a PCI quirk to fix the problem.

The second patch adds the driver.

Changes from v1:
	Use PCI quirks as advised.
	Removed unecessary headers
	Format changes as advised

Ananth Jasty (1):
  PCI: quirk fixup for cavium invalid sriov link value.

Omer Khaliq (1):
  HWRNG: thunderx: Add Cavium HWRNG driver for ThunderX SoC.

 drivers/char/hw_random/Kconfig         | 13 +++++
 drivers/char/hw_random/Makefile        |  1 +
 drivers/char/hw_random/cavium-rng-vf.c | 99 ++++++++++++++++++++++++++++++++++
 drivers/char/hw_random/cavium-rng.c    | 94 ++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c                   | 11 ++++
 5 files changed, 218 insertions(+)
 create mode 100644 drivers/char/hw_random/cavium-rng-vf.c
 create mode 100644 drivers/char/hw_random/cavium-rng.c

-- 
1.9.1
