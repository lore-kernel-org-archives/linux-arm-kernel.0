From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jan 2012 10:31:50 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178E123E54@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <CAPnjgZ3Xhebn1x1A-Vdy78DWbDd=cp0AK6tL-R1SRzS4GdF97g@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178E123E54@HQMAIL01.nvidia.com>
Message-ID: <20120130023148.GC10470@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 09:29:50AM -0800, Stephen Warren wrote:
> Simon Glass wrote at Thursday, January 26, 2012 10:42 AM:
...
> > 1. It doesn't seem to make full use of the device tree format. For example,
> > 
> >    <TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
> > 
> > would be better as something like
> > 
> >     drive-strength = <5>;
> > 
> > if we could arrange it. It also reduces the need for these
> > TEGRA_PMX_CONF_DRIVE_STRENGTH defines.
> 
> Yes I can see the argument this is more readable.
> 
> However, it:
> 
> * Requires a lot of string handling when parsing the device tree, since
>   you have to search for lots of individual properties by name.
> 
> * Bloats the device tree quite a bit due to representing each parameter
>   as a separate property, with a longish name, rather than a single u32
>   cell in the config property I proposed.
> 
It bloats device tree more due to the proposal needs to represent every
single muxable entity (pin for imx case) as a node to accommodate the
properties like 'drive-strength' here.

-- 
Regards,
Shawn
