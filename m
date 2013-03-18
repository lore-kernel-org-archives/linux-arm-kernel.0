From: trini@ti.com (Tom Rini)
Date: Mon, 18 Mar 2013 14:29:54 -0400
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <20130318163648.GA3722@amd.pavel.ucw.cz>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130222160044.GA16357@quad.lixom.net>
 <20130318163648.GA3722@amd.pavel.ucw.cz>
Message-ID: <20130318182954.GB25919@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 05:36:53PM +0100, Pavel Machek wrote:
> On Fri 2013-02-22 08:00:44, Olof Johansson wrote:
> > On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> > > Any comments on this approach? Is it better to merge mkfitsrc.sh with
> > > mkuboot.sh?
> > 
> > I know this was discussed quite extensively yesterday, but here is my take on
> > it:
> > 
> > Given the recent complications from multiplatform, we really saw a strong
> > reason to _not_ do the final boot wrapping in the kernel build system.
> > Produce the zImage and the DTB files, and have a surrounding script that
> > bundles the two in a format that your particular device needs.
> > 
> > Most distros have scripts to handle the "make install" step of a kernel build.
> > That's where this belongs, not in the actual build step.
> 
> Not sure I agree here:

Lets try and stop this again here.  I think perhaps the KVM tool example
is instructive here.  For the various reasons that close association
with the kernel can be helpful for things (the exposure and ease of
being found), it would be nice if the tooling to expand single kernel
image into single "bootable" image was with the kernel.  But it's not a
requirement.  And it's not even necessarily the best for the tooling
either.  So, lets drop the idea of getting this into the kernel and if
people really do wish to extend FIT such that we can easily spit out a
FIT image that works on omap* and tegra* or what have you, and add a FIT
parser to GRUB, great, get to work.  No need to be tied to the kernel
for this.

-- 
Tom
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130318/894ff183/attachment-0001.sig>
