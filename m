From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Aug 2011 15:44:13 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
Message-ID: <4E4259F5.8060402@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2011 03:31 PM, Koul, Vinod wrote:
> And on your patch, are you able to dynamically assign the channels for
> platform? What is the intended usage? (as Russell articulated it is bad
> to dynamically assign channel for something like uart)

Are you talking about channels or DMA request lines? For channels yes,
we can always allocate channels as they are independent of peripherals.
About request lines, they are muxed in our case between several
peripherals, but support for that has to be added in dw_dmac.

SPI is not as much heavily used as uart. So, it might be fine there to
allocate channels dynamically.

-- 
viresh
