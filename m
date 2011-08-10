From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Aug 2011 14:59:31 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <20110810090042.GE1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
Message-ID: <4E424F7B.2000800@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2011 02:30 PM, Russell King - ARM Linux wrote:
>> > They must be allocated when they are required and must be freed after we are
>> > done with transfers. So that they can be used by other users.
> Which DMA engine driver requires this?
> 

dw_dmac.c

> Normally, when we have DMA engine drivers with multiple request signals,
> the slave peripheral side publishes several virtual channels which are
> claimed by the peripheral drivers.  This (amongst other things) allows
> the peripheral drivers to hold claim to one of the virtual channels
> all the time that it's required.

If users of DMA expect DMA engine drivers to work this way, then we should
have this mentioned clearly in DMA slave documentation.

@Dan/Vinod: What do you say?

-- 
viresh
