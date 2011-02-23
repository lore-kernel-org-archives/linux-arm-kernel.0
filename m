From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 23 Feb 2011 12:38:14 +0100
Subject: I2C support for CE4100, v3
Message-ID: <1298461100-14869-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C core inside CE4100 is very much the same as in PXA25x.
I Cc the ARM folks because patch 2 reorganizes some files so that they
can be accessed from x86.
The I2C device is behind a PCI bus. The PCI probe code simply creates
three platform devices so we don't have much changes to the platform
driver. There is no clock framework on x86 and the peripherals don't
support changing their clocks or to enable/disable them. So I provided
dummy function which keep the driver happy.

History:
v1: Initial post
v2: - ISAR is still touched if not in SLAVE mode except on X86 where it
      is not touched at all.
    - There are no files created in include/asm
    - register defines are in common code
    - the PCI controller now requires a device tree. It is used to obtain
      an id (which is used as device & i2c bus id).
    - the PCI part now uses ARRAY_SIZE(). As it turns out pci_select_bars()
      is not useable.
    - the patch which resetted the chip if the i2c bus was not available
      has been dropped.
v3: - rebased against v2.6.38-rc3, fixed conflicts in ARM tree
    - the dependency on SPI is gone.

Sebastian
