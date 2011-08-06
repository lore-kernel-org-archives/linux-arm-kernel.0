From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 6 Aug 2011 04:47:19 +0100
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from
	device tree
In-Reply-To: <4E3C7D3E.7040502@firmworks.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
	<20110805225845.GC6404@ponder.secretlab.ca>
	<4E3C7D3E.7040502@firmworks.com>
Message-ID: <20110806034718.GA10078@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 01:31:10PM -1000, Mitch Bradley wrote:
> On 8/5/2011 12:58 PM, Grant Likely wrote:

> >We've had this argument before.  There are many use cases where the
> >firmware simply cannot be relied upon to do the right thing.

> I am a firmware engineer who tries very hard to deliver quality
> firmware that does the right thing.  It often seems to me that the
> Linux kernel community's general distrust of firmware is a
> self-fulfilling prophecy.  People often "live down to expectations";
> if Linux expects the firmware to be worthless, worthless is often
> what you get.

> In the PC BIOS world, the quality of BIOSes went up dramatically
> when Microsoft began insisting that the BIOS must meet stringent
> standards, enforced via an exhaustive suite of compatibility tests.

It's not just quality concerns, although obviously that is a serious
issue, it's also a totally different way of designing and building
systems.  A bootloader update will tend to brick the board if it goes
wrong so you want to minimize the amount of code in it, and you're going
to be doing updates to things like pin configuration throughout the
development cycle which often need to be done in lock step with the
drivers using them.  Even if the bootloader works perfectly and is of
excellent quality it's just more effort and risk to put functionality in
there.
