From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 27 Jan 2012 09:38:47 -0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120127022111.GK29812@atomide.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <CAPnjgZ3Xhebn1x1A-Vdy78DWbDd=cp0AK6tL-R1SRzS4GdF97g@mail.gmail.com>
 <20120127022111.GK29812@atomide.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E123E59@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote at Thursday, January 26, 2012 7:21 PM:
> * Simon Glass <sjg@chromium.org> [120126 09:11]:
> >
> > On Fri, Jan 20, 2012 at 2:22 PM, Stephen Warren <swarren@nvidia.com> wrote:
> >
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
> I agree. This is something that most pinmux/pinconf drivers need to
> implement, so it's best done in a generic way.

Yet:

* Some controllers don't have a "drive strength" property
* Others have a single "drive strength" property
* Others configure drive strength separately for driving a signal high
or low.

Hence, representing this in a generic fashion doesn't seem possible to
me, except through (key, value) pairs where the individual drivers or
bindings define what the keys are.

-- 
nvpublic
