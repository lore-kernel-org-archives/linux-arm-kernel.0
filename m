From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 9 Mar 2012 07:37:40 +0100
Subject: [PATCH 09/11] ARM: tegra: Rewrite PCIe support as a driver
In-Reply-To: <4F5911E0.6060802@wwwdotorg.org>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-10-git-send-email-thierry.reding@avionic-design.de>
 <4F5911E0.6060802@wwwdotorg.org>
Message-ID: <20120309063739.GC25208@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/08/2012 07:51 AM, Thierry Reding wrote:
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> Patch description?

I actually sat in front of the editor for a couple of minutes and I just
couldn't think of anything. I'll try harder for the next version.

> > diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
> ...
> > -static int __init harmony_pcie_init(void)
> > +static int tegra_pcie_init(struct platform_device *pdev)
> 
> That name should probably still be called harmony_something() since it's
> still board-specific.

Okay, I'll rename it to harmony_pcie_init().

> I wonder how having a per-board callback will integrate with device
> tree. I guess I'll find out when I review patch 11:-)
> 
> > diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
> 
> > +static int __init trimslice_pci_init(void)
> >  {
> >  	if (!machine_is_trimslice())
> >  		return 0;
> 
> You can remove that test now.

Okay.

> > diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
> 
> > +#define TEGRA_PCIE_MAX_PORTS 2
> > +
> > +struct tegra_pcie_pdata {
> > +	int (*init)(struct platform_device *pdev);
> > +	int (*exit)(struct platform_device *pdev);
> > +	bool enable_ports[TEGRA_PCIE_MAX_PORTS];
> > +};
> 
> That's a somewhat odd place to put the header; a dedicated
> mach-tegra/include/mach/tegra_pcie_pdata.h or
> include/linux/platform_data/tegra_pcie.h might make more sense.

mach-tegra/include/mach/pcie.h perhaps? That would be less redundant.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/e23b9cb7/attachment-0001.sig>
