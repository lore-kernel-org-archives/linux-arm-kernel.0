From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 09 Apr 2013 13:01:56 +0100
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <CACRpkda9Nue-8Esp3cJ6u2-MJ2ZL8hH-2BnrhHwWv4GZP2VR5w@mail.gmail.com>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <4B3FD561-84FC-40CD-B747-13851692D673@gmail.com>
 <521DFDFC-7E9E-47EA-ACDA-C91BBDC8454E@gmail.com>
 <201304072323.42173.arnd@arndb.de>
 <CACRpkda9Nue-8Esp3cJ6u2-MJ2ZL8hH-2BnrhHwWv4GZP2VR5w@mail.gmail.com>
Message-ID: <1365508916.24306.17.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-09 at 12:23 +0100, Linus Walleij wrote:
> On Sun, Apr 7, 2013 at 11:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 07 April 2013, Daniel Tang wrote:
> >> Here's an updated patch that enables support for the LCD.
> >>
> >> I looked into drivers/video/of_display_timing.c but it doesn't have the fields to describe the
> >> PL11x specific options needed in struct clcd_panel. At the moment, it is implemented by
> >> hardcoding the values in the kernel and using the device tree to select the correct
> >> configuration.
> >>
> >> Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
> >
> > I think you should for now keep the clcd stuff in a separate file,
> > since it will be replaced with DT logic eventually. For now, the
> > auxdata method is ok, but Linus Walleij might already have thought
> > about how pl111 should get all its data from the device tree.
> 
> So last thing I heard there was *someone* at ARM working on
> device tree support for the PL110/PL111, so I just don't know who
> this was.
> 
> But I bet Pawel knows, because it will be needed for all
> ARM reference designs.

So I have PL111 code almost working here, however today it depends on
not-yet-upstream (to my knowledge) generic/common panel/display
framework. If I'm not disturbed again I may get something done this
week, hopefully removing the dependency.

There's also some work going on on a DRM driver for PL111, but I can't
promise any dates.

As to PL110 I have no idea how different is it from the PL111, but
nothing is happening about it anyway.

Pawe?
