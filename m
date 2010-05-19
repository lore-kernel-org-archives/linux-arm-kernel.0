From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 19 May 2010 09:32:57 +0530
Subject: [PATCH] Watchdog: Adding support for Watchdog found with ARM
	CortexA9
In-Reply-To: <20100518132050.GA8748@mvista.com>
References: <1274090044-10236-1-git-send-email-viresh.kumar@st.com>	<AANLkTil2PtnsKdAHvW5-1WMQyTj6v3uLtrn2CNaZSXkc@mail.gmail.com>	<4BF12767.4010402@st.com>	<AANLkTikCC108eWniEBwzYsbkEUYQocICaLtd7FD_vMQ1@mail.gmail.com>
	<20100518132050.GA8748@mvista.com>
Message-ID: <4BF362F1.5070100@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2010 6:50 PM, George G. Davis wrote:
> Hi,
> 
> On Tue, May 18, 2010 at 02:55:21PM +0530, srinidhi kasagar wrote:
>> I do not understand why a new driver is required while having similar one
>> for MPCore watchdog.
>> Please have a look at drivers/watchdog/mpcore_wdt.c
> 
> The same thought occurred to me.  Based on a cursory glance at the Cortex-A9
> MPCore and ARM11 MPCore, the per-CPU watchdogs do appear to be the same
> and could use the same driver.
> 
> Any reason for creating a new driver rather than reusing the ARM11
> MPCore driver?
> 

Sorry Guys!!! Earlier I tried to find existing driver, but couldn't found one.
So sent a new one.

I went through this driver and found some shortcomings in it:
 - It looks it is not used by anyone now, as it required
   asm/hardware/arm_twd.h and it was removed in v2.6.31.
   So it would never compile.
 - It doesn't support clock framework, and works on fixed rate.
 - It works on fixed prescale value (256).
 - It doesn't support WDIOC_GETBOOTSTATUS.

So, please suggest how to proceed as my patch contains all these features.

regards,
viresh kumar.
