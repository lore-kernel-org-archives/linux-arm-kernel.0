From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 18:07:50 +0000
Subject: [RFC PATCHv1 0/5] Use the mvebu PCIe driver on Kirkwood
In-Reply-To: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201303271807.51023.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Thomas Petazzoni wrote:
> Here is a set of five patches that demonstrate that the mvebu PCIe
> driver can be used on Kirkwood with no modification at all. Those
> patches are not meant to be applied yet, the Device Trees are not
> completely correct yet (they don't take into account the fact that
> 6281 has one PCIe interface and 6282 has two PCIe interface).
> 
> It took less than two hours to enable PCIe on Kirkwood (and in those
> two hours, the conversion of the DB-88F6281 board to the Device Tree
> has been done as well), and the result works fine:
> 
> # /usr/sbin/lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
> 01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
> 02:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
> 
> # cat /proc/cpuinfo | grep ^Hardware
> Hardware        : Marvell Kirkwood (Flattened Device Tree)

Very nice!

> I've tested both the e1000e NIC card and the SATA 4 ports card and
> they work fine.

I assume it works with PIO, but does the SATA card use the I/O
space registers, or just memory space?

	Arnd
