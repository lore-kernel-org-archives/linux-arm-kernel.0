From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 21:54:45 +0100
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded - 2.6.35-rc5
In-Reply-To: <miltonm-arm-parport-2@bga.com>
References: <4C408BEF.1060302@canonical.com> <4C3C72C6.4000005@canonical.com>
	<20100715130214.4c9303b2.akpm@linux-foundation.org>
	<20100715200618.GA6773@n2100.arm.linux.org.uk>
	<4C40218A.4090806@canonical.com>
	<20100716092018.GB16995@n2100.arm.linux.org.uk>
	<miltonm-arm-parport-1@bga.com> <miltonm-arm-parport-2@bga.com>
Message-ID: <20100716205445.GA28064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 02:38:38PM -0500, Milton Miller wrote:
> I just looked at the 8250 code and it abuses the platform device model.
> Instead of a platform device for each port, it has multiple port
> descriptions set via platform_data in one or a a few device instances.

I don't agree with that assessment (but then I'm the one who created
that.)  Having one platform device for each port would have been
absurd given the number of ISA addresses that 8250 ports appear at.

Who'd want 64+ platform devices for serial ports?
