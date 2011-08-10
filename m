From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 10 Aug 2011 22:23:53 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <20110810103225.GJ1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<4E4259F5.8060402@st.com>
	<20110810103225.GJ1831@n2100.arm.linux.org.uk>
Message-ID: <1312995233.1603.6.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-10 at 11:32 +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2011 at 03:44:13PM +0530, viresh kumar wrote:
> > On 08/10/2011 03:31 PM, Koul, Vinod wrote:
> > > And on your patch, are you able to dynamically assign the channels for
> > > platform? What is the intended usage? (as Russell articulated it is bad
> > > to dynamically assign channel for something like uart)
> > 
> > Are you talking about channels or DMA request lines? For channels yes,
> > we can always allocate channels as they are independent of peripherals.
> > About request lines, they are muxed in our case between several
> > peripherals, but support for that has to be added in dw_dmac.
> 
> Right, and when you do, you'll probably have to go to a virtual channel
> implementation, which solves the problem of keeping a channel allocated
> and makes this patch redundant.
> 
> I assert that any DMA engine implementation where request signals can
> be assigned dynamically to DMA channels should be using a virtual channel
> implementation.
Agreed, virtual channels can ensure that channels can be shared
dynamically. If h/w has capability it should be able to do a spi
transfer followed by emmc transfer ans so forth...
Current model of giving client exclusive access to a channel doesn't
allow this

-- 
~Vinod
