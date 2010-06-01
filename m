From: anand_pratyush@yahoo.co.in (Pratyush Anand)
Date: Tue, 1 Jun 2010 09:28:20 +0530 (IST)
Subject: Support for multiple MSI with ARM platform
Message-ID: <763429.29457.qm@web95102.mail.in2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am using a PCIE device having MSI capability. It sends 4 different MSI vecotrs to host controller. 
The host controller which I am using is based on ARM platform( SPEAr).

Currently, arch_setup_msi_irqs function (which?may be replaced by arch specific code) is not defined
for ARM. So my code used one default definition in driver/pci/msi.c But this code does not support 
multiple MSI.

what would be the best way to do it:

1. add following defines in arch/arm/include/asm/pci.h

#define arch_setup_msi_irqs arch_setup_msi_irqs

and then define this function in arch/arm/mach-xxxx/msi.c
or.

2. add following defines in arch/arm/include/asm/pci.h

#define arch_setup_msi_irqs arch_setup_msi_irqs

and then define this function in?arch/arm/kernel/msi.c.
Now call some mach sepicif function from this routine.

or.
3 any other better solution.

Regards
Pratyush
