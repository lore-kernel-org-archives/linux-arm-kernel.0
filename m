From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Jun 2017 00:00:20 +0200
Subject: [PATCH 1/2] reset: add DT bindings header for Gemini reset
 controller
In-Reply-To: <1495615846.3840.19.camel@pengutronix.de>
References: <20170524081908.8255-1-linus.walleij@linaro.org>
 <1495615846.3840.19.camel@pengutronix.de>
Message-ID: <CACRpkdbN5uM1Ecvi1CBsQtehQw2CakZjJbPASgBn0HMsAsLb+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 10:50 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Wed, 2017-05-24 at 10:19 +0200, Linus Walleij wrote:
>> This adds the DT binding macros used by the reset controller.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Philipp: please merge this into the reset subsystem once
>> you're happy with it. Sorry for the back-and-forth. I will
>> deal with the ARM SoC DTS landing orthogonally.
>
> No problem, applied both to the reset/next branch.

If the clk people decide to merge the combined clock+reset
controller driver, please revert the reset driver (the second
patch).

Please do *not* revert the first patch (with the
bindings) because I do not know what happens if branch
A puts it in, then branch B also put it in and a later
version of A say A' reverts its own addition. I don't
think git would cope, so please just leave it in.

Yours,
Linus Walleij
