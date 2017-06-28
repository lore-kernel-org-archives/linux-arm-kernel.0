From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Jun 2017 08:59:56 -0700
Subject: [RESEND PATCH v4] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <110cf67f-e1d6-1f99-953c-6b9639bb4910@st.com>
References: <1496818794-14771-1-git-send-email-gabriel.fernandez@st.com>
 <20170621220703.GI4493@codeaurora.org>
 <110cf67f-e1d6-1f99-953c-6b9639bb4910@st.com>
Message-ID: <20170628155956.GA5316@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27, Gabriel FERNANDEZ wrote:
> 
> 
> On 06/22/2017 12:07 AM, Stephen Boyd wrote:
> > readl_poll_timeout?
> >
> if i use readl_poll_timeout (wich use 'ktime_get()') it can be 
> operational only after the selection of clocksource ? (device_initcall).
> And then if a driver turn on a clock before, it could blocked the linux 
> console ?
> 

Ok. I wonder if we could add some sort of starting check to
readl_poll_timeout() that tests system_state for booting vs.
scheduling? That should be sufficient to handle this case?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
