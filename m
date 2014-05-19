From: gioh.kim@lge.com (Gioh Kim)
Date: Mon, 19 May 2014 18:21:49 +0900
Subject: [RFC PATCH] ARM: cache-l2x0: add setup entry for l2 in non-secure
 mode
In-Reply-To: <CAGsJ_4wF7_BmTrWoxAu+NMVpsuN4oxJngBW0b2-4naXtwx5g5g@mail.gmail.com>
References: <5374532D.7030602@lge.com>
 <CAGsJ_4zN39jeHz574_r9y_hjdn1Acbkr9gQhE=1L-Fs82-vDkw@mail.gmail.com>
 <53795080.1010007@lge.com>
 <CAGsJ_4wF7_BmTrWoxAu+NMVpsuN4oxJngBW0b2-4naXtwx5g5g@mail.gmail.com>
Message-ID: <5379CD2D.4080300@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2014-05-19 ?? 6:11, Barry Song ? ?:
> 2014-05-19 8:29 GMT+08:00 Gioh Kim <gioh.kim@lge.com>:
>>
>>
>> 2014-05-18 ?? 10:13, Barry Song ? ?:
>>
>>> 2014-05-15 13:39 GMT+08:00 Gioh Kim <gioh.kim@lge.com>:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> My board is using Trustzone and running kernel is non-secure mode.
>>>> But setup function of PL310 driver is only for secure mode kernel.
>>>>
>>>> What about adding an entry for non-secure mode setup function?
>>>>
>>>> I'm sorry for my poor code but I just wanna say what I need .
>>>
>>>
>>> Gioh,
>>>
>>> i don't really understand what is the user scenarios for this, if you
>>> are running linux in non-secure mode, your security-mode codes have
>>> enabled L2, so this makes non-secure linux have no chance to execute
>>> setup at all:
>>
>>
>> My platform runs linux kernel before L2 cache activation.
>> And the L2 cache is activated when the kernel sends command to Trustzone
>> firmware.
>> At this moment L2 is not activated. Linux should send command for L2
>> activation to Trustzone at the moment.
>
> i think you can send command to trustzone firmware to enable L2 at
> first, then make your Linux l2 driver run.

Right. My platform is working like that.
Activate L2 first and run l2x0 driver.

But I think many platforms have trustzone firmware and are working like my platform.
They might need non-secure setup.

>
>
> -barry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
