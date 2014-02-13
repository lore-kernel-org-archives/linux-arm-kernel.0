From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 13 Feb 2014 15:12:49 +0100
Subject: [PATCH 14/17] i2c: nomadik: Fixup deployment of runtime PM
In-Reply-To: <CAPDyKFrWgB8z1rtWxU7AYvVsmNj_pfGbsozwgP_FzLODpmGRwQ@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-15-git-send-email-ulf.hansson@linaro.org>
 <CACRpkdZwoXf5ovmQEAN6Ugvz91+_i5uGqStR3MGXQeJGHitj3Q@mail.gmail.com>
 <CAPDyKFrWgB8z1rtWxU7AYvVsmNj_pfGbsozwgP_FzLODpmGRwQ@mail.gmail.com>
Message-ID: <CAPDyKFq_k7dRjuf+XW=DDkM1K2EJ_4vAAs0tTrd+WbUxqxP-tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2014 11:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 5 February 2014 15:34, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Feb 4, 2014 at 4:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>> Since the device is active while a successful probe has been completed,
>>> the reference counting for the clock will be screwed up and never reach
>>> zero.
>>>
>>> The issue is resolved by implementing runtime PM callbacks and let them
>>> handle the resources accordingly, including the clock.
>>>
>>> Cc: Alessandro Rubini <rubini@unipv.it>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Hm do I read it right as patch 13 breaks runtime PM by leaving
>> the device active after probe() and this patch
>> 14 fixes it again? Maybe these two patches should be squashed
>> then.

In v2 I have now squashed patch 13 into this patch 14.

That means patch13 shall be dropped from this patchset.

Kind regards
Uffe

>
> You are right; but the driver will still be working, you just don't
> get the benefit from inactivating the device at request inactivity -
> as you pointed out.
>
> The reason for why I wanted to do this as separate steps was to make
> it easier for reviewing, otherwise the patch(es) would have been quite
> big and messy. I am for sure open to  adopt to your proposal, but just
> wanted to give you some more background, before I go ahead and send a
> v2.
>
> Kind regards
> Ulf Hansson
>
>>
>> Yours,
>> Linus Walleij
