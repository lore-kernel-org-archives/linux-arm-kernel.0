From: dick@softplc.com (Dick Hollenbeck)
Date: Tue, 04 Jan 2011 00:32:30 -0600
Subject: ks8695_gettimeoffset
In-Reply-To: <4D22BDAA.2030902@softplc.com>
References: <4D0FA9FB.3060309@softplc.com>	<20101220193049.GI28157@n2100.arm.linux.org.uk>	<4D18B2B5.5000001@visionsystems.de>
	<AANLkTi=+9h20je24F+pnoZRFE-of-VZ5Xax8-tDzFs4=@mail.gmail.com>
	<4D22BDAA.2030902@softplc.com>
Message-ID: <4D22BEFE.4090001@softplc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2011 12:26 AM, Dick Hollenbeck wrote:
> On 01/03/2011 01:55 PM, avictor.za at gmail.com wrote:
>> hi,
>>
>>> Is it possible at all to implement clocksource/clockevents for KS8695? As Dick and "Register Description" already said you cannot read the time register, so clocksource->read cannot be implemented to return ticks elapsed. Or do I see it wrong?
>> I'm pretty sure I tested this when I originally submitted the KS8685
>> processor support (May 2007), and the timer registers are readable.
>> I would of tested with a userspace program that sat in a tight loop
>> calling gettimeofday().
>>
>>
>> Regards,
>>   Andrew Victor
>>
> Thanks Andrew.  Can you explain how this is supposed to be a duration, even
> if one of these two registers was a readable down counter?
>
>  elapsed = __raw_readl(KS8695_TMR_VA + KS8695_T1TC) + __raw_readl(KS8695_TMR_VA + KS8695_T1PD);
>
>
> Which of the two is a down counter, and why would it be added to one that is not, or is?
>
> While you are thinking about that, I have a userspace test program that can peek at the two registers using a memory mapped region pointer, and it will tell us if the value is changing over time.

Sorry, I should have just ran the program before posting.  Both registers
are constant at 25000 while running.   So my original summary is correct,
that this C function is not worth anything.

Where do we go from here?

Dick
