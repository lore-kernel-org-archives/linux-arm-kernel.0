From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Sep 2017 14:08:33 +0200
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
Message-ID: <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 3:04 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 9/20/17 6:43 AM, Linus Walleij wrote:
>>
>> Doesn't that mean we need something like irq_valid_mask but rather
>> gpio_valid_mask that just block all usage of certain GPIOs?
>
>
> That raises a lot of questions.  In the meantime, my current patches for
> 4.14 work fine.
>
> Do we replace irq_valid_mask with gpio_valid_mask?  That would break drivers
> where the GPIO is valid but the interrupt is not.  If we keep both, what
> happens if gpio_valid_mask is false but irq_valid_mask is true?  And then we
> would need to audit all gpio drivers to see which ones should be updated for
> the new infrastructure.

I guess gpio_valid_mask would take precedence over irq_valid_mask.
I.e if the GPIO is not valid then the IRQ is per definition not valid either.

Since it is a new thing, we can simply define a semantic like that
and document it.

Yours,
Linus Walleij
