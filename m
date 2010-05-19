From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 19 May 2010 12:15:07 +0530
Subject: [PATCH] Watchdog: Adding support for Watchdog found with ARM
	CortexA9
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666270@dbde02.ent.ti.com>
References: <1274090044-10236-1-git-send-email-viresh.kumar@st.com>	<AANLkTil2PtnsKdAHvW5-1WMQyTj6v3uLtrn2CNaZSXkc@mail.gmail.com>	<4BF12767.4010402@st.com>	<AANLkTikCC108eWniEBwzYsbkEUYQocICaLtd7FD_vMQ1@mail.gmail.com>	<20100518132050.GA8748@mvista.com>
	<4BF362F1.5070100@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5666270@dbde02.ent.ti.com>
Message-ID: <4BF388F3.6060500@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/19/2010 11:02 AM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Viresh KUMAR
>> Sent: Wednesday, May 19, 2010 9:33 AM
>> To: George G. Davis; srinidhi kasagar; alan at lxorguk.ukuu.org.uk
>> Cc: armando.visconti at st.com; shiraz.hashim at st.com; Jassi Brar; linus.walleij at stericsson.com; linux-
>> arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH] Watchdog: Adding support for Watchdog found with ARM CortexA9
>>
>> On 5/18/2010 6:50 PM, George G. Davis wrote:
>>> Hi,
>>>
>>> On Tue, May 18, 2010 at 02:55:21PM +0530, srinidhi kasagar wrote:
>>>> I do not understand why a new driver is required while having similar one
>>>> for MPCore watchdog.
>>>> Please have a look at drivers/watchdog/mpcore_wdt.c
>>>
>>> The same thought occurred to me.  Based on a cursory glance at the Cortex-A9
>>> MPCore and ARM11 MPCore, the per-CPU watchdogs do appear to be the same
>>> and could use the same driver.
>>>
>>> Any reason for creating a new driver rather than reusing the ARM11
>>> MPCore driver?
>>>
>>
>> Sorry Guys!!! Earlier I tried to find existing driver, but couldn't found one.
>> So sent a new one.
>>
>> I went through this driver and found some shortcomings in it:
>>  - It looks it is not used by anyone now, as it required
>>    asm/hardware/arm_twd.h and it was removed in v2.6.31.
>>    So it would never compile.
>>  - It doesn't support clock framework, and works on fixed rate.
>>  - It works on fixed prescale value (256).
>>  - It doesn't support WDIOC_GETBOOTSTATUS.
>>
>> So, please suggest how to proceed as my patch contains all these features.
>>
> Can the existing driver be upgraded with all above missing pieces?
> 

yes. will be done.
