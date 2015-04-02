From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 2 Apr 2015 19:27:24 +0300
Subject: [PATCH 1/3] mfd: ucb1x00: add irq field to the platform data
In-Reply-To: <20150402160252.GO24899@n2100.arm.linux.org.uk>
References: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
 <20150402160252.GO24899@n2100.arm.linux.org.uk>
Message-ID: <CALT56yM-JSN=8KR3EUFAa+k4ZZkqXY9zgwzT2PhRn23dMUc3rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2015-04-02 19:02 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Just like has already been pointed out on the list once today, we need
> much better commit descriptions than this.
>
> The code has been perfectly happy to auto-detect the IRQ for over ten
> years.  Why do we suddenly need to change it now?  What's the
> justification for this change.

Because using static configuration would allow me to drop a nice piece
of code. Because it would allow later to use dts to describe ucb1x00
configuration. Because I will no longer have to think whether ucb1x00I h
driver barfing on IRQ is a problem of a chip, of an IRQ or just me having
touched wrong GPIO line at wrong time with a scope probe. Yes, I didn't
put all these causes to the commit description. Do you really want it?

>
> Or is this just a case of "because we can" and you happen to have a
> different opinion on how stuff should be done from how it's been
> successfully done for the last ten years?

Not only "because we can", but "because we should". In my humble
opinion.

It looks like the whole story of me touching sa1100 is like fighting with
'it was done so for ages' windmills. Yes, I have different opinions sometimes.
I would like for sa1100 to converge to other platforms. PXA, especially.
Why? Because I like several small devices sitting on my table. PXA
is now slowly moving towards dts, cleaner drivers and cleaner interfaces.
We should have done this ages ago. Nobody had time and interest.
SA-11x0 had even older drivers. Older implementations. Older ideas.
Yes, I have a different opinion at this place. I'd like for sa1100 to live
in a contemporary world. I'd like to have my devices work with the rest
of Linux subsystems. Should I just fork sa1100 subarch, make it work
with devices I have at hand and submit it as a 'new' subarch?
Or we can have an evolution-like process that will make sa1100 live
in style with the rest of the Linux kernel.

>
> On Thu, Apr 02, 2015 at 06:41:45PM +0300, Dmitry Eremin-Solenikov wrote:
>> To allow boards to specify the irq that is used by UCB1x00 chip, add irq
>> field to the platform data structure.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  include/linux/mfd/ucb1x00.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
>> index e1345ff..9a2dacb 100644
>> --- a/include/linux/mfd/ucb1x00.h
>> +++ b/include/linux/mfd/ucb1x00.h
>> @@ -118,6 +118,7 @@ struct ucb1x00_plat_data {
>>       unsigned                irq_base;
>>       int                     gpio_base;
>>       unsigned                can_wakeup;
>> +     int                     irq;
>>  };
>>
>>  struct ucb1x00 {
>> --
>> 2.1.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.



-- 
With best wishes
Dmitry
