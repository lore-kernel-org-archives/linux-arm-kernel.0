From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 11:56:55 +0000
Subject: [PATCH 2/3] ARM: ux500: Turn on the 'heartbeat' LED trigger
In-Reply-To: <20130109111209.GH3931@n2100.arm.linux.org.uk>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
 <20130109110840.GD31678@gmail.com>
 <20130109111209.GH3931@n2100.arm.linux.org.uk>
Message-ID: <201301091156.55644.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Russell King - ARM Linux wrote:
> > If so, that's wrong, as it covers many more boards than just Snowball
> > and this is only applicable on the Snowball board. So how else can
> > I enable this feature?
> 
> And why is it wrong to enable an optional feature in a defconfig which some
> boards using that defconfig may want?
> 
> It's less wrong than forcing user selectable options to be mandatorily
> selected.

Right. The change I suggested fixes the build errors but doesn't actually
make the intended behavior correct. Just using a configuration file is the
right solution here.

It may be a good use case for the "suggest" Kconfig statement I brought
up before: Rather than having snowball hard enable the LEDS subsystem,
it could 'suggest LEDS_CORE' in order to change the default for that
option, but still let users disable it if they want to.

	Arnd
