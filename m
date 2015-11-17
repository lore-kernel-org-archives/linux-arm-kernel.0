From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Nov 2015 17:25:30 +0100
Subject: [PATCH 0/9] rtc-2123: access the clock offset feature
In-Reply-To: <2107368.j5bIbb5cBF@jclayton-pc>
References: <cover.1446587705.git.stillcompiling@gmail.com>
 <2107368.j5bIbb5cBF@jclayton-pc>
Message-ID: <20151117162530.GC14677@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/2015 at 07:30:48 -0800, Joshua Clayton wrote :
> On Wednesday, November 04, 2015 07:36:31 AM Joshua Clayton wrote:
> > Greetings,
> > This series was prompted by a need to adjust the clock rate of the rtc
> > The existing code performs a soft reset during probe, which wipes out
> > several registers including the offset register, which performs adjustments
> > to the clock rate.
> > 
> > The first several patches are cleanup, with patch 5 and 6 avoiding the reset,
> > and patch 9 adding a nice sysfs interface to the clock offset.
> > 
> > I know that this is not the only rtc to provide a programmable clock offset
> > I wonder if this interface would make a good addition to the rtc api?
> > 
> > The rtc chips I have seen list their clock adjustments in parts per million.
> > I went with parts per billion, since the ppm listed was listed with a
> > fractional component.
> > 
> > Joshua Clayton (9):
> >   rtc-pcf2123: Document all registers and useful bits
> >   rtc-pcf2123: clean up reads from the chip
> >   rtc-pcf2123: clean up writes to the rtc chip
> >   rtc-pcf2123: replace magic numbers with defines
> >   rtc-pcf2123: put the chip reset into a function
> >   rtc-pcf2123: avoid resetting the clock if possible
> >   rtc-pcf2123: allow sysfs to accept hexidecimal
> >   rtc-pcf2123: use sysfs groups
> >   rtc-pcf2123: adjust the clock rate via sysfs
> > 
> >  drivers/rtc/rtc-pcf2123.c | 391 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 257 insertions(+), 134 deletions(-)
> > 
> > 
> Any comments on this series?
> I realize now that I submitted it during the merge window, so it may have been overlooked.
> 

I will have a few comments but I didn't review everything thoroughly
yet. As you mentioned, you submitted during the merge window so this was
not going to be in 4.4 anyway.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
