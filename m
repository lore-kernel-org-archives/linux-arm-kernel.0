From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 20 Nov 2013 12:22:08 -0500
Subject: [PATCH V4] kbuild: dtbs_install: new make target
In-Reply-To: <20131120132159.88E01C4079D@trevor.secretlab.ca>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1384896475-8744-1-git-send-email-jason@lakedaemon.net>
 <528BDEED.8080708@wwwdotorg.org>
 <20131120132159.88E01C4079D@trevor.secretlab.ca>
Message-ID: <20131120172208.GK28859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 01:21:58PM +0000, Grant Likely wrote:
> On Tue, 19 Nov 2013 14:58:05 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 11/19/2013 02:27 PM, Jason Cooper wrote:
> > > Unlike other build products in the Linux kernel, there is no 'make
> > > *install' mechanism to put devicetree blobs in a standard place.
> > > 
> > > This patch is an attempt to fix this problem.  Akin to 'make install',
> > > this creates a new make target, dtbs_install.  The script that gets
> > > called defers to a distribution or user supplied installdtbs binary,
> > > if found in the system.  Otherwise, the default action is to install a
> > > given dtb into
> > > 
> > >   /lib/modules/${kernel_version}/devicetree/${dts_filename}.dtb
> > 
> > I still don't see why you wouldn't install the files in
> > /lib/devicetrees, but I suppose that location is fine.
> 
> /boot/devicetrees/${kernel_version} would be my choice. /boot is more
> likely to be available to firmware than /lib would be.

True, but a lot of systems make /boot a small, non-automounted separate
partition.  It's not that all of the dtbs take up a lot of space, but
that only one of them is needed to boot, which is what /boot is intended
to hold.

I think it's a distribution issue to determine whether to put one, some
or all of the dtbs in /boot.  I'd prefer not to make that decision for
them.

Is /lib/devicetrees/${kernelversion}/ an acceptable middle ground?

thx,

Jason.
