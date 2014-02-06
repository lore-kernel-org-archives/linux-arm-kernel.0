From: pratyush.anand@st.com (Pratyush Anand)
Date: Thu, 6 Feb 2014 11:55:54 +0530
Subject: [PATCH V4 4/8] phy: st-miphy-40lp: Add skeleton driver
In-Reply-To: <52F32A58.1000904@ti.com>
References: <cover.1391661589.git.pratyush.anand@st.com>
 <8596e7596e0dfa9a487c4c2deb325bbdf785e55e.1391661589.git.pratyush.anand@st.com>
 <52F32549.5010303@ti.com> <20140206061430.GA2394@pratyush-vbox>
 <52F32A58.1000904@ti.com>
Message-ID: <20140206062554.GB2394@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 02:23:20PM +0800, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 06 February 2014 11:44 AM, Pratyush Anand wrote:
> > Hi Kishon,
> > 
> > On Thu, Feb 06, 2014 at 02:01:45PM +0800, Kishon Vijay Abraham I wrote:
> >> Hi,
> >>
> >> On Thursday 06 February 2014 10:14 AM, Pratyush Anand wrote:
> >>> ST miphy-40lp supports PCIe, SATA and Super Speed USB. This driver adds

[...]

> >>> +
> >>> +	phy_provider = devm_of_phy_provider_register(dev, st_miphy40lp_xlate);
> >>> +	if (IS_ERR(phy_provider)) {
> >>> +		dev_err(dev, "failed to register phy provider\n");
> >>> +		return PTR_ERR(phy_provider);
> >>> +	}
> >>
> >> phy_provider_register should be the last step in registering the PHY. Or your
> >> PHY call backs can be called before you create the PHY. Btw in your case you
> > 
> > But every one else like  phy-exynos-mipi-video or phy-omap-usb2 or any
> > other did it same way. First phy_provider_register and then
> > phy_create.
> 
> That's a bug which we figured out very late. Will get it fixed in this -rc cycle.

Ok..I ll correct in mine too. :)

Rgds
Pratyush
> 
> Thanks
> Kishon
