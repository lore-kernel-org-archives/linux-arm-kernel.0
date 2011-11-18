From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 18 Nov 2011 14:03:52 +0200
Subject: [PATCH] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
Message-ID: <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 07:51:35PM +0100, Stephen Warren wrote:
> Peter De Schrijver wrote at Thursday, November 17, 2011 8:07 AM:
> > Convert tegra20 IRQ intialization to the GIC devicetree binding. Modify the
> > interrupt definitions in the dts files according to
> > Documentation/devicetree/bindings/arm/gic.txt
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> tegra-harmony.dts contains an interrupts property that wasn't updated,
> for the WM8903 codec.

But that's a GPIO interrupt no?

> 
> board-dt.c contains logic to search for a node with compatible of
> nvidia,tegra20-gic, and then call irq_domain_add_simple. I assume that
> logic is replaced by the new common GIC code, and so should be removed
> from board-dt.c entirely?
> 

Need to check that...

Cheers,

Peter.
