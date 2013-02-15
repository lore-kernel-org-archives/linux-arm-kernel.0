From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 21:52:23 +0100
Subject: [PATCH 3/6] dma: coh901318_lli: avoid unbalanced locking
In-Reply-To: <CAHp75VcT-3UUYZSc_iopH8M7z0GoYKhkf-O1yTsqSODRHaCHdw@mail.gmail.com>
References: <1360666720-19006-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1360666720-19006-4-git-send-email-andriy.shevchenko@linux.intel.com>
 <CACRpkdZ=9pmutR2G+z5kQpjx2O6995OnDU8iN3cqar3TWoX=Lg@mail.gmail.com>
 <CAHp75VcT-3UUYZSc_iopH8M7z0GoYKhkf-O1yTsqSODRHaCHdw@mail.gmail.com>
Message-ID: <CACRpkdYVG6pHJ-_MQ2bTmk-rd7XUDkx1aXUW-Eqf6z2O16irYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 3:56 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 15, 2013 at 4:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Feb 12, 2013 at 11:58 AM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>
>>> I have not checked the code but there is a possibility that custom pool->lock
>>> is not needed at all due to dma_pool contains it's own lock.
>>
>> Can you please change the description to something like:
>>
>> "The coh901318_lli allocator releases a lock on the exit path without
>> taking it first".
>
> In v2 (that by fact already applied) I put following description:
>
>     In case the len is 0 we must return without trying to unlock the
> lock that was
>     not locked.
>
> Does it fit your suggestion?

Sure, acked-by.

Thanks,
Linus Walleij
