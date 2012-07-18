From: sedat.dilek@gmail.com (Sedat Dilek)
Date: Wed, 18 Jul 2012 19:54:46 +0200
Subject: linux-next: Tree for July 17 (mfd: AB3100 - ab3100_probe:
 undefined reference to `rand_initialize_irq')
In-Reply-To: <CACRpkdbAnBza0Nd4Qw_LinRDa4XVuzUdJFX==YeML2z7H6gzwg@mail.gmail.com>
References: <CA+icZUXjc+13YjoJ6FjDFboX20j3mqHNtvV2Av2-H0My8V2Mgg@mail.gmail.com>
 <CA+icZUW4gNqspcJ1sjBD-3GCVee2VWVV5NPAr6Eo-aZHjp3y+Q@mail.gmail.com>
 <CA+icZUW+Gp9HK-6dzHjtTwSc9RaLD3sV+WPMM-vO3A6fj6frwQ@mail.gmail.com>
 <CACRpkdbAnBza0Nd4Qw_LinRDa4XVuzUdJFX==YeML2z7H6gzwg@mail.gmail.com>
Message-ID: <CA+icZUWzS==NVNstc3RUfKe-=4UVtAza36LuFRuAp-zeX=5WyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 8:40 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 17, 2012 at 12:39 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On Tue, Jul 17, 2012 at 12:21 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>> ...looks like AB3100 is the *only* driver still using rand_initialize_irq()...
>>>
>>> drivers/mfd/ab3100-core.c:939:  rand_initialize_irq(client->irq);
>>>
>>> ...but why has random.h still this...?
>>>
>>> include/linux/random.h:51:extern void rand_initialize_irq(int irq);
>>>
>>> Just thinking "loud"...
>>>
>>> - Sedat -
>>
>> Is this attached patch OK, Ted?
>
> You're just deleting a line from the AB3100 driver, so I guess you're
> regressing the system since that IRQ will no longer contribute
> to the entropy pool?
>
> How do we simultaneously make sure that this IRQ is still
> contributing to the entropy?
>

For the sake of completeness:
* Ted explained in his answer in [1].
* Just FYI: [2] has these changes merged into the original commit.

- Sedat -

[1] http://marc.info/?l=linux-next&m=134256445707799&w=2
[2] http://git.kernel.org/?p=linux/kernel/git/tytso/random.git;a=commitdiff;h=627574db8b21c51217c683909458500916e64963

> Yours,
> Linus Walleij
