From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Wed, 27 Dec 2017 08:59:52 +0800
Subject: [PATCH v5 0/2] PCI: mediatek: Fixups for the IRQ handle routine and
 MT7622's class code
Message-ID: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Two fixups for mediatek's host bridge:
The first patch fixup the IRQ handle routine to avoid IRQ reentry which
may exist for both MT2712 and MT7622.
The second patch fixup class type for MT7622.

Change since v4:
 - Only setup vendor ID for MT7622, igorning the device ID since mediatek's
   host bridge driver does not cares about the device ID.

Change since v3:
 - Setup the class type and vendor ID at the beginning of startup instead
   of in a quirk.
 - Add mediatek's vendor ID, it could be found in:
   https://pcisig.com/membership/member-companies?combine=&page=4

Change since v2:
 - Move the initialize of the iterate before the loop to fix an
   INTx IRQ issue in the first patch

Change since v1:
 - Add the second patch.
 - Make the first patch's commit message more standard.

Honghui Zhang (2):
  PCI: mediatek: Clear IRQ status after IRQ dispatched to avoid reentry
  PCI: mediatek: Set up class type and vendor ID for MT7622

 drivers/pci/host/pcie-mediatek.c | 23 ++++++++++++++++++-----
 include/linux/pci_ids.h          |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.6.4
