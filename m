From: vbyravarasu@nvidia.com (Venu Byravarasu)
Date: Wed, 23 Jan 2013 12:13:29 +0530
Subject: [PATCH 2/2] ARM: tegra: add clocks properties to USB PHY nodes
In-Reply-To: <50FF2FD0.2090003@wwwdotorg.org>
References: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
 <1358900903-27654-2-git-send-email-swarren@wwwdotorg.org>
 <50FF2FD0.2090003@wwwdotorg.org>
Message-ID: <D958900912E20642BCBC71664EFECE3E6E1B13B847@BGMAIL02.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Warren [mailto:swarren at wwwdotorg.org]
> Sent: Wednesday, January 23, 2013 6:03 AM
> To: Venu Byravarasu
> Cc: Alan Stern; Greg Kroah-Hartman; linux-tegra at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-usb at vger.kernel.org; Stephen Warren
> Subject: Re: [PATCH 2/2] ARM: tegra: add clocks properties to USB PHY nodes
> 
> On 01/22/2013 05:28 PM, Stephen Warren wrote:
> > The patch to add USB PHY nodes to device tree was written before Tegra
> > supported the clocks property in device tree. Now that it does, add the
> > required clocks properties to these nodes.
> >
> > This will allow all clk_get_sys() calls in tegra_usb_phy.c to be replaced
> > by clk_get(phy->dev, clock_name), as part of converting the PHY driver to
> > a platform driver.
> 
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi
> b/arch/arm/boot/dts/tegra20.dtsi
> 
> > +		clocks = <&tegra_car 22>, <&tegra_car 127>;
> > +		clock-names = "utmi", "pll_u";
> ...
> > +		clocks = <&tegra_car 94>, <&tegra_car 127>;
> > +		clock-names = "ulpi", "pll_u";
> 
> Hmmm. Thinking about that first clock more, if we name it just "phy" in
> both the UTMI and ULPI PHY nodes, we could make tegra_phy_init() perform
> the clk_get() for all PHY types, and use the same clock name everywhere,
> and hence remove the type-specific clk_get()s from tegra_phy_init() and
> utmip_pad_open().
> 
> Venu, will this work for other chips such as Tegra30/Tegra114 and so on
> into the future, or do chips after Tegra20 introduce any new clocks, and
> hence break this scheme?
 
Should be fine, as same clocks are used across all chips.
Acked-by: Venu Byravarasu <vbyravarasu@nvidia.com>
