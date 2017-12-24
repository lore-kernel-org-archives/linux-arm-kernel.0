From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sun, 24 Dec 2017 01:55:04 -0300
Subject: [PATCH v2 3/5] mtd: nand: replace pxa3xx_nand driver by its
 rework called marvell_nand
In-Reply-To: <87bmipb10z.fsf@belgarion.home>
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-4-miquel.raynal@free-electrons.com>
 <87608ycwx5.fsf@belgarion.home>
 <20171222230444.2c952ea0@bbrezillon> <87bmipb10z.fsf@belgarion.home>
Message-ID: <CAAEAJfCFCAAeWNzK3+TTn3qq3-p1aQYZnJ=e4nf8SZ=T1qouKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 December 2017 at 18:13, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
>
>>> What I would propose instead is :
>>>  - keep both the new marvell nand driver and the old pxa3xx_nand driver
>>>  - switch pxa_defconfig to compile them both
>>
>> Didn't notice you were suggesting to compile both, which doesn't work
>> because both drivers match the same devices, and only one of them
>> can actually claim the device (likely the first one to register to the
>> device model). So, to make it safe you need to have a
>>
>>       depends on !MTD_NAND_PXA3xx
>>
>> in your MTD_NAND_MARVELL entry, which means only one driver can be
>> compiled.
> Mmm... that is I didn't explain to you what pxa_defconfig is designed for.
> This defconfig is not for any board actually, it rather is a build coverage
> tool.
>
>> So let's find a way to fix the remaining issues you have instead of delaying
>> the inevitable.
> It's up to you of course, as long as my boards don't break, and nothing breaking
> them is merged, I'm fine with it. It's just not the approach I usually choose,
> I'm rather a 2-step guy, ie. merge the new one, then merge the switch (which can
> be reverted easilly).
>

I agree with Boris on this. Let's get this new driver tested as much
as possible; then, once everyone is fairly happy with it, merge it.

It won't be completely stable on day-one, but that is why we
have -rc cycles. Plus, distributions and appliances use -stable.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
