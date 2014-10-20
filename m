From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 19:32:48 +0200
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <54452B15.50502@i2se.com>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <3434817.dk7dLDFrcN@wuerfel> <54452B15.50502@i2se.com>
Message-ID: <2122231.Xv3WK03QJQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 October 2014 17:32:37 Stefan Wahren wrote:
> 
> Am 20.10.2014 um 16:44 schrieb Arnd Bergmann:
> > On Saturday 18 October 2014 10:32:51 Stefan Wahren wrote:
> >> This patch brings readonly support for the On Chip OTP cells in the i.MX23
> >> and i.MX28 processor. The driver uses files (one for each cell) in sysfs
> >> as interface.
> >>
> >> ...
> > I think this needs to be an MTD driver, not a "misc" driver, and it
> > should use the proper MTD interfaces instead of introducing an
> > incompatible set of interfaces.
> >
> >       Arnd
> 
> phew that sounds like a lot of work and much complexity.
> 
> Am i right, that i should drop the sysfs interface?
> 
> Does MTD drivers have a readonly text (non binary) user interface?

I haven't looked at the MTD OTP interface in detail, but most
of the other SoCs seem to use it.

	Arnd
