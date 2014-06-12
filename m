From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Jun 2014 15:20:40 +0200
Subject: [PATCHv4 0/5] mtd: gpmi: make blockmark swapping optional
Message-ID: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a flash-based BBT there is no reason to move the Factory Bad
Block Marker from the data area buffer (to where it is mapped by the
GPMI NAND controller) to the OOB buffer. Thus, make this feature
configurable via DT. This is required for the Ka-Ro electronics
i.MX6 platforms.

Changes wrt. v2:
- added a warning for i.MX28 to the binding documentation
- fixed the gpmi_ecc_read_subpage() routine which turned on blockmark
  swapping unconditionally
- use !GPMI_IS_MX23() in place of this->swap_block_mark (which were
  synonymous the original code) in gpmi_ecc_read_oob() and
  gpmi_block_markbad()
- make nand-on-flash-bbt a prerequisite for this feature

patch added:
- add an additional option to turn of BB mark writing

Changes wrt. v3:
- added two code cleanup patches
- added a patch to turn of NAND_BBT_CREATE, if blockmark swapping is disabled
