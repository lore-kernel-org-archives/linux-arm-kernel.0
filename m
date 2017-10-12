From: briannorris@chromium.org (Brian Norris)
Date: Thu, 12 Oct 2017 13:52:17 -0700
Subject: [PATCH 0/3] PCI: rockchip: assert PERST# in S3
Message-ID: <20171012205220.130048-1-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series should mostly be self-descriptive, but it's motivated by the
fact that I've found differing requirements from PCIe endpoint makers regarding
the state of PERST# when in system suspend (S3). Additionally, some existing
boards are not especially well suited for holding PERST# low in S3 (e.g., the
pin is driven by a non-PMU GPIO, so it's hard or impossible to keep it
asserted). So the solution is...give it a device tree property!

Brian

Brian Norris (3):
  Documentation/devicetree: Add pcie-reset-suspend property
  of/pci: Add of_pci_get_pcie_reset_suspend() to parse
    pcie-reset-suspend
  PCI: rockchip: Support configuring PERST# state via DT

 Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
 drivers/of/of_pci.c                           | 25 +++++++++++++++++++++++++
 drivers/pci/host/pcie-rockchip.c              |  7 +++++++
 include/linux/of_pci.h                        |  7 +++++++
 4 files changed, 50 insertions(+)

-- 
2.15.0.rc0.271.g36b669edcc-goog
