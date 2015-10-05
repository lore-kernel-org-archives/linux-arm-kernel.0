From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 5 Oct 2015 15:55:57 +0100
Subject: [GIT PULL] PSCI 1.0 implementation for v4.4
Message-ID: <20151005145557.GA2705@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please consider pulling the following commits for v4.4.

The commits update the PSCI kernel interface implementation
so that it becomes compliant with the PSCI v1.0 specification and
also provide code that enables PSCI based suspend-to-RAM
based on the newly introduced PSCI v1.0 System Suspend call.

Thanks,
Lorenzo

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/firmware/psci-1.0

for you to fetch changes up to faf7ec4a92c0231d1079177095077c162eb9b466:

  drivers: firmware: psci: add system suspend support (2015-10-02 14:35:17 +0100)

----------------------------------------------------------------
This pull request contains patches that enable PSCI 1.0 firmware
features for arm/arm64 platforms:

- Lorenzo Pieralisi adds support for the PSCI_FEATURES call, manages
  various 1.0 specifications updates (power state id and functions return
  values) and provides PSCI v1.0 DT bindings
- Sudeep Holla implements PSCI v1.0 system suspend support to enable PSCI
  based suspend-to-RAM

----------------------------------------------------------------
Lorenzo Pieralisi (5):
      drivers: firmware: psci: add INVALID_ADDRESS return value
      drivers: firmware: psci: move power_state handling to generic code
      drivers: firmware: psci: add PSCI_FEATURES call
      drivers: firmware: psci: add extended stateid power_state support
      drivers: firmware: psci: add PSCI v1.0 DT bindings

Sudeep Holla (2):
      drivers: firmware: psci: define more generic PSCI_FN_NATIVE macro
      drivers: firmware: psci: add system suspend support

 Documentation/devicetree/bindings/arm/psci.txt |   6 ++
 arch/arm64/kernel/psci.c                       |  14 ----
 drivers/firmware/psci.c                        | 107 ++++++++++++++++++++++---
 include/linux/psci.h                           |   2 +
 include/uapi/linux/psci.h                      |  18 +++++
 5 files changed, 123 insertions(+), 24 deletions(-)
