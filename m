From: superlibj8301@gmail.com (Richard Lee)
Date: Tue, 13 May 2014 09:45:08 +0800
Subject: [RFC][PATCH 2/2] ARM: ioremap: Add IO mapping space reused
 support.
In-Reply-To: <5146762.jba3IJe7xt@wuerfel>
References: <1399861195-21087-1-git-send-email-superlibj8301@gmail.com>
 <1399861195-21087-3-git-send-email-superlibj8301@gmail.com>
 <5146762.jba3IJe7xt@wuerfel>
Message-ID: <CAHPCO9FRfR5p1N5v7mUk4hUYdPvqfLN6nW1LcnC83sU86ZFbZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, May 12, 2014 at 3:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 12 May 2014 10:19:55 Richard Lee wrote:
>> For the IO mapping, for the same physical address space maybe
>> mapped more than one time, for example, in some SoCs:
>> 0x20000000 ~ 0x20001000: are global control IO physical map,
>> and this range space will be used by many drivers.
>> And then if each driver will do the same ioremap operation, we
>> will waste to much malloc virtual spaces.
>>
>> This patch add IO mapping space reused support.
>>
>> Signed-off-by: Richard Lee <superlibj@gmail.com>
>
> What happens if the first driver then unmaps the area?
>

If the first driver will unmap the area, it shouldn't do any thing
except decreasing the 'used' counter.

Thanks,

BRs
Richard Lee


>         Arnd
