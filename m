From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 11:22:37 +0100
Subject: [PATCH 1/3] ARM: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <1278429668-4564-1-git-send-email-triad@df.lth.se>
References: <1278429668-4564-1-git-send-email-triad@df.lth.se>
Message-ID: <20100715102237.GI26212@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 06, 2010 at 05:21:08PM +0200, Linus Walleij wrote:
> This adds a driver for the character LCD found on the ARM Versatile
> and RealView Platform Baseboards. It doesn't do very much more than
> display the text "ARM Linux" on the first line and the linux banner
> on the second line, but that's still useful.

I think the only questionable thing on this is the location of the
driver.  As we now have plat-versatile for the shared stuff between
integrator, verastile, realview and versatile express, maybe it'd
make more sense to be in plat-versatile?

Or maybe drivers/platform/arm/ (to avoid Linus' complaint about
drivers under arch/ ?)
