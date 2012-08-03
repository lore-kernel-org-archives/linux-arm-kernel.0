From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  3 Aug 2012 15:10:26 +0200
Subject: arm: mvebu: Add basic address decoding support for Marvell 370/XP
Message-ID: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew, Jason, Gr?gory,

Here is a small patch set that introduces basic support for address
decoding on Armada 370 and Armada XP. The aim of this basic support is
essentially to be able to configure a window to remap the BootROM,
which is needed to startup the secondary CPUs for the SMP support.

As we had discussed already, the address decoding configuration is not
described in the Device Tree, it is for now hardcoded on a per-SoC
basis. We might later discuss how to extend this to the Device Tree.

This patch set has four patches:

 (*) First patch introducing PLAT_ORION_LEGACY, which allows the
     Marvell 370/XP platforms to be part of PLAT_ORION, and therefore
     re-use the existing address decoding code.

 (*) Second patch making a small change to an address decoding
     structure so that we can define at runtime the virtual address of
     the configuration registers. This is needed as on Armada 370/XP
     the address decoding "controller" is declared in the Device Tree.

 (*) Third patch adding the 370/XP address decoding code itself. For
     now, it only maps the BootROM on Armada XP.

 (*) Fourth path adding the necessary DT code to instantiate the
     address decoding "controller".

Thanks,

Thomas Petazzoni
