From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Nov 2013 02:01:50 +0000
Subject: STOP THE MADNESS
In-Reply-To: <20131126163031.GC16735@n2100.arm.linux.org.uk>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
Message-ID: <20131129020149.GU16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 04:30:32PM +0000, Russell King - ARM Linux wrote:
> Versatile PB926 is currently broken in mainline because of this, and it's
> damn obvious that people are just churning out changes to "update" drivers
> without testing them at all.

So... EBSA285... where would people like me to start with that.
VGA... broken.  LEDs... broken.  Several other issues as well (eg,
my tightening of the vectors page seems to have broken all low-vectors
platforms.)

IDE... both IT821x and CY82C693 broken - CY82C693 is beyond recovery
given the state of core IDE code - it requires a rewrite to get it
working again due to broken assumptions concerning this host controller
by core code.  IT821x gets quickly kicked out of BMDMA mode and then
sees the occasional PATA _protocol_ error.  Frankly I wouldn't trust
drivers/ide at all given observed behaviour; I'm not going to even
bother trying to debug it.

libata... better for IT821x.
