From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 31 May 2011 12:42:38 +0530
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
Message-ID: <4DE494E6.6000504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

On 05/20/2011 04:25 PM, Catalin Marinas wrote:
> On ARM it is guaranteed that the writes are issued in program order
> and they arrive to the same device in program order (the definition of
> the device is still debatable). Arriving at different devices in
> program order is not guaranteed (depends on the bus configuration).
> They also don't do any endianess conversions.

Is this guaranteed in case of ARMV7 also, where we have two ports coming
out of ARM ? As now there can be two access paths to devices, and so they
might come out of order.

-- 
viresh
