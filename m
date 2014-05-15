From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 15 May 2014 09:40:42 +0100
Subject: [PATCH v4 1/6] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <2fe960fd-b145-42a8-ace2-e2cd3aaf0cdc@BN1AFFO11FD010.protection.gbl>
References: <1400087579-4250-1-git-send-email-matthias.bgg@gmail.com>
 <1400087579-4250-2-git-send-email-matthias.bgg@gmail.com>
 <2fe960fd-b145-42a8-ace2-e2cd3aaf0cdc@BN1AFFO11FD010.protection.gbl>
Message-ID: <CABuKBeLio4A=sRrjv3r0E-8gGe3aMZq66A3wy71Mr7SVeGQ8Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I did not realize that Android gmail app sends HTML mails.
So I send the comments below accidentally as HTML mail yesterday.
Sorry for that.

2014-05-14 18:29 GMT+01:00 S?ren Brinkmann <soren.brinkmann@xilinx.com>:
> Hi Matthias,
>
> just a few suggestions below. Nothing serious.
>
> On Wed, 2014-05-14 at 07:12PM +0200, Matthias Brugger wrote:
>> This patch adds a clock source and clock event for the timer found
>> on the Mediatek SoCs.
>>
>> The Mediatek General Porpose Timer block provides five 32 bit timers and
>> one 64 bit timer.
>>
>> Two 32 bit timers are used:
>> TIMER1: clock events supporting periodic and oneshot events
>> TIMER2: clock source configured as a free running counter
>
> It is pretty common, I think, to use the free running counter also as
> sched_clock. You probably want to look into this, but that's just a
> possible enhancement.

The timer block has also a 64 bit timer. I plan to have a look on this
one to use it as sched_clock.

But for now my priority is to get the serial console driver done.

>
> [...]
>> +static void __init mtk_timer_init(struct device_node *node)
>> +{
>> +     struct mtk_clock_event_device *evt;
>> +     struct resource res;
>> +     unsigned long rate = 0;
>> +     struct clk *clk;
>> +     int ret;
>> +     u32 val;
>> +
>> +     evt = kzalloc(sizeof(*evt), GFP_KERNEL);
>> +     if (!evt)
>> +             panic("Can't allocate mtk clock event driver struct");
>
> I'm not that sure about the A7s, but on Cortex-A9 there is also a global
> timer which can be used for timing. And there might be other timing
> options for this SOC too. Do you really want to panic?

Yes, A7 has a arm local timer, but the problem is, that it is not
working with the SoC. It seems like a chip design error as I tried for
quite a time to get it working.

Thanks for your comments anyway.

>
>         S?ren



-- 
motzblog.wordpress.com
