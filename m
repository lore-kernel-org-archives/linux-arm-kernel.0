From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Apr 2014 17:27:11 +0200
Subject: mach header files
In-Reply-To: <CAGsJ_4yd4a+Mkb2G2Xx-qT0bks2QBf-=NxipX0es_X9NJfB+4Q@mail.gmail.com>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <4379667.784l7DtcMU@wuerfel>
 <CAGsJ_4yd4a+Mkb2G2Xx-qT0bks2QBf-=NxipX0es_X9NJfB+4Q@mail.gmail.com>
Message-ID: <5541478.Xa9FEPF0YA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 April 2014 21:32:33 Barry Song wrote:
> 2014-04-04 21:24 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> > On Friday 04 April 2014 03:29:54 Grant Likely wrote:
> >> On Fri, Apr 4, 2014 at 1:19 AM, Phil Edworthy <phil.edworthy@renesas.com> wrote:
> >> > Resent, hopefully without the automatic corporate signature appended this time...
> >> >
> >> > I am porting the kernel to a new device, for which I've created a new
> >> > arch/arm/mach-... directory, and I also a clock driver that lives under
> >> > driver/clk. Everything is all working fine, though I am now cleaning up
> >> > the code and have a question about mach specific header files.
> >
> > I'm glad you are asking while you are still in the process of cleaning
> > up your code, because you need to know the rules for new platforms.
> > Basically at this point we expect zero code in arch/arm/mach-* for a new
> > platform. You are absolutely required to have DT based probing and
> > multiplatform support, and the latter also means that there are no
> > mach/*.h header files that are visible to device drivers.
> >
> > We still make the occasional exception for adding code in the mach-*
> > directory, but we are getting pretty close to the state where this
> > is not needed for new platforms, and all the existing uses are for
> > things that can eventually get cleaned up.
> > If you think you need an exception here, please explain what you
> > are doing, and we can see if there is a better way to do that already.
> 
> Arnd, my question is that mach-prima2/common.c has supported prima2,
> atlas6, marco, what if i add an atlas7 support in it?

It's not a new platform, so it is ok as long as you don't add more
code there that can be avoided and you keep cleaning up the code
that is there, as you have been doing so far.

	Arnd
