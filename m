From: bill_carson@126.com (bill)
Date: Wed, 20 Apr 2011 14:46:12 +0800 (CST)
Subject: Query about vexpress_ct_ca9x4 watchdog issue ?
In-Reply-To: <4DAE62EF.7050508@st.com>
References: <4DAE62EF.7050508@st.com>
	<1b4f89d.afd2.12f70a9e2b0.Coremail.bill_carson@126.com>
Message-ID: <4b3cc9c7.13699.12f71a8b503.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





At 2011-04-20 12:37:03?"viresh kumar" <viresh.kumar@st.com> wrote:

>On 04/20/2011 07:37 AM, bill wrote:
>> Hi viresh and arm guys:)
>> 
>> I am testing sp805 watchdog at vexpress board.
>> 
>> After open /dev/watchdog , I use WDIOC_GETTIMELEFT ioctl to get the time left for rebooting in a loop;
>> while the timeleft is not decrementing, but stay as a constant 59s.
>> 
>> I read the WdogValue/WdogControl register as specified in SP805TRM, it does not change any way, 
>> 
>> WdogValue     --> 0xf0918000
>> WdogControl   -->0x3
>> 
>> 
>> It seems the value is correct, but watchdog is not triggered.
>> I am really puzzled about this, can you give me some clue to find the root cause?
>> 
>
>Hi Bill,
>
>It looks that you are also not getting WDT reset after specified timeout? Is it so?
>So, probably driver is fine as it is tested on SPEAr.
>

I have test this driver on SPEAr1310 with drivers/watchdog/coh901327_wdt.c
after open /dev/watchdog, console hanged after a while ,
but the system does not reboot as expected.


>Probably the issue might be with clock rate and clock enable. What is the clock rate
>for wdt in your platform?
>Driver calls clk_enable() and clk_get_rate(). Can you please verify that this is
>working correctly.
>


I did check the clock issue, current mach-vexpress use plat-versatile clock implementation
in plat-versatile/clock.c clk_enable is an empty function;
so I guess we don't need any clock gating function in mach-vexpress.

thanks

bill


>-- 
>viresh
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
