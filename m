From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 11 Apr 2014 16:32:28 +0200
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410181953.50ccfcc3@skate>
References: <20140410181953.50ccfcc3@skate>
Message-ID: <20140411163228.4214645c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

On Thu, 10 Apr 2014 18:19:53 +0200, Thomas Petazzoni wrote:

> This is an e-mail that attempts to summarize the situation in terms of
> Armada XP PCIe issues.

Attached is a v2 of the patches to fix the various pci-mvebu issues.
Changes since the version posted yesterday:

 * Include a fix for the timing issue of the PCIe interface that gets
   its clock disabled. I've chosen a different approach than the one
   suggested by Jason Gunthorpe, which does not involve resetting the
   PHY. I've tested my fix on the Mirabox, and the Armada 385 DB board
   on which Gregory originally reported the problem (I finally managed
   to reproduce the problem, it was due to the fact that only one of
   the PCIe interfaces is actually affected by the problem, because
   only the clock of the first PCIe interface is used by the
   mvebu-soc-id stuff).

 * Invert the order of Willy's and Jason's patches around MBus
   addresses.

I've also:

 * Pushed the patches at
   https://github.com/MISL-EBU-System-SW/mainline-public/tree/3.14/pci-debug

 * Included a single combined patch, because I know one of you needs
   that to test easily.

Can everybody test these patches, and confirm that they solve all the
outstanding problems?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-igb-Fix-Null-pointer-dereference-in-igb_reset_q_vect.patch
Type: text/x-patch
Size: 1808 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0014.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-igb-Unset-IGB_FLAG_HAS_MSIX-flag-when-falling-back-t.patch
Type: text/x-patch
Size: 5116 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0015.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-ARM-mvebu-change-the-default-PCIe-apertures-for-Arma.patch
Type: text/x-patch
Size: 2556 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0016.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-ARM-mvebu-switch-the-Armada-XP-DB-to-use-internal-re.patch
Type: text/x-patch
Size: 2498 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0017.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-ARM-mvebu-switch-the-Armada-XP-GP-to-use-internal-re.patch
Type: text/x-patch
Size: 3574 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0018.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-irqchip-armada-370-xp-fix-invalid-cast-of-signed-val.patch
Type: text/x-patch
Size: 1377 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0019.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0007-irqchip-armada-370-xp-implement-the-check_device-msi.patch
Type: text/x-patch
Size: 1700 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0020.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0008-irqchip-armada-370-xp-Fix-releasing-of-MSIs.patch
Type: text/x-patch
Size: 1273 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0021.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0009-pci-mvebu-fix-off-by-one-in-the-computed-size-of-the.patch
Type: text/x-patch
Size: 1860 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0022.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0010-bus-mvebu-mbus-Avoid-setting-an-undefined-window-siz.patch
Type: text/x-patch
Size: 2238 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0023.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0011-bus-mvebu-mbus-allow-several-windows-with-the-same-t.patch
Type: text/x-patch
Size: 1136 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0024.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0012-pci-pci-mvebu-split-PCIe-BARs-into-multiple-MBus-win.patch
Type: text/x-patch
Size: 6126 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0025.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0013-pci-pci-mvebu-wait-for-a-device-to-appear-to-fix-clo.patch
Type: text/x-patch
Size: 3592 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0026.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: combined.patch
Type: text/x-patch
Size: 15073 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/1b58ef39/attachment-0027.bin>
