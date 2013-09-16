From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 16 Sep 2013 16:11:35 -0700
Subject: [PATCH 1/2] mtd: atmel_nand: remove unneeded ifdef CONFIG_OF
In-Reply-To: <CAOesGMjYUOerSSZvM6VVLQNQP=Dft6CwNELqP9tyT=Hz0-2qLQ@mail.gmail.com>
References: <1378200028-15415-1-git-send-email-josh.wu@atmel.com>
 <20130911230207.GE4550@ld-irv-0074.broadcom.com>
 <5232DAAD.4020700@atmel.com>
 <20130913182144.GF4550@ld-irv-0074.broadcom.com>
 <CAOesGMjczRxKhDS9W9SZk4ivuxEsn0Mp6j0Xotz+qZgoKO4=xg@mail.gmail.com>
 <CAN8TOE965=_HfK0aqB6oUWF66xXZEdwFR8AL9KcwRmQ0AWmisg@mail.gmail.com>
 <CAOesGMjYUOerSSZvM6VVLQNQP=Dft6CwNELqP9tyT=Hz0-2qLQ@mail.gmail.com>
Message-ID: <CAN8TOE85D=JOU7f5+p6nTFgbCh0SZa+kfBNWD9rmDPxOZ9aEig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 3:54 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Sep 16, 2013 at 3:50 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
>> On Mon, Sep 16, 2013 at 3:28 PM, Olof Johansson <olof@lixom.net> wrote:
>>> Guys,
>>> Can we please get less fumbling around on this and just merge a fix,
>>> please? You guys have broken the PXA3xx builds for the whole merge
>>> window, while there's been a patch sitting in linux-next with
>>> _exactly_ this contents since August 30, committed by David.
>>
>> How about you read the thread you're responding to? This is a
>> different driver, and it is not broken.
>
> Ah, oops, my apologies. I came across this when searching for the
> (committed) patch in my mail history and didn't notice the driver name
> differences. :)

Unacceptable. Humans never make mistakes. ;)

>> If you look at the thread for the patch which fixes the actual
>> breakage (in pxa3xx), you will see a plain and clear explanation of
>> the situation.
>>
>> http://lists.infradead.org/pipermail/linux-mtd/2013-September/048595.html
>> http://lists.infradead.org/pipermail/linux-mtd/2013-September/048598.html
>>
>> David has been sufficiently notified, and he is not acting. I have
>> even pinged him on our IRC channel, with no response, although I'm not
>> surprised.
>>
>> (BTW, I assume the "committed by David" is simply because of
>> git-rebase. It doesn't necessarily reflect his acknowledgment of the
>> patch. I can only assume that it was an oversight on his part.)
>
> That in itself seems broken; if he is pulling code from you he shouldn't rebase.

Well, the repo I commit to (l2-mtd.git) was originally Artem's
creation and was intended to collect things that had been reviewed,
allowing David a last chance to review and reject or Sign-Off (or in
this case, break) patches. We haven't traditionally stuck to the "once
it's in git, it's permanent" philosophy, and I'm not sure of my
opinion of it. It may or may not have prevented this error, as I am
not sure why David left this patch out in the first place.

>> Anyway, I don't care if the patch goes in via another tree, as long as
>> this debacle (notably, for the pxa3xx_nand driver, not the atmel_nand
>> driver) is resolved.
>
> Ok. Russell was asking what the status of the fix was as well. I'll
> queue it up with our current fixes for -rc2.

Sounds good.

Brian
