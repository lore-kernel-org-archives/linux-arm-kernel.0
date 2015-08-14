From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 14 Aug 2015 16:05:55 +0200
Subject: commit a71b092 "ARM: Convert handle_IRQ to use __handle_domain_irq"
 breaks DNS-323
Message-ID: <55CDF5C3.7080204@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this commit:
 > commit a71b092a9c68685a270ebdde7b5986ba8787e575
 > Author: Marc Zyngier <marc.zyngier@arm.com>
 > Date:   Tue Aug 26 11:03:18 2014 +0100
 >
 >     ARM: Convert handle_IRQ to use __handle_domain_irq
[...]
causes the kernel not to boot anymore on my DNS-323.
Soc: MV88F5182 Rev 2
CPU: ARM926 (Rev 0) running @ 500Mhz
CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
Orion ID: MV88F5182-A2. TCLK=166666667.
DNS-323: Identified HW revision B1

Boot stops after "Uncompressing Linux... done, booting the kernel."
Reverting the commit works fine for me.
Tested 4.1.2 and 4.2.0-rc6 with orion5x_defconfig.

   Detlef
