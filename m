From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 2 May 2017 10:59:24 +0100
Subject: [RFC PATCH 0/2] net: ixgbe: disable relaxed ordering at runtime
Message-ID: <1493719166-9036-1-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset is based on Casey's patchset:
https://www.spinics.net/lists/arm-kernel/msg578927.html

It is a proposal to convert the ixgbe driver to disable RO at runtime
depending on the root port flags.

TODO: Casey's patchset above add quirks to disable RO only for Intel
E5-26xx and AMD ARM A1100, whereas currently the Intel ixgbe driver
disable RO by default. Therefore there may be some other host quirks
to be added in drivers/pci/quirks....

gabriele paoloni (2):
  net: revert commit 1a8b6d76dc5b
  net: ixgbe: disable RO depending on the root port flags

 arch/Kconfig                                    |  3 ---
 arch/sparc/Kconfig                              |  1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 35 ++++++++++++++-----------
 3 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.7.4
