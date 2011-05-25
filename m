From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 May 2011 13:45:19 +0200
Subject: Self modifying code in ARM 11 architectures
In-Reply-To: <BANLkTinrj-dkJShzTQuhYSOWkK4QSEnQgQ@mail.gmail.com>
References: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
	<BANLkTimyju7eEgtCpb_U6s8LNHk-_FGK4Q@mail.gmail.com>
	<BANLkTinrj-dkJShzTQuhYSOWkK4QSEnQgQ@mail.gmail.com>
Message-ID: <20110525114519.GC12200@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 25, 2011 at 01:18:37PM +0530, Vimal Singh wrote:
> CC'ing correct ARM mailing list.
> 
> On Tue, May 24, 2011 at 3:48 PM, Ashok Babu <ashok3d@gmail.com> wrote:
> > Hi All,
> >
> > I am no success in booting up the ARM1176 processor with the
> > linux-2.6.32 kernel.
> > While googling about the ARM?Harvard?architecture, I came to know that
> > we have to flush/invalidate the D-Cache and I-Cache
> > when using the self modifying codes.
> >
> > So here my questions/doubts :
> > 1) Is'nt it the kernel itself is self modifying code with lots of
> > function pointers ?
Code that uses function pointer isn't usually called self-modifying.

> > ? ? If yes, how is synchronization b/w d-cache and i-cache handled in
> > the kernel ?
> > 2) Can this be the reason for the kernel not booting for me ?
> > ? ? Because If i disable the I-Cache in the config, then the kernel
> > boots up without any issues.
> > Any pointers on this will be of great help.
Does your bootloader correctly disables the I-Cache before giving control
to Linux?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
