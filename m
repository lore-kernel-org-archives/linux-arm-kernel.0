From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Dec 2014 13:32:08 +0000
Subject: [PATCH 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <20141212164254.GK22670@titan.lakedaemon.net>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
 <20141211180245.GE28150@leverpostej>
 <1418371705.423.31.camel@mtksdaap41>
 <20141212164254.GK22670@titan.lakedaemon.net>
Message-ID: <20141215133208.GC8264@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 04:42:54PM +0000, Jason Cooper wrote:
> On Fri, Dec 12, 2014 at 04:08:25PM +0800, Eddie Huang wrote:
> > On Thu, 2014-12-11 at 18:02 +0000, Mark Rutland wrote:
> > > On Wed, Dec 10, 2014 at 10:50:01AM +0000, Eddie Huang wrote:
> ...
> > > > +	memory {
> > > 
> > > Nit: should be memory at 40000000 (and you'll need to add device_type =
> > > "memory").
> > > 
> > > > +		reg = <0 0x40000000 0 0x40000000>;
> > > > +	};
> > 
> > skeleton.dtsi already has /memory node with address-cells=2,
> > size-cells=1, which will cause build warning if I change to use
> > memory at 40000000, because we use size-cells=2. I will not include
> > skeleton.dtsi and follow your suggestion in next version.
> 
> There's skeleton64.dtsi in arch/arm/boot/dts (arm 32bit has LPAE-enabled
> systems).  Perhaps we should come up with a way to share both across the
> arches?

As I mentioned in my other reply [1], I think if anything it would be
better to get rid of the skeleton dtsi entirely.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310617.html

Thanks,
Mark.
