From: jbe@pengutronix.de (=?iso-8859-15?q?J=FCrgen_Beisert?=)
Date: Fri, 6 Dec 2013 10:32:31 +0100
Subject: i.MX6/PCIe and MSI interrupts
Message-ID: <201312061032.31944.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

is anybody out there who has MSI interrupts successfully working on i.MX6? I 
tried with my i.MX6 and a Gbit network card but without success. In legacy 
interrupt mode it works.
I'm using various patches here from the list and the PCIe itself works. The 
designware driver is prepared for MSI interrupts and the Exynos driver makes 
use of it.
I added the same glue code to the i.MX6 driver but I can't get the INTD 
interrupt to fire when MSI arrives (while the INTA fires in legacy interrupt 
mode). Some idea what needs to be done in the i.MX6 to get MSI working? The 
Exynos driver additionally changes some bits in its chipset beside the PCIe 
unit to enable the MSI interrupt to its CPU. Are there some 'hidden' bits in 
the i.MX6 as well?

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
