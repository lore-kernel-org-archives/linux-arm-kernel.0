From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Sun, 13 Oct 2013 12:25:35 +0530
Subject: [PATCH] ARM: davinci: convert to clockevents_config_and_register
In-Reply-To: <5259772A.3050704@ti.com>
References: <1380060159-12008-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5259772A.3050704@ti.com>
Message-ID: <CA+V-a8v58_ixJ5s5d+tsf19qszD2tLGe8465kfQBKivRV+vRoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 10/12/13, Sekhar Nori <nsekhar@ti.com> wrote:
> On Wednesday 25 September 2013 03:32 AM, Uwe Kleine-K?nig wrote:
>> clockevents_config_and_register is superior compared to setting
>> shift/mult and {min,max}_delta_ns by hand.
[snip]
>>
>> +		davinci_clock_tick_rate, 1200, 0xfffffffe);
>
> Min ticks can be set to 1, IMO. I think the 50usec limit used earlier
> should have actually been 50ns assuming a 24MHz clock.
>
> Prabhakar,
>
> Can you please test this patch on a DaVinci platform you have with 1200
> replaced with 1. I currently do not have access to a board.
>

I have boot tested this patch on OMAP-L138 and tested the uptime
(with min ticks set to 1), should that be enough ?

Thanks,
--Prabhakar Lad
