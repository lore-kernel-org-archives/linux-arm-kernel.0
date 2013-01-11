From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 11 Jan 2013 04:40:15 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <50EF54B6.6010100@wwwdotorg.org>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
 <50EF54B6.6010100@wwwdotorg.org>
Message-ID: <20130111034015.GA28094@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 04:54:30PM -0700, Stephen Warren wrote:
> On 01/09/2013 01:43 PM, Thierry Reding wrote:
> > Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
> > directory. The motivation is to collect various host controller drivers
> > in the same location in order to facilitate refactoring.
> > 
> > The Tegra PCIe driver has been largely rewritten, both in order to turn
> > it into a proper platform driver and to add MSI (based on code by
> > Krishna Kishore <kthota@nvidia.com>) as well as device tree support.
> 
> This driver doesn't compile unless CONFIG_PCI_MSI is also enabled.
> Should it select that, or contain a few ifdefs?
> 
> drivers/pci/host/pci-tegra.c:900: undefined reference to `write_msi_msg'

Right, it'll need #ifdefs around the arch_{setup,teardown}_msi_irq(). Or
select PCI_MSI unconditionally. Once this is merged I was going to post
a patch that enables PCI_MSI in tegra_defconfig anyway. But it might be
better to keep it optional anyway since the remainder of the code copes
with it properly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/44d1b66e/attachment.sig>
