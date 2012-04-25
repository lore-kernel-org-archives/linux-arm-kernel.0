From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Apr 2012 10:46:41 +0300
Subject: [PATCH v2 1/3] ARM: tegra: Add AHB driver
In-Reply-To: <20120425083747.466f5c98330af8964d980b8c@nvidia.com>
References: <1335269116-9578-1-git-send-email-hdoyu@nvidia.com>
 <20120424195645.GB3628@n2100.arm.linux.org.uk>
 <20120425083747.466f5c98330af8964d980b8c@nvidia.com>
Message-ID: <20120425074639.GB3423@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 08:37:47AM +0300, Hiroshi Doyu wrote:
> On Tue, 24 Apr 2012 21:56:45 +0200
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Tue, Apr 24, 2012 at 03:05:14PM +0300, Hiroshi DOYU wrote:
> > > The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> > > High-performance Bus (AHB) architecture.
> > > 
> > > The AHB Arbiter controls AHB bus master arbitration. This effectively
> > > forms a second level of arbitration for access to the memory
> > > controller through the AHB Slave Memory device. The AHB pre-fetch
> > > logic can be configured to enhance performance for devices doing
> > > sequential access. Each AHB master is assigned to either the high or
> > > low priority bin. Both Tegra20/30 have this AHB bus.
> > > 
> > > Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > Update:
> > > - Use platform_device to get info from dt dynamically.(Felipe/Arnd)
> > > ---
> > >  arch/arm/mach-tegra/Makefile    |    1 +
> > >  arch/arm/mach-tegra/tegra-ahb.c |  285 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 286 insertions(+), 0 deletions(-)
> > 
> > 1. I thought we weren't going to have any more drivers under
> >    arch/arm
> 
> Can this driver be located under "drivers/misc"? Or is there any better place?

maybe drivers/platform/arm/ ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120425/0156126d/attachment-0001.sig>
