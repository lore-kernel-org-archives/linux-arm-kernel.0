From: matthew_minter@xyratex.com (Matthew Minter)
Date: Fri, 4 Oct 2013 14:14:34 +0100
Subject: Arm PCIe hotplugging
Message-ID: <CAFJTrDs=fovP8nWVvH=-a9d_OTbmgQkMLPVeKAc4x6phsuZw9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

I have been doing some work with an Armada XP board (DB-MV784MP-GP)
with PCIe support, along with using a PEX 8614 (AA) PCIe switch. The
switch in question is said to have hot plug support with the PCIe
downstream slots.

However using both the generic "pcieport" and the proprietary kernel
module used by PLX (this took some work to run on an ARM board and is
very buggy on the platform buggy so the generic in tree drivers are
preferable) the /sys/bus/pci/slots/ directory is always empty and
/sys/bus/pci/rescan seems to do nothing.

Looking closer it seems that in the ARM kernel the PCI hotplug code is
all disabled. Am I just out of luck and should wait until there is a
new driver for the PCI switch's hot plug controller and a general hot
plug framework for ARM or is there some kind of work around?

Best regards,
Matthew

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
