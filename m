From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 16:42:23 -0400
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <1380572483.31472.51.camel@sakura.staff.proxad.net>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com>
 <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
 <1380572483.31472.51.camel@sakura.staff.proxad.net>
Message-ID: <20130930204223.GJ31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 10:21:23PM +0200, Maxime Bizon wrote:
> On Tue, 2013-09-24 at 13:19 +0100, Russell King - ARM Linux wrote:
> > Having kbuild wrap the zImage + DTB up into a uImage goes directly
> > against this goal, because it turns the produced kernel into something
> > which is specific to a single target.  It's much worse than what we
> > had before we went to DT, because with this it can only be used on a
> > _single_ target, whereas prior to DT we could boot a single kernel
> > on a variety of compatible targets.
> 
> What would you think of a patch allowing multiple DTB selected using
> ATAG number ?

Nicolas Pitre already suggested an impedance matcher that keeps this
kind of hacky code out of the kernel, and allows users to do exactly
that.  Daniel Mack took him up on the suggestion and implemented it [1].
I contributed some patches to make it work generically.

Please take a look.  Currently, the only outstanding blocker is to convert
atags to fdt.  Patches welcome as I'm currently occupied with other
things. ;-)

hth,

Jason.

[1] https://github.com/zonque/pxa-impedance-matcher
