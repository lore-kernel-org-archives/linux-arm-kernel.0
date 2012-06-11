From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jun 2012 14:57:00 +0000
Subject: [PATCH 11/14] ARM: LPC32xx: DTS adjustment for using pl18x
 primecell
In-Reply-To: <4FD60096.7050603@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <201206111414.14264.arnd@arndb.de> <4FD60096.7050603@antcom.de>
Message-ID: <201206111457.00845.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Roland Stigge wrote:
> Thanks for the note!
> 
> Funnily, I always did it this way. Looks like initially, I copied from
> somewhere else (wrongly). Indeed, we have lots of "disable", see also:
> 
> omap3-beagle.dts
> omap4-panda.dts
> omap4-sdp.dts
> tegra20.dtsi
> tegra30.dtsi

Ah, right. Note that the kernel checks only for "ok" and "okay" strings,
anything else is interpreted as "disabled". We should use the correct
string anyway of course.

	Arnd
