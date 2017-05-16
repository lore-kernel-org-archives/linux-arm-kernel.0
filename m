From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 10:50:27 +0100
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <CAPv3WKdULNEDcqJ=qsBEAApaJNiyJXAw6ZG=Ejd8TxE6LJkYLw@mail.gmail.com>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
 <20170515232825.GX22219@n2100.armlinux.org.uk>
 <CAPv3WKdULNEDcqJ=qsBEAApaJNiyJXAw6ZG=Ejd8TxE6LJkYLw@mail.gmail.com>
Message-ID: <20170516095027.GZ22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 11:27:19AM +0200, Marcin Wojtas wrote:
> I do not intend to interfere your work at all. I took a look on your
> branch, and my patch does not seem to be really colliding with it.

I can't see how you can say that when the branch contains support for
SDHCI and ethernet.  It obviously will collide, since it conflicts with
the changes I have.

> The board is starting to get really popular and a lot has been happening
> around it recently - missing bits like 'chosen' node or the interfaces
> is pretty annoying.

Given that features like SDHCI and basic ethernet support have only just
been merged during the merge window, how about giving those who are
supporting the platform some time to organise their trees and get patches
out there, rather than cutting across those who have put considerable
effort into the platform already, or working with those who have.

The whole Armada 8k support is all very new, and there's still lots of
fundamental bits that are missing - pinmux and gpio are the two biggest
ones.

I've already put effort into cleaning up the mvebu pinmux code (already
merged) so that we can cleanly merge the pinmux support, but both of
these are a sticking point with free-electrons - they have a view on
how it should be represented in DT which does not fit with the current
orion-gpio usage, nor with the "system controller" being in drivers/clk.

The code which I have in my tree is correct for the Armada 8k hardware
(which has some weirdness about which gpios on each CP110 appear to the
external world - some are used for inter-CP110 communication and must
not be exposed) so any additional work should be based on the code in
my tree.

I have no solution for the sticking point at present, and this is an
area that's worth additional effort to resolve.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
