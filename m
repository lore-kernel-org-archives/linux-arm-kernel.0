From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 19 Feb 2016 12:08:23 -0500 (EST)
Subject: [PATCH 1/3] [RESEND] ARM: pass -march=armv7-a when building NEON
 files with clang
In-Reply-To: <3205167.CfekeqRXnt@wuerfel>
References: <1455815113-2562966-1-git-send-email-arnd@arndb.de>
 <1455815113-2562966-2-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181230440.13632@knanqh.ubzr>
 <3205167.CfekeqRXnt@wuerfel>
Message-ID: <alpine.LFD.2.20.1602191205000.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2016, Arnd Bergmann wrote:

> On Thursday 18 February 2016 12:31:35 Nicolas Pitre wrote:
> > On Thu, 18 Feb 2016, Arnd Bergmann wrote:
> > 
> > > clang ignores the -mfpu=neon flag when building with -march=armv6:
> > > 
> > > In file included from lib/raid6/neon1.c:27:
> > > clang/3.8.0/include/arm_neon.h:28:2: error: "NEON support not enabled"
> > > 
> > > There is no real need to build the file with -march=armv6 in a
> > > multi-CPU enabled kernel, as nothing in here will ever get called
> > > on an ARMv6 CPU. Adding -march=armv7 doesn't hurt and can only
> > > improve the code quality.
> > 
> > Is this enough to override a previous -mfpu for gcc?
> 
> I did not see any build failures on gcc with this, so I assume it
> has no effect. I could move the -march=armv7-a in front of
> -mfpu=neon if you think that would be safer though.

I don't know what's safer.  That's why I'm asking.  :-)


Nicolas
