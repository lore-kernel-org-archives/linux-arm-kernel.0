From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Sun, 16 Feb 2014 14:44:07 +0100
Subject: [PATCH V2 11/17] i2c: nomadik: Convert to devm functions
In-Reply-To: <20140215150345.GD2579@katana>
References: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
 <20140215150345.GD2579@katana>
Message-ID: <CAPDyKFrt6QJVSypP5iD_oVxRUvNhzxGcbZ703zR1K8gwJ5uCeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2014 16:03, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Feb 13, 2014 at 03:09:02PM +0100, Ulf Hansson wrote:
>> Use devm_* functions to simplify code and error handling.
>>
>> Cc: Alessandro Rubini <rubini@unipv.it>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Changes in v2:
>>       Rebased on top of latest i2c-nomadik branch.
>
> Since this depends on Linus' patch already, I think it would be cleaner
> if I pick this kinda unrelated (but wanted) devm patch, and ack the
> PM stuff. If this for some reason makes things more complicated, I can
> also simply ack this one.

I think we will end up having merge conflicts, especially for the
changes in the probe function if we decide to split it.

Would a way forward be to let you carry all the patches through your
tree? I believe all but patch 17 can be safely merged. It is only this
one that depends on the changes in the amba bus, so we can put this
one on hold for a while.

Another option would be if you drop Linus' patch from you branch and
let him collect all the patches in a pull request instead?

I happy with whatever we thinks are easiest. :-)

>
>> -     dev->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
>> +     dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
>> +                             resource_size(&adev->res));
>>       if (!dev->virtbase) {
>>               ret = -ENOMEM;
>
> IS_ERR()!

Will fix in a v2!

>

Thanks!

Kind regards
Ulf Hansson
