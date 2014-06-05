From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jun 2014 19:32:23 +0100
Subject: keystone breakage
Message-ID: <20140605183223.GF23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's worth pointing out that with Laura's removal of meminfo, keystone
is now broken - I see that despite Laura's patches being on LAKML for
a while, this fact has been ignored, and now that Keystone support
for the LPAE mappings has been merged, Keystone now breaks:

arch/arm/mach-keystone/keystone.c: In function 'keystone_init_meminfo':
arch/arm/mach-keystone/keystone.c:71:31: error: 'meminfo' undeclared (first use in this function)

I guess this is something that will have to be fixed later.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
