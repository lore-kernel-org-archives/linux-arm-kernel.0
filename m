From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 20 Apr 2011 10:07:03 +0530
Subject: Query about vexpress_ct_ca9x4 watchdog issue ?
In-Reply-To: <1b4f89d.afd2.12f70a9e2b0.Coremail.bill_carson@126.com>
References: <1b4f89d.afd2.12f70a9e2b0.Coremail.bill_carson@126.com>
Message-ID: <4DAE62EF.7050508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2011 07:37 AM, bill wrote:
> Hi viresh and arm guys:)
> 
> I am testing sp805 watchdog at vexpress board.
> 
> After open /dev/watchdog , I use WDIOC_GETTIMELEFT ioctl to get the time left for rebooting in a loop;
> while the timeleft is not decrementing, but stay as a constant 59s.
> 
> I read the WdogValue/WdogControl register as specified in SP805TRM, it does not change any way, 
> 
> WdogValue     --> 0xf0918000
> WdogControl   -->0x3
> 
> 
> It seems the value is correct, but watchdog is not triggered.
> I am really puzzled about this, can you give me some clue to find the root cause?
> 

Hi Bill,

It looks that you are also not getting WDT reset after specified timeout? Is it so?
So, probably driver is fine as it is tested on SPEAr.

Probably the issue might be with clock rate and clock enable. What is the clock rate
for wdt in your platform?
Driver calls clk_enable() and clk_get_rate(). Can you please verify that this is
working correctly.

-- 
viresh
