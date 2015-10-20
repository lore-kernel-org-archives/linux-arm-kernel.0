From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue, 20 Oct 2015 03:27:15 +0000
Subject: Using CONFIG_ARM_APPENDED_DTB with multiple device trees
Message-ID: <fce90e91fe3c452b80bcd2113f267003@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We currently have several boards based around the 88f6281 (kirkwood) ARM 
CPU.

The boards all share a kernel image (currently 3.16 based but we're in 
the process of moving to 4.3). We use the machine id (and some other 
eeprom type information) to distinguish the boards.

We'd like to move to a device tree based model but we're restricted in 
that updating the bootloaders to a DT-aware u-boot is impractical. 
CONFIG_ARM_APPENDED_DTB allows us to append a device tree but we still 
need to account for the differences between the boards.

Is it possible to append several device trees and have the correct one 
selected based on mach-id? One alternative would be to have a lowest 
common denominator device tree and platform_data style initializations 
for the rest (which would kind of defeat the purpose of having a device 
tree). Or we could have a superset device tree with the nodes disabled 
and install fixups to enable them based on mach-id. Has anyone faced a 
similar situation?

Thanks,
Chris
