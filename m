From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 10 May 2018 08:33:50 -0500
Subject: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
In-Reply-To: <20180509045151.GA24899@dragon>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
 <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509045151.GA24899@dragon>
Message-ID: <20180510133350.GH173327@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 12:51:53PM +0800, Shawn Guo wrote:
> Hi Bjorn,
> 
> On Tue, May 08, 2018 at 07:56:58AM -0500, Bjorn Helgaas wrote:
> ...
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	pci->pp.root_bus_nr = -1;
> > 
> > Setting root_bus_nr looks like an unrelated change that should be in a
> > separate patch.
> > 
> > But I'm not sure why you need to set root_bus_nr at all, since
> > dw_pcie_host_init() always sets it.
> > 
> > Some other callers of dw_pcie_host_init() do set it:
> > 
> >   exynos_add_pcie_port()
> >   imx6_add_pcie_port()
> >   armada8k_add_pcie_port()
> >   artpec6_add_pcie_port()
> >   dw_plat_add_pcie_port()
> >   histb_pcie_probe()
> >   qcom_pcie_probe()
> >   spear13xx_add_pcie_port()
> > 
> > But I don't see *why* any of these need to set it.  If they don't need to
> > set it, they shouldn't.
> 
> Mostly it's a blind copy of unnecessary code.  I tested histb driver
> by dropping the line, and did not see anything broken.  I will cook up
> a series to remove the code from all above drivers, and copy
> corresponding driver owner to comment.

Thanks, Shawn, I really appreciate that!

> > And it would be nice if histb and qcom followed the structure and naming
> > conventions of the other drivers, i.e., they should have
> > histb_add_pcie_port() and qcom_add_pcie_port().
> 
> I can create a patch for histb driver, but will leave qcom one to
> Stanimir to decide.

Sounds good, thanks again!
