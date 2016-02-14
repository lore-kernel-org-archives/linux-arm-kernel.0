From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Feb 2016 20:07:55 +0000
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160214195501.GA12289@pengutronix.de>
References: <20160214165010.GA3189@roeck-us.net>
 <20160214195501.GA12289@pengutronix.de>
Message-ID: <20160214200755.GB10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 14, 2016 at 08:55:01PM +0100, Uwe Kleine-K?nig wrote:
> So the unexpected abnormality here is that even though this device is
> instantiated by dt, the driver doesn't provide any compatibles.
> Either my expectation is wrong, then 67d02a1bbb33455 should be reverted

Your expectation is wrong.  AMBA primecell devices have hardware IDs
and are matched to their drivers by those IDs.  Just like PCI.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
