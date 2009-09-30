From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Wed, 30 Sep 2009 04:12:22 -0400 (EDT)
Subject: apparently, numerous unused header files under arch/arm
Message-ID: <alpine.LFD.2.00.0909300405080.14643@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  as part of a new tree scan with one of my scripts, i located what
*appear* to be numerous header files under arch/arm that no one seems
to be including.  the first few in that list, accompanied by a full
tree scan of any use of the filename:

===== at91_adc.h =====
./arch/arm/mach-at91/include/mach/at91_adc.h
arch/arm/mach-at91/include/mach/at91_adc.h: * arch/arm/mach-at91/include/mach/at91_adc.h
===== at91_spi.h =====
./arch/arm/mach-at91/include/mach/at91_spi.h
arch/arm/mach-at91/include/mach/at91_spi.h: * arch/arm/mach-at91/include/mach/at91_spi.h
===== at91_ssc.h =====
./arch/arm/mach-at91/include/mach/at91_ssc.h
arch/arm/mach-at91/include/mach/at91_ssc.h: * arch/arm/mach-at91/include/mach/at91_ssc.h
===== aux_reg.h =====
./arch/arm/mach-l7200/include/mach/aux_reg.h
arch/arm/mach-l7200/include/mach/aux_reg.h: * arch/arm/mach-l7200/include/mach/aux_reg.h
===== bast-pmu.h =====
./arch/arm/mach-s3c2410/include/mach/bast-pmu.h
arch/arm/mach-s3c2410/include/mach/bast-pmu.h:/* arch/arm/mach-s3c2410/include/mach/bast-pmu.h
===== board-mx35pdk.h =====
./arch/arm/plat-mxc/include/mach/board-mx35pdk.h
===== board-pcm043.h =====
./arch/arm/plat-mxc/include/mach/board-pcm043.h
===== board-voiceblue.h =====
./arch/arm/plat-omap/include/mach/board-voiceblue.h

... etc etc ...

  so, for example, nothing seems to include that last listed
board-voiceblue.h header, not even the source file that's the obvious
candidate:  arch/arm/mach-omap1/board-voiceblue.c.  and there's lots
more of those.  (they're listed in alphabetical order, and i was only
up to the "b"s, but it's almost certain that i'll have some false
positives in there somewhere, perhaps because of Makefile-based
includes.)

  is there any interest in my posting that arm-specific list somewhere
and people can peruse it and decide what, if anything, they want to do
with it?

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
