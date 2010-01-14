From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jan 2010 09:15:56 +0000
Subject: [PATCH] ARM: Fix uncompress code compile for different
	definesof static(void)
In-Reply-To: <20100114082952.GA657@pengutronix.de>
References: <20100113021939.GE2986@atomide.com>
	<20100113084937.GA19352@pengutronix.de>
	<BD79186B4FD85F4B8E60E381CAEE190902089C39@mi8nycmail19.Mi8.com>
	<20100114082952.GA657@pengutronix.de>
Message-ID: <20100114091556.GB19197@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 09:29:52AM +0100, Uwe Kleine-K?nig wrote:
> I think the cleanest solution would be to remove -Dstatic=.  I don't
> know the exact reason for it being there.

Thereby breaking the ability to build a relocatable decompressor.

> Russell, maybe these toolchain problems are gone in the meantime?

I don't think it was toolchain problems.  Having the text and data
segments independently relocatable is actually an abuse of the ELF
format - it's not something it directly supports.
