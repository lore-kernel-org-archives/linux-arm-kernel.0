From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 16 Feb 2012 15:25:10 +0100
Subject: RFC: rename CONFIG_ARM_AMBA to CONFIG_AMBA
Message-ID: <20120216142510.GA6297@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

I'm working on a I/O Hub which is a PCIe to AMBA bridge, filled with
standard AMBA devices. Thus, we have a number of AMBA peripherals
exported to the PC world (in theory not only the PC, actually).

The code I got from the vendor is replicating a number of amba source
files to hide their amba nature and show up as PCI.  I think I'd
rather add a small PCI wrapper that instantiates an AMBA device,
without code replication or disgusting #include "driver-amba.c" from
within driver-pci.c .  To do that I'd "select ARM_AMBA" in my
stanza of arch/x86/Kconfig .

But since I expect my case to become common pretty soon, as a lot of
stuff is currently under AMBA, and several bridges to AMBA might
apprear one day or the next (think FPGA-driven PCI boards, for
example).

Thus, I'd like to submit a renaming patch, to rename CONFIG_ARM_AMBA
to CONFIG_AMBA or CONFIG_BUS_AMBA (I prefer the former, using the
scheme that is in place for USB, PCI and all the others).

If the idea makes sense, I can submit patches. Since several
subsystems are involved, I'd "select ARM_AMBA" in the new config
option, until all subsystems are converted to the new name, possibly
giving a grace period for out-of-tree drivers to adapt as well.

Any feedback is welcome. Meanwhile, I'm working on PL011 uart using
CONFIG_ARM_AMBA.

thanks
/alessandro
