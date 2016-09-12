From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Sep 2016 11:05:41 +0200
Subject: [PATCH v2] gpio/gpiolib: Forbid irqchip default trigger if probed
 over DT
In-Reply-To: <57D19C2C.2050906@arm.com>
References: <1473235931-19079-1-git-send-email-marc.zyngier@arm.com>
 <CACRpkdbXkbNq5JnM83doZMt5H_JSd-1fQ_kbv_k3HAe2QM71yA@mail.gmail.com>
 <57D19C2C.2050906@arm.com>
Message-ID: <CACRpkdb0acf-fnSCzkeYGnX5oHGN3Z6Ywhby=44PxNdDjZZ4vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 7:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 07/09/16 23:18, Linus Walleij wrote:
>> On Wed, Sep 7, 2016 at 10:12 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>>> Using a default trigger is a bad idea if using DT to configure
>>> interrupts, as the device's interrupt specifier will always contain
>>> the trigger configuration.
>>>
>>> Let's warn about that particular situation, and revert to not
>>> having a default. Hopefully, the couple of drivers still using
>>> this feature will quickly be fixed.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>> Send the tested patch this time around...
>>
>> I got it the first time, don't worry :D
>
> Errrr, the first one didn't even compile (I'm such a moron sometimes).
> Please apply this one instead, which has actually been compile-tested.
>
> Sorry for the noise.

Sending premature patches is human.

Backed the buggy one out and applied this instead!

Yours,
Linus Walleij
