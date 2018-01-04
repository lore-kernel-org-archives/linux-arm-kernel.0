From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Jan 2018 17:04:14 +0100
Subject: [PATCH v2] soc: Add SoC driver for Gemini
In-Reply-To: <20171221231908.9664-1-linus.walleij@linaro.org>
References: <20171221231908.9664-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a3D+QQetSQ7i+yepW_bh8hEw0nzhO7CxCL0ECc3HY-GaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 12:19 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This adds an SoC driver for the Gemini. Currently there
> is only one thing not fitting into any other framework,
> and that is the bus arbitration setting.
>
> All Gemini vendor trees seem to be setting this register to
> exactly the same arbitration so we just add a small code
> snippet to do this at subsys_init() time before any other
> drivers kick in.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add a multiplatform guard, bail out silently if we are not
>   running on Gemini.
>
> ARM SoC folks: please just apply this patch directly somewhere
> if you're pleased with it, it is fully idependent.

Applied to next/soc, thanks!

> Arnd wanted some rewording of the commit message but I can't
> figure out what, please entertain yourself editing it any way
> you like :)

The patch commit message is fine, the part I wanted to have
reworded was the "SoC driver for the Gemini. See the commit
for details." text in the pull request that did not seem right as
a git changelog message. As I applied the patch by itself now,
it's all good.

      Arnd
