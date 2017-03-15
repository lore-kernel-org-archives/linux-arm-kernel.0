From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 15 Mar 2017 08:49:13 +0100
Subject: [PATCH 0/2] ThunderX external PCI fixes for legacy&new ACPI firmware
Message-ID: <1489564155-3881-1-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series update ThunderX PEM driver to be able to boot with legacy
and new ACPI firmware:
1. New firmware uses registered Cavium harware ID "CAV", but kernel instead
   uses "THRX". Fix kernel to use "CAV".
2. Legacy firmware misses PEM quirks information so for this case kernel
   should not assume anything from FW and figure out PEM resources on its own.

Fix this all together in the following branch:
git at github.com:semihalf-nowicki-tomasz/linux.git (thunderx-pci-legacy-fw-v1)

Tomasz Nowicki (2):
  PCI: Use Cavium assigned hardware ID for ThunderX host controller
  PCI: Add legacy firmware support for Cavium ThunderX host controller

 drivers/pci/host/pci-thunder-pem.c | 58 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

-- 
2.7.4
