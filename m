From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 9 Jan 2013 22:58:15 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <201301092122.08011.arnd@arndb.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
 <201301092122.08011.arnd@arndb.de>
Message-ID: <20130109215815.GC13648@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 09:22:07PM +0000, Arnd Bergmann wrote:
> On Wednesday 09 January 2013, Thierry Reding wrote:
> > Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
> > directory. The motivation is to collect various host controller drivers
> > in the same location in order to facilitate refactoring.
> > 
> > The Tegra PCIe driver has been largely rewritten, both in order to turn
> > it into a proper platform driver and to add MSI (based on code by
> > Krishna Kishore <kthota@nvidia.com>) as well as device tree support.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> Can you split this patch into two patches, one that moves the file,
> and another one that does all the changes? It's a little hard to
> review when I can't easily see which code is actually new here.

Stephen suggested I post this as removal/addition because pretty much
everything changed. Reviewing the individual changes would be more
confusing than actually reviewing a new driver.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130109/3f8fd6f8/attachment.sig>
