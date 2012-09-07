From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 04:04:44 +0000
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <50495A94.2060904@wwwdotorg.org>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209060904.14903.arnd@arndb.de> <50495A94.2060904@wwwdotorg.org>
Message-ID: <201209070404.45120.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Stephen Warren wrote:
> >> diff --git a/arch/arm/mach-bcm2708/common.c b/arch/arm/mach-bcm2708/common.c
> >
> > I think when this is the only file, we probably want to name this one bcm2708.c,
> > same as the platform.
> 
> This was originally named bcm2708.c downstream, but I renamed it to
> common.c following the example of mach-picoxcell and mach-zynq, which
> IIRC you had pointed out as exemplary platforms. Still, I can rename it
> back if you want.

It's not a big thing either way. Highbank and socfpga are also good examples
and they use the name of the platform.

> >> diff --git a/arch/arm/mach-bcm2708/include/mach/timex.h b/arch/arm/mach-bcm2708/include/mach/timex.h
> > 
> > Very close to not being required any more, so you probably won't need it in 3.7.
> 
> OK. It's required right now though. I assume we should aim to check this
> in for 3.7. Should I rebase this patch on top of whatever change removes
> the need for timex.h? Such a patch doesn't appear to be in linux-next
> right now though.

Let's not worry about it for now, it's easy enough to remove later.

	Arnd
