From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Nov 2013 10:46:14 +0000
Subject: STOP THE MADNESS
In-Reply-To: <CACRpkdao9ct-fKaUnrdX=dmN+fyuVgcbWQvc_sZTwp8wGdJ0+A@mail.gmail.com>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
 <20131129020149.GU16735@n2100.arm.linux.org.uk>
 <CACRpkdao9ct-fKaUnrdX=dmN+fyuVgcbWQvc_sZTwp8wGdJ0+A@mail.gmail.com>
Message-ID: <20131129104614.GW16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 11:11:08AM +0100, Linus Walleij wrote:
> On Fri, Nov 29, 2013 at 3:01 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > So... EBSA285... where would people like me to start with that.
> > VGA... broken.  LEDs... broken.  Several other issues as well (eg,
> > my tightening of the vectors page seems to have broken all low-vectors
> > platforms.)
> 
> It seems that the majority of the world's Versatile "users" are
> running the QEMU model of that machine and not really
> testing on anything else. Unsurprisingly the QEMU Versatile
> is overly forgiving when mistreating virtual hardware. Some
> stuff like LEDs I guess are just dummies.

Note that the GPIO bug should show on anything due to the nature of it -
it's probably the debug options which mostly show it.  Making sure you
have spinlock debugging and lockdep enabled.
