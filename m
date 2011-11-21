From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 21 Nov 2011 14:22:12 +0200
Subject: [PATCH] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1740D74E63@HQMAIL01.nvidia.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
 <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74E63@HQMAIL01.nvidia.com>
Message-ID: <20111121122212.GL19069@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 05:25:33PM +0100, Stephen Warren wrote:
> Peter De Schrijver wrote at Friday, November 18, 2011 5:04 AM:
> > On Thu, Nov 17, 2011 at 07:51:35PM +0100, Stephen Warren wrote:
> > > Peter De Schrijver wrote at Thursday, November 17, 2011 8:07 AM:
> > > > Convert tegra20 IRQ intialization to the GIC devicetree binding. Modify the
> > > > interrupt definitions in the dts files according to
> > > > Documentation/devicetree/bindings/arm/gic.txt
> > > >
> > > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > >
> > > tegra-harmony.dts contains an interrupts property that wasn't updated,
> > > for the WM8903 codec.
> > 
> > But that's a GPIO interrupt no?
> 
> The interrupt line from codec to Tegra is a GPIO, yes.
> 
> But the WM8903 still has the same interrupt-parent as everything else,
> since it's inherited from /interrupt-parent and doesn't define its own.
> Perhaps this is a mistake?

Yes. I think this is a mistake. If we want the device tree to reflect the
hardware, I think the WM8903 node should specify the GPIO, not the IRQ
number.

Cheers,

Peter.
