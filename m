From: w@1wt.eu (Willy Tarreau)
Date: Tue, 7 May 2013 23:42:56 +0200
Subject: MVNETA irq with backport-3.8
In-Reply-To: <518971D4.5000603@free-electrons.com>
References: <51890C29.8000504@itooo.com> <20130507181823.23342ffb@skate>
 <51892E87.5020903@itooo.com> <518971D4.5000603@free-electrons.com>
Message-ID: <20130507214256.GC5414@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gr?gory,

On Tue, May 07, 2013 at 11:27:48PM +0200, Gregory CLEMENT wrote:
> I built and tested backport-3.8 and indeed the Ethernet is broken.
> It was cause by a recent batch of fixes that I added, now I have to
> figure out why they have broken the ethernet whereas they were supposed
> to make it work better!

If that can help you, here is the list of (possibly relevant) patches
I have applied on top of 3.9 picked from your repository some time
ago (it's not up to date with the latest versions due to merge issues
inducing laziness on my side) :

$ git log --oneline --grep=free-electrons v3.9.. 
65d2b5c ARM: mvebu: Add Device Bus and CFI flash memory support to defconfig
26cabde ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board
34b32e8 ARM: mvebu: Add support for NOR flash device on Armada XP-GP board
31504c0 ARM: mvebu: Add Device Bus support for Armada 370/XP SoC
8cc752e drivers: memory: Introduce Marvell EBU Device Bus driver
48c6ddc arm: mvebu: update defconfig with PCI and USB support
f4ed5ba arm: mvebu: PCIe Device Tree informations for Armada XP GP
b1ed2c5 arm: mvebu: PCIe Device Tree informations for Armada 370 DB
51e91a9 arm: mvebu: PCIe Device Tree informations for Armada 370 Mirabox
402f9ba arm: mvebu: PCIe Device Tree informations for Armada XP DB
4899409 arm: mvebu: PCIe Device Tree informations for OpenBlocks AX3-4
fb6d69f arm: mvebu: add PCIe Device Tree informations for Armada XP
c523287 arm: mvebu: add PCIe Device Tree informations for Armada 370
998ee7a arm: mvebu: PCIe support is now available on mvebu
fc9b219 pci: PCIe driver for Marvell Armada 370/XP systems
4b765fb clk: mvebu: add more PCIe clocks for Armada XP
af3bcd9 clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
6cee09e arm: pci: add a align_resource hook
80fa698 pci: infrastructure to add drivers in drivers/pci/host
91ca5a7 of/pci: Provide support for parsing PCI DT ranges property
e46b3e7 arm: plat-orion: remove addr-map code
d11befe arm: mach-mv78xx0: convert to use the mvebu-mbus driver
a508a65 arm: mach-orion5x: convert to use mvebu-mbus driver
e249639 arm: mach-dove: convert to use mvebu-mbus driver
70efe5e arm: mach-kirkwood: convert to use mvebu-mbus driver
37e82515 arm: mach-mvebu: convert to use mvebu-mbus driver
035f910 bus: introduce an Marvell EBU MBus driver
527d658 arm: mach-orion5x: use mv_mbus_dram_info() in PCI code
c1b44db arm: plat-orion: use mv_mbus_dram_info() in PCIe code
59463f4 arm: plat-orion: only build addr-map.c when needed

With those my AX3 works fine. If that can help, I can send them all to
you off-list, in case you notice a minor difference with something.

Regards,
Willy
