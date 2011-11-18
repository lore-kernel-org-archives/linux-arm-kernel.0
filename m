From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 18 Nov 2011 08:25:33 -0800
Subject: [PATCH] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
 <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740D74E63@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Friday, November 18, 2011 5:04 AM:
> On Thu, Nov 17, 2011 at 07:51:35PM +0100, Stephen Warren wrote:
> > Peter De Schrijver wrote at Thursday, November 17, 2011 8:07 AM:
> > > Convert tegra20 IRQ intialization to the GIC devicetree binding. Modify the
> > > interrupt definitions in the dts files according to
> > > Documentation/devicetree/bindings/arm/gic.txt
> > >
> > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >
> > tegra-harmony.dts contains an interrupts property that wasn't updated,
> > for the WM8903 codec.
> 
> But that's a GPIO interrupt no?

The interrupt line from codec to Tegra is a GPIO, yes.

But the WM8903 still has the same interrupt-parent as everything else,
since it's inherited from /interrupt-parent and doesn't define its own.
Perhaps this is a mistake?

-- 
nvpublic
