From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 18 Nov 2013 12:56:02 +0000
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <20131115152142.GC10335@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net> <
 20131115121215.901EFC40885@trevor.secretlab.ca> <20131115152142.GC10335@
 titan.lakedaemon.net>
Message-ID: <20131118125602.8681EC409E3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Nov 2013 10:21:42 -0500, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Nov 15, 2013 at 09:12:15PM +0900, Grant Likely wrote:
> > On Mon, 11 Nov 2013 20:29:20 +0000, Jason Cooper <jason@lakedaemon.net> wrote:
> > > Consumers of the Linux kernel's build products are beginning to hardcode
> > > the filenames of the dtbs generated.  Since the dtb filenames are
> > > currently the dts filename s/dts/dtb/, this prevents the kernel
> > > community from renaming dts files as needed.
> > > 
> > > Let's provide a consistent naming structure for consumers to script
> > > against.  Or at least, as consistent as the dts properties themselves.
> > > 
> > > With this patch, adding the '-L' option to the dtc commandline will
> > > cause dtc to create a symlink to the generated dtb, using the board
> > > compatible string as the filename, eg:
> > > 
> > >   globalscale,mirabox.dtb -> armada-370-mirabox.dtb
> > 
> > This whole thread is just crazy. The filename is not an ABI. Anything
> > digging into the kernel build tree is a) wrong, and b) userspace tooling
> > consuming the kernel build products which is /not/ ABI and can be changed
> 
> whew.  I still think there is a need for an install target.  The fact
> that our changing filenames might break things is an indicator of that.
> 
> > If we want to have a tool or script for creating a well formed directory
> > full of .dtb files because it would be helpful to U-Boot or something
> > else, then that is fine. Make it part of the "make install" path.
> 
> I'm currently reworking the patch(es) to implement 'make dtbs-install'.
> I'll hopefully have them ready this weekend or sooner.  I'm taking the
> same tack as install.sh (/sbin/installdtbs takes precedence).

Cool, I think that is a good approach.

g.
