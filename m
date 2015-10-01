From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Oct 2015 10:39:56 +0200
Subject: Need information on Microblaze/ARM PCIe
In-Reply-To: <8520D5D51A55D047800579B094147198016900FD@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <loom.20150930T152450-636@post.gmane.org>
 <1564493.rNY8FKFBZT@wuerfel>
 <8520D5D51A55D047800579B094147198016900FD@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <2823526.BaGmYtbVG2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 October 2015 05:32:49 Bharat Kumar Gogada wrote:
> Thanks for the input, so you mean to say we need modify pci-common.c  to
> provide similar functionality that ARM64 provides.

Yes, but that essentially means replacing it with a file that only
provides trivial implementations for
pcibios_fixup_bus(), pcibios_align_resource(), and pcibios_add_device().
I don't think you need any others.

> From the sentence (or putting it under and Kconfig symbol initially) you
> mean to say (putting it under arm Kconfig symbol).

Sorry for being unclear. I meant putting the current implementation
under a new microblaze specific Kconfig symbol so you can use it with
the original host driver implementation as an alternative to the new
new implementation. Once you have migrated to the new code it can be
deleted.

	Arnd
