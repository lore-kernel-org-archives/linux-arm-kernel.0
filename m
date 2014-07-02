From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Jul 2014 10:25:10 -0400
Subject: [PATCH 1/2] ARM: kirkwood: add appended DTB support in
 kirkwood_defconfig
In-Reply-To: <20140702134655.GE20799@lunn.ch>
References: <1404305778-17757-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702134655.GE20799@lunn.ch>
Message-ID: <20140702142510.GM23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 03:46:55PM +0200, Andrew Lunn wrote:
> On Wed, Jul 02, 2014 at 02:56:17PM +0200, Thomas Petazzoni wrote:
> > Most of the Kirkwood platforms use fairly old bootloaders that don't
> > have Device Tree support, so it makes sense to enable appended DTB
> > support by default, as well as the backward compatibility with ATAGS
> > passed by the bootloader for those platforms. It helps having a
> > defconfig that works fine out of the box for most Kirkwood platforms.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/configs/kirkwood_defconfig | 2 ++
> 
> Hi Thomas
> 
> I plan to remove mach-kirkwood this cycle. So kirkwood_defconfig will
> get removed. Please could you patch mvebu_v5_defconfig instead?

Do we need to?  There may be users who want to build a non-multiplatform
kernel for kirkwood, or dove...  It certainly takes less time than a
multiplatform build.

thx,

Jason.
