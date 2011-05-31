From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2011 09:53:16 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <4DE494E6.6000504@st.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
	<4DE494E6.6000504@st.com>
Message-ID: <20110531085316.GB30184@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 08:12:38AM +0100, viresh kumar wrote:
> On 05/20/2011 04:25 PM, Catalin Marinas wrote:
> > On ARM it is guaranteed that the writes are issued in program order
> > and they arrive to the same device in program order (the definition of
> > the device is still debatable). Arriving at different devices in
> > program order is not guaranteed (depends on the bus configuration).
> > They also don't do any endianess conversions.
> 
> Is this guaranteed in case of ARMV7 also, where we have two ports coming
> out of ARM ? As now there can be two access paths to devices, and so they
> might come out of order.

The order to different devices is not guaranteed. The order to the same
device is guaranteed but the issue here is the device definition. For
device address range greater than 1KB (the minimum specified in the ARM
ARM), a single device can be connected to both ports and accessing
registers which are not in the same 1KB block may arrive out of order.
While I don't think this should be done in practice (or at least the 1KB
range should be larger), it is already present in certain
implementations.

-- 
Catalin
