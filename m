From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 08:59:30 +0200
Subject: [PATCH] mmc: mmci: switch the driver to using gpio descriptors
In-Reply-To: <CAPDyKFq8TGsHQixYJwtPGkr0HS8r1-B0LZWsO9DKYH+gTq_Dgg@mail.gmail.com>
References: <1397550786-8146-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFq8TGsHQixYJwtPGkr0HS8r1-B0LZWsO9DKYH+gTq_Dgg@mail.gmail.com>
Message-ID: <CACRpkdZHbxYvHbxrTzZ_k=U9sUNjh86GkwUiEjM5cZXM3WyfEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 9:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 15 April 2014 10:33, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The next step in modernization of GPIO is to let drivers handle
>> descriptors rather than integer numbers representing GPIO pins,
>> akin to how clocks or regulators are already handled today.
>>
>> This patch makes the MMCI driver use GPIO descriptos in the
>> core code with fallback code using the platform data if that
>> is not possible. After all platforms with MMCI have been
>> migrated to use descriptors, the platform data entries for
>> GPIO pins can be removed.
>>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi Russell,Ulf: there is no hurry to do these changes (only used
>> for my very corner-case MMCI PL181 experiments) but it's the
>> desired direction to use descriptors for GPIOs going forward.
>> I can rebase this on top of Ulf's patch stack any time, no
>> problem.
>
> If you rebase it on top of my patch stack - I can resend the pull
> request I sent a few days ago and include this one!?

There is no hurry. I'd let Russell think about your recent patches
first and I will keep this patch on my watchlist until things
settle down.

Yours,
Linus Walleij
