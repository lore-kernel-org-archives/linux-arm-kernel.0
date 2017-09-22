From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Sep 2017 15:29:53 +0200
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
Message-ID: <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 2:12 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 9/21/17 7:08 AM, Linus Walleij wrote:
>>
>> I guess gpio_valid_mask would take precedence over irq_valid_mask.
>> I.e if the GPIO is not valid then the IRQ is per definition not valid
>> either.
>>
>> Since it is a new thing, we can simply define a semantic like that
>> and document it.
>
> So what about my current patches?

I am waiting for the maintainer, Bjorn Andersson, to provide review.

>  I hope you're not asking me to rewrite
> them again.

I don't understand your remark. If you are impatient, such is life.

What is your response to Stephen's comment:

> [Stephen Boyd]
> Perhaps we can add another hook for our purposes here that
> tells gpiolib that the gpio is not usable and to skip it. The
> semantics would be clear, it's just about probing availability of
> this pin as a gpio and doesn't mux any pins.

I think this kind of related to my response (after I realized it
was not just about IRQs):

> Doesn't that mean we need something like irq_valid_mask but rather
> gpio_valid_mask that just block all usage of certain GPIOs?

Yours,
Linus Walleij
