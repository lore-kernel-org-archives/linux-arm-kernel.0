From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jun 2017 13:31:55 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <20170612210248.GP20170@codeaurora.org>
References: <20170524082044.8473-1-linus.walleij@linaro.org>
 <20170601070208.GO20170@codeaurora.org>
 <CACRpkdZv8MzXVecEXVdJ+P0MxVscYSy=MxC-yQAR0S4yQ6-rwQ@mail.gmail.com>
 <20170605195812.GH20170@codeaurora.org>
 <CACRpkdbya9xaN-i7AkG0bTyuFYfZc59sSTYhWB43=9btSKfPpQ@mail.gmail.com>
 <CACRpkdapAgHix2vw-woDFi4sh+H3_EX7w-5q=opBGMyegFrXbA@mail.gmail.com>
 <20170612210248.GP20170@codeaurora.org>
Message-ID: <CACRpkdbF4syppZsFv2hbB1JxHvnndbS53yY8Pkbz2zoq5Jjzjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 11:02 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/12, Linus Walleij wrote:

>> So the deferred clock makes the whole platform hang because the timer
>> needs it. Without a clocksource, the delay loop cannot be calibrated, so
>> it hangs there.
>
> Ok. So can the certain clks that are required to get the timer
> going be put into CLK_OF_DECLARE_DRIVER() and then have a regular
> platform driver for the rest of the clks that aren't required for
> early boot? We've been doing this sort of hybrid design lately,
> so hopefully that works here too.

Sure I will give it a spin!

Is there a best-in-class driver doing this I can use as inspiration?

Yours,
Linus Walleij
