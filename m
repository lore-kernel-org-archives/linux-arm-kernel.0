From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 May 2012 11:11:05 +0200
Subject: [PATCH 06/15] mfd/ab8500: Remove confusing ab8500-i2c file and
 merge into ab8500-core
In-Reply-To: <4FB0C52E.9030109@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdanG7KgYuZw29KwZe7wRp-AVZJ9n_hwBEZzf5gDAbGneg@mail.gmail.com>
 <4FB0C52E.9030109@linaro.org>
Message-ID: <CACRpkda3wWJ2tV2EE+avMtKQbge0gsLuQnutDETm-MnERgZx1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 10:41 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 09/05/12 13:20, Linus Walleij wrote:

>> (...)
>> +static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data)
>> +static int ab8500_i2c_read(struct ab8500 *ab8500, u16 addr)
>>
>> As you might have noticed, many people have been confused by
>> the "i2c" naming of these things. Yes, there is physically an I2C
>> carrying these out but in Linux terms that's just confusing, it's mixing
>> hardware and software terminology. Take this opportunity to
>> rename them:
>>
>> static int ab8500_prcmu_write(struct ab8500 *ab8500, u16 addr, u8 data)
>> static int ab8500_prcmu_read(struct ab8500 *ab8500, u16 addr)
>>
>> etc, so they have a meaningful name.
>
>
> Again, something that I'm happy to do, and again something I'd like to do as
> a separate patch (I'll create a patch-set with this and your other
> 'clean-up' requests if that's okay with you?)

Sure, what I worry about is that it needs to happen, whether it's done
in 1,2 or 50 patches is just mechanics, as long as the patches are sent.

And Sam can always squash them if they get too plentiful :-)

Yours,
Linus Walleij
