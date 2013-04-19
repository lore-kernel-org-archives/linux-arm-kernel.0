From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 22:11:13 +0200
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130419194323.GP10155@atomide.com>
References: <5170B4C6.1030300@gmail.com> <517173C0.6010902@ti.com>
 <20130419194323.GP10155@atomide.com>
Message-ID: <201304192211.13356.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Tony Lindgren wrote:
> This might happen when no SoC selected. There was a patch posted
> by Arnd to always select 2420 if nothing else is selected as it's the
> most minimal one. But Russell did not like that, so probably the way
> to fix that would be to have bool OMAP_SOC and if not selected, don't
> even try to build anything. I'll take a look at that.

My patch was actually just necessary to avoid building a kernel with
no platforms selected at all, but we now have a patch that makes that
a working option.

I think all the bugs that Rob reported can be fixed individually.

Note that the "dss-common.c" part there might be a Red Herring, the symbols
are likely to be used from somewhere else than that file.

	Arnd
