From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Sep 2012 11:44:22 +0100
Subject: [RFC PATCH 0/3] ARM: uncompress.h multi-platform enablement
In-Reply-To: <201209261038.36223.arnd@arndb.de>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
 <201209261038.36223.arnd@arndb.de>
Message-ID: <20120926104421.GA7040@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 10:38:36AM +0000, Arnd Bergmann wrote:
> On Tuesday 25 September 2012, Stephen Warren wrote:
> > 
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Tegra's uncompress and debug-macro.S communicate to each-other. Hence,
> > we can't be left without uncompress.h in a multi-platform enabled kernel,
> > or we'll lose features. This series allows uncompress.h to be used in a
> > multi-platform kernel, restores the mvebu uncompress.h, and finally moves
> > the Tegra debug macros into the common location. The series as mainly an
> > RFC due to the outstanding question of where to put Tegra's <mach/iomap.h>
> > in the final patch.
> 
> 
> To follow up on the IRC discussion we had yesterday leading to this patch
> set, I had another idea of how to handle the same: Since the decompressor
> code is actually fairly separate from the kernel, we could also build
> multiple versions of it, and link in the same compressed vmlinux.

That rubbishes the idea of a single kernel though, which is to give
distros a single kernel image that they can boot on different ARM
platforms.

They want a single kernel binary that works everywhere, not one which
they need to select the right binary to work on platform X.  Yes, the
_internal_ uncompressed bulk may be the same, but it would require
distros to carry around N different kernel images for N different
platforms.
