From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 19 Oct 2009 14:30:14 +0200
Subject: [PATCH] kirkwood: pci: don't remap io address
Message-ID: <8763absh0p.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The kirkwood pci support is registering itself with the normal addresses
but is configured in kirkwood_setup_cpu_mbus() to remap the i/o port
addresses to 0. This is making the pci devices with i/o port non
functionnal. Disabling the remapping is fixing the issue.

Tested on a openrd-client box.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kirkwood_pcie_fix.patch
Type: text/x-diff
Size: 542 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091019/3be14c3f/attachment.bin>
