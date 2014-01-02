From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jan 2014 17:26:25 +0000
Subject: [BUG] More select madness - keystone
Message-ID: <20140102172625.GC7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

warning: (ARCH_KEYSTONE && SPI_DAVINCI) selects TI_EDMA which has unmet direct dependencies (DMADEVICES && (ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE))

This results in the EDMA engine code not being built.  Yet another
example of why improper use of the "select" statement is bad news
and leads to broken configurations.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
