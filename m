From: balbi@ti.com (Felipe Balbi)
Date: Thu, 3 Jul 2014 10:52:40 -0500
Subject: [RFC PATCH] tty: serial: Add 8250-core based omap driver
In-Reply-To: <20140703154425.GC23309@earth.universe>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home>
 <20140702190944.GA567@drone.musicnaut.iki.fi>
 <CAOCHtYgxMeA+Arfe40XeFDEKuCJ8qo1RqNR0hYBGr_Wp6sRfdA@mail.gmail.com>
 <20140703073411.GX28884@atomide.com>
 <20140703132509.GA5814@saruman.home>
 <CAOCHtYi0JwRO12gHa+KFGH1k7pPk4TL40igwhzRRxutw-tqf6A@mail.gmail.com>
 <20140703140736.GF5814@saruman.home>
 <20140703154425.GC23309@earth.universe>
Message-ID: <20140703155240.GU5814@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 05:44:26PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jul 03, 2014 at 09:07:36AM -0500, Felipe Balbi wrote:
> > On Thu, Jul 03, 2014 at 08:34:44AM -0500, Robert Nelson wrote:
> > > On Thu, Jul 3, 2014 at 8:25 AM, Felipe Balbi <balbi@ti.com> wrote:
> > > > On Thu, Jul 03, 2014 at 12:34:11AM -0700, Tony Lindgren wrote:
> > > >> * Robert Nelson <robertcnelson@gmail.com> [140702 12:27]:
> > > >> > On Wed, Jul 2, 2014 at 2:09 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > > >> > > Hi,
> > > >> > >
> > > >> > > On Wed, Jul 02, 2014 at 11:09:32AM -0500, Felipe Balbi wrote:
> > > >> > >> > It has been only tested as console UART.
> > > >> > >> > The tty name is ttyS based instead of ttyO. How big is the pain here,
> > > >> > >> > what could be the easiest way to provide compatibility?
> > > >> > >>
> > > >> > >> have been considering that myself for months. You could pass an optional
> > > >> > >> argument to serial8250_register_8250_port() but that only solves part of
> > > >> > >> the problem :-(
> > > >>
> > > >> Some kind of compability layer sure would be nice.
> > > >>
> > > >> > > When ttyS -> ttyO change was done on OMAP, compatibility was not an issue.
> > > >> > > Why should we care about it now?
> > > >> >
> > > >> > It would be a good opportunity to force everyone to update their bootloader. ;)
> > > >> >
> > > >> > Besides the BeagleBoard forum is quiet now, no one is complaining
> > > >> > about that old (ttyS -> ttyO) transition anymore..
> > > >>
> > > >> How about a Kconfig option to provide ttyO by default? The not even
> > > >> do that if kernel has cmdline option nottyomap.
> > > >
> > > > what about single zImage ? I don't want to use ttyO on my
> > > > Allwinner/Exynos/Snapdragon/whatever SoC just because OMAP is in the
> > > > same image ;-)
> > > 
> > > What if we just kept it simple, leave the ttyO driver enabled and add
> > > a warning (pr_info) that it's deprecated.  It's not like it's broken,
> > > it just won't get later features or devices support added.
> > 
> > Fine by me, I'd switch to 8250 as soon as it's merged though :-) would
> > be nice to get an example DTS change just so I can start testing on the
> > boards I have around.
> 
> DT is supposed to contain information about the hardware, so it
> should stay the same? I think there is no non-hackish way to decide

compatible would change, at a minimum.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/41a0687f/attachment.sig>
