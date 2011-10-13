From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Oct 2011 16:56:56 +0200
Subject: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
In-Reply-To: <20111013143857.GH5193@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<20111013121745.GU21648@n2100.arm.linux.org.uk>
	<20111013143857.GH5193@opensource.wolfsonmicro.com>
Message-ID: <201110131656.56519.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 October 2011, Mark Brown wrote:
> > So.  No new drivers in arch/arm.  And I'm going to be saying no to any
> > new per-driver data structures in mach/*.h for stuff which should be
> > generic which haven't been justified for why they need to be different
> > from someone elses.
> 
> The driver specific data structures should probably just be moving to
> include/linux/platform_data which is the approved location for that sort
> of thing.

Note that we also need someone to watch over that and say no to silly
platform_data definitions being put in there, e.g. using wildly different
ways of expressing the same things in almost-identical drivers, or
using function pointers where a simple data structure is enough.

	Arnd
