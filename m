From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jun 2014 12:13:24 +0100
Subject: OMAP SSI build error
Message-ID: <20140606111323.GI23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently spotted this build error (via a randconfig build):

drivers/hsi/controllers/omap_ssi_port.c: In function 'ssi_port_probe':
drivers/hsi/controllers/omap_ssi_port.c:1119:2: error: implicit declaration of function 'ref_module'

Looks like it's missing out on including linux/module.h which provides
the prototype for this function.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
