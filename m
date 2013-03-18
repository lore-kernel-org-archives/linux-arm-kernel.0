From: pavel@denx.de (Pavel Machek)
Date: Mon, 18 Mar 2013 17:36:53 +0100
Subject: [RFC] Kbuild support for ARM FIT images
In-Reply-To: <20130222160044.GA16357@quad.lixom.net>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130222160044.GA16357@quad.lixom.net>
Message-ID: <20130318163648.GA3722@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2013-02-22 08:00:44, Olof Johansson wrote:
> On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> > Any comments on this approach? Is it better to merge mkfitsrc.sh with
> > mkuboot.sh?
> 
> I know this was discussed quite extensively yesterday, but here is my take on
> it:
> 
> Given the recent complications from multiplatform, we really saw a strong
> reason to _not_ do the final boot wrapping in the kernel build system.
> Produce the zImage and the DTB files, and have a surrounding script that
> bundles the two in a format that your particular device needs.
> 
> Most distros have scripts to handle the "make install" step of a kernel build.
> That's where this belongs, not in the actual build step.

Not sure I agree here:

1) zImage was designed to boot from floppy, without any kind of
bootloader on i386

2) There are no distributions on many embedded systems. And no good
place where to store the scripts.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
