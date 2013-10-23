From: ben@decadent.org.uk (Ben Hutchings)
Date: Thu, 24 Oct 2013 00:29:23 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023183041.GH5208@netboy>
References: <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com> <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023180108.GA23728@roeck-us.net>
 <20131023182502.GC32563@obsidianresearch.com>
 <20131023183041.GH5208@netboy>
Message-ID: <1382570963.6315.48.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-23 at 20:30 +0200, Richard Cochran wrote:
> On Wed, Oct 23, 2013 at 12:25:02PM -0600, Jason Gunthorpe wrote:
> 
> > What they want is one vmlinux/z, and a package of 'stuff' that they
> > can assemble a boot image for all hardware out of.
> 
> ...
> 
> > On ARM the package of 'stuff' can very reasonably include dtb. Distro
> > scripts can package modules+DTB+vmlinuz into something the bootloader
> > can understand. (The next pain point will be to standardize that)
> > 
> > The DTB doesn't have to be 'outside' the distro/kernel to give users a
> > seamless upgrade experience.
> 
> How can a distro possibly provide me a DTB?
> 
> They don't know what hardware I am using. Only I know that.

This is what Debian runs when installing a kernel on most ARM systems:
http://sources.debian.net/src/flash-kernel/3.11/functions

It starts by looking up the machine ID (in procfs, but may be overridden
because some board vendors don't set it correctly).  If the machine is
supported using FDT then there is an associated DTB file which will have
been installed with the kernel.  The script copies/appends this to the
appropriate place for the boot loader.

Ben.

-- 
Ben Hutchings
Teamwork is essential - it allows you to blame someone else.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/158a3751/attachment-0001.sig>
