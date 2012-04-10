From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 11 Apr 2012 06:02:41 +0900
Subject: [PATCH 3/4] arm: davinci: use for_each_set_bit_from
In-Reply-To: <CABkLObr4Vyp9FwxfOquFjqnh1rEaLXNAzBV4SV-PO=UA4EC2vA@mail.gmail.com>
References: <1333442836-9947-1-git-send-email-akinobu.mita@gmail.com>
 <1333442836-9947-3-git-send-email-akinobu.mita@gmail.com>
 <CABkLObr4Vyp9FwxfOquFjqnh1rEaLXNAzBV4SV-PO=UA4EC2vA@mail.gmail.com>
Message-ID: <CAC5umyhu0TRgLhv+bbqRbcfx-hK5pacFt0bYOmzX4gODHt4B-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/4/11 Christian Riesch <christian.riesch@omicron.at>:

>> --- a/arch/arm/mach-davinci/dma.c
>> +++ b/arch/arm/mach-davinci/dma.c
>> @@ -557,9 +557,9 @@ static int reserve_contiguous_slots(int ctlr, unsigned
>> int id,
>> ? ? ? ?if (i == edma_cc[ctlr]->num_slots)
>> ? ? ? ? ? ? ? ?stop_slot = i;
>>
>> - ? ? ? for (j = start_slot; j < stop_slot; j++)
>> - ? ? ? ? ? ? ? if (test_bit(j, tmp_inuse))
>> - ? ? ? ? ? ? ? ? ? ? ? clear_bit(j, edma_cc[ctlr]->edma_inuse);
>> + ? ? ? j = start_slot;
>> + ? ? ? for_each_set_bit_from(j, tmp_inuse, stop_slot);
>
> Is the semicolon at the end of the line correct?

It's clearly a bug that I was going to introduce.  I'll fix and
resend it.

Thanks a lot.

>> + ? ? ? ? ? ? ? clear_bit(j, edma_cc[ctlr]->edma_inuse);
>>
>> ? ? ? ?if (count)
>> ? ? ? ? ? ? ? ?return -EBUSY;
>> --
>> 1.7.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at ?http://www.tux.org/lkml/
>>
