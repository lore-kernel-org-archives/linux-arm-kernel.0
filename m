From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 21 Jul 2013 14:00:21 +0200
Subject: [PATCH 1/5] ARM: bcm4760: Add platform infrastructure
In-Reply-To: <d40f0756-7ba0-4416-9576-63470274be1b@email.android.com>
References: <20130721002320.730568671@gmail.com>
 <201307211009.31789.arnd@arndb.de>
 <d40f0756-7ba0-4416-9576-63470274be1b@email.android.com>
Message-ID: <201307211400.21295.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 July 2013, Domenico Andreoli wrote:
> >bonus points if you use soc_device_register();
> >
> >What is the system_rev variable actually used for?
> 
> I use it to show something sensible in /proc/cpuinfo, to report
> whether the soc is  a 4760 or 4761 and the silicon revision.
> 
> If the proper way to deal with this has so much boilerplate as
> you say, I think I'll drop it altogether. I'd like to print the info
> somewhere in the bootlog anyway.
> 
> btw this could well be one of the accesses requiring the io
> mapping above.

If it's just for informational purposes, soc_device_register() sounds like
the correct place to put that information, you can register a couple
of strings there that get put into sysfs at a known location for the
SoC, and keeps the cpuinfo for the actual CPU core.

	Arnd
