From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Nov 2013 19:34:20 +0000
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <20131114191622.GC21549@obsidianresearch.com>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net> <52828C77.20001@wwwdotorg.org>
 <20131114162859.GX10335@titan.lakedaemon.net> <52851DC8.203@wwwdotorg.org>
 <20131114191622.GC21549@obsidianresearch.com>
Message-ID: <20131114193420.GF16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 12:16:22PM -0700, Jason Gunthorpe wrote:
> On Thu, Nov 14, 2013 at 12:00:24PM -0700, Stephen Warren wrote:
> 
> > I don't think a distro should need to know the DTB filename at all.
> > Rather, the/a bootloader should know which platform it's running on, and
> > provide a variable/... to the boot script/... that defines the DTB
> > filename. That would completely remove all the knowledge of DTB
> > filenames from distros.
> 
> At some point the distro has to install a dtb into some cannonical
> place so the bootloader can find it..
> 
> Are you thinking that distros will have to ship a /boot/dtbs/*.dtb
> with every dtb from the kernel build?

Why are we even having this discussion?  Where distros want to install
dtbs is their policy.  What we should do is make it _possible_ for them
to have policy, not define the policy for them.

The problem here is this.  Consider how often these files change, and
how often there's differences in them.  Sensible distros allow you to
have several kernels installed so that you can switch to other
versions if, for example, you run into problems.

Distros have two main choices - either to ship the DTBs separately
assuming that they'll always be compatible and correct, or ship them
with the kernel itself (in which case we've lost the plot about what
DT is supposed to give us.)

That's where the problem lies: what if a distro wants to have installed
more than one set of DTBs corresponding to $old_kernel and $new_kernel.

This really isn't something for us kernel developers to decide.  It's
a distro question and it needs distro people to think about it and put
proposals forward for what they'd like to see.

In my experience, that won't happen - they like hiding away and sorting
out their own problems.  The communication between distros and kernel
folk has always tended to be extremely poor.
