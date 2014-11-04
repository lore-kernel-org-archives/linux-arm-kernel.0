From: olof@lixom.net (Olof Johansson)
Date: Mon, 3 Nov 2014 20:47:17 -0800
Subject: [GIT PULL] dts, kbuild: Implement support for dtb vendor subdirs
In-Reply-To: <20141021181504.GV20170@rric.localhost>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
 <20141021181504.GV20170@rric.localhost>
Message-ID: <20141104044717.GA13562@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 08:15:04PM +0200, Robert Richter wrote:
> Arnd,
> 
> On 05.09.14 08:48:06, Robert Richter wrote:
> > From: Robert Richter <rrichter@cavium.com>
> > 
> > For arm64 we want to put dts files into vendor's subdirectories from
> > the beginning. This patch set implements this. As this is a generic
> > kbuild implementation, vendor subdirs will be also available for
> > arch/arm and other architectures. The subdirectory tree is also
> > reflected in the install path.
> > 
> > A new makefile variable dts-dirs is introduced to point to dts
> > subdirs. This variable is used by kbuild for building and installation
> > of dtb files.
> > 
> > A dts Makefile looks now as follows:
> > 
> > ----
> > dtb-$(CONFIG_...) += some_file_1.dtb
> > dtb-$(CONFIG_...) += some_file_2.dtb
> > 
> > dts-dirs          += dir_vendor_a
> > dts-dirs          += dir_vendor_b
> > 
> > # come always afterwards:
> > always         := $(dtb-y)
> > subdir-y       := $(dts-dirs)
> > clean-files    := *.dtb
> > ----
> > 
> > This patches also introduces the dtbs_install make target for
> > arm64. Install rules are moved to Makefile.dtbinst using the same
> > style and calling convention like for modinst and fwinst.
> > 
> > Robert Richter (6):
> >   dts, arm64: Add dtbs_install make target
> >   dts, kbuild: Factor out dtbs install rules to Makefile.dtbinst
> >   dts, arm/arm64: Remove dtbs build rules in sub-makes
> >   dts, kbuild: Implement support for dtb vendor subdirs
> >   dts, arm64: Move dts files to vendor subdirs
> >   dts, arm: Remove $(MACHINE) variable from dtbs make recipes
> 
> please pull this series for inclusion into v3.19 from:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rric/linux.git dts-subdirs-for-arm-soc-v3.19
> 
> I have updated and rebased the patches to v3.18-rc1. No changes except
> conflict resolution of patch 5/6.

Pulled, and I added the description from 0/6 as the merge text -- feel free to
add it to the tag if you do something like this in the future.


-Olof
