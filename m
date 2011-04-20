From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 20 Apr 2011 12:46:47 +0530
Subject: Query about vexpress_ct_ca9x4 watchdog issue ?
In-Reply-To: <4b3cc9c7.13699.12f71a8b503.Coremail.bill_carson@126.com>
References: <4DAE62EF.7050508@st.com>
	<1b4f89d.afd2.12f70a9e2b0.Coremail.bill_carson@126.com>
	<4b3cc9c7.13699.12f71a8b503.Coremail.bill_carson@126.com>
Message-ID: <4DAE885F.3060308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2011 12:16 PM, bill wrote:
> At 2011-04-20 12:37:03?"viresh kumar" <viresh.kumar@st.com> wrote:
>> On 04/20/2011 07:37 AM, bill wrote:
>>> I read the WdogValue/WdogControl register as specified in SP805TRM, it does not change any way, 
>>>
>>> WdogValue     --> 0xf0918000
>>> WdogControl   -->0x3
>>>
>>>
>>> It seems the value is correct, but watchdog is not triggered.
>>> I am really puzzled about this, can you give me some clue to find the root cause?
>>>
>>
>> Hi Bill,
>>
>> It looks that you are also not getting WDT reset after specified timeout? Is it so?
>> So, probably driver is fine as it is tested on SPEAr.
>>
> 
> I have test this driver on SPEAr1310 with drivers/watchdog/coh901327_wdt.c

Sorry i got confused here. Which driver did you test coh901327_wdt.c or SP805.
1310 doesn't have 805, neither have coh901327_wdt. It has cortex watchdog, for which
support is not added for spear.

coh901327_wdt.c is for ST Ericsson's U300 soc.


>> Probably the issue might be with clock rate and clock enable. What is the clock rate
>> for wdt in your platform?
>> Driver calls clk_enable() and clk_get_rate(). Can you please verify that this is
>> working correctly.
>>
> 
> 
> I did check the clock issue, current mach-vexpress use plat-versatile clock implementation
> in plat-versatile/clock.c clk_enable is an empty function;
> so I guess we don't need any clock gating function in mach-vexpress.

The only thing i can think of is clock, as wdt_value is not at all decrementing.

--
viresh
