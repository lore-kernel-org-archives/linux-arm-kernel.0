From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Mar 2012 14:34:34 +0000
Subject: [GIT PULL v3] ARM: kirkwood: fdt: convert kirkwood init funcs to
 fdt
In-Reply-To: <20120305133242.GD5050@titan.lakedaemon.net>
References: <20120305034113.GB5050@titan.lakedaemon.net>
 <20120305133242.GD5050@titan.lakedaemon.net>
Message-ID: <201203051434.35132.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 March 2012, Jason wrote:
> This is still bugging me.  If, say, orion_wdt.c is common to all of
> plat-orion/ shouldn't it be in an 'orion.dtsi'?  With compatible =
> "marvell,orion-wdt"?  Then, if hypothetically, kirkwood used the same
> driver but had a small tweak, then kirkwood.dtsi would have
> "marvell,kirkwood-wdt"?  Which would let the driver know that it needed
> to apply the tweak because it was kirkwood.

Some drivers are common to all orion, but others are only used in some
out of {orion5k,kirkwood,mv78xx0,dove}. You could of course have
an orion.dtsi that is included in kirkwood.dtsi.

BTW, I just realized that the patches that Haojian Zhuang sent for
pxa/mmp are using mrvl instead of marvell, and you should definitely
be using the same identifier both both. By convention we use the
stock ticker symbol as a unique identifier, which would be mrvl here.

> In this scenario, since kirkwood and dreamplug currently need no
> modifications to the default wdt driver, they would just inherit
> orion.dtsi's "marvell,orion-wdt", right?

I would still list both, so we are future-proof in case we need
to modify the driver in the future but don't want to modify
the device tree.

> On the driver side, since it currently has no subarch or board specific
> tweaks, then it is only good for the generic case,
> "marvell,orion-wdt", and thus should only match it for now.

Yes.

> If the above is correct, then I should create orion.dtsi, which is
> included by kirkwood.dtsi.  orion.dtsi should hold "marvell,orion-wdt"
> and "marvell,orion-rtc".  The corresponding drivers should only match
> those generic strings, since there are no specific tweaks.
> 
> I hate to keep kicking this horse, but I want to make sure I grok it.

Sounds right to me.

	Arnd
