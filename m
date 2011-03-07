From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Mar 2011 09:29:26 -0800
Subject: [PATCH 2/3] ARM: tegra: harmony: register i2c devices
In-Reply-To: <1299486399-21761-3-git-send-email-olof@lixom.net>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<1299486399-21761-3-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF045687B85A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Monday, March 07, 2011 1:27 AM:
> Register the base i2c busses on harmony. Devices coming at a later date,
> but this allows for hand-probing of some of them at least.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

This looks OK to me.

Addressing Sergei's comments:

> > +static struct tegra_i2c_platform_data harmony_dvc_platform_data = {
> > +	.bus_clk_rate   = 400000,
> > +};
>
>     Why not share the paltform data between devices if it's the same anyway?

Right now, the upstream tegra_i2c_platform_data has fewer fields than some
changes that I imagine are coming down the pipe from ChromeOS. i.e. the
content of those 3 platform data will probably be different in the future.
For this reason, it seems reasonable to keep them separate from the start.
But, unifying them for now and separating in a future patch would be fine by
me too.

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
