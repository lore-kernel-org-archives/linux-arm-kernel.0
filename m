From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 20 Nov 2013 13:21:58 +0000
Subject: [PATCH V4] kbuild: dtbs_install: new make target
In-Reply-To: <528BDEED.8080708@wwwdotorg.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net> <
 1384896475-8744-1-git-send-email-jason@lakedaemon.net> <528BDEED.8080708@
 wwwdotorg.org>
Message-ID: <20131120132159.88E01C4079D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013 14:58:05 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/19/2013 02:27 PM, Jason Cooper wrote:
> > Unlike other build products in the Linux kernel, there is no 'make
> > *install' mechanism to put devicetree blobs in a standard place.
> > 
> > This patch is an attempt to fix this problem.  Akin to 'make install',
> > this creates a new make target, dtbs_install.  The script that gets
> > called defers to a distribution or user supplied installdtbs binary,
> > if found in the system.  Otherwise, the default action is to install a
> > given dtb into
> > 
> >   /lib/modules/${kernel_version}/devicetree/${dts_filename}.dtb
> 
> I still don't see why you wouldn't install the files in
> /lib/devicetrees, but I suppose that location is fine.

/boot/devicetrees/${kernel_version} would be my choice. /boot is more
likely to be available to firmware than /lib would be.

g.
