From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 9 Jan 2012 00:40:08 +0300
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <201201081140.29275.marek.vasut@gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201080956.51789.marek.vasut@gmail.com>
 <CA+E=qVfYMwV_TuAdaDAZVfQfcx5-g-JEr1tUQsuwBcPpvCav+g@mail.gmail.com>
 <201201081140.29275.marek.vasut@gmail.com>
Message-ID: <CA+E=qVcJtT9L0kkRT2NAw1Sefeje9vRjqCSLQbm=Z=X4AO+Law@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/8 Marek Vasut <marek.vasut@gmail.com>:
>> 2012/1/8 Marek Vasut <marek.vasut@gmail.com>:
>> > That's why I said this patch (suspend the device to make it feel like
>> > powerdown) is bullshit in the first place.
>>
>> Marek, 'deepsleep' suspend on Z2 is a way to save battery power for
>> monthes. I blew the dust off my Z2 recently (did not touch it for
>> ~2monthes), it was in fake poweroff (deepsleep), and battery is still
>> charged (not full however). I believe it can't be achieved with
>> 'sleep' suspend.
>
> But you can put the device into this deepsleep-suspend without faking shutdown,
> right?

Nope, it does not work. Looks like device disables power on memory in deepsleep.

>> I agree that it looks weird, but it's hardware bizzarity. Btw, do you
>> have suggestions how to make it clean?
>
> Yea ... why won't deepsleep suspend work via standard suspend interface?

Just because it's not possible :)

Regards
Vasily
