From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 16:40:05 +0200
Subject: [RFC PATCH 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <20110908113354.GC2070@arm.com>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
	<20110908090122.GC14953@n2100.arm.linux.org.uk>
	<20110908113354.GC2070@arm.com>
Message-ID: <201109081640.06094.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011, Dave Martin wrote:
> On Thu, Sep 08, 2011 at 10:01:22AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Sep 08, 2011 at 09:58:00AM +0100, Dave Martin wrote:
> > > I take pj4 and older platforms can never be built in the same kernel?
> > > Otherwise, this approach is totally broken anyway-- we'll generate code
> > > which won't run on some of the kernel's supported platforms.
> > 
> > We have a well enforced split between ARMv5 and older CPUs, and ARMv6
> > and later CPUs.
> 
> Good point -- OK, I guess we don't need to worry about that scenario.

I actually have a patch that enforces this rule in Kconfig for pxa.
Right now, you can happily select any combination of boards, which
blows up very early during the build phase if you combine v5 and v7.

	Arnd
