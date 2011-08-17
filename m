From: joravec@drewtech.com (Joey Oravec)
Date: Wed, 17 Aug 2011 17:34:13 -0400
Subject: plat-orion needs to enable PCIe ports for mv78xx0
Message-ID: <4E4C33D5.3050508@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orion maintainers,

On the Discovery series chips (mv78xx0), the CPU control and status 
register at offset 0x20104 contains bits to enable / disable PCI express 
port0 and port1. Both ports default to disabled.

It looks the PCIe driver and existing board setup files do not set this 
bit; any boards that use PCIe and are working today might assume that 
the bootloader has already set the bit to enable these ports. I couldn't 
find anything in Marvell's documentation about timing, but the bits need 
to be set a long time before you touch any of the PCIe port registers.

-joey
