From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Feb 2014 11:36:08 +0100
Subject: [PATCH 08/17] spi: pl022: Fully gate clocks at request inactivity
In-Reply-To: <20140204170746.GD22609@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-9-git-send-email-ulf.hansson@linaro.org>
 <20140204170746.GD22609@sirena.org.uk>
Message-ID: <CAPDyKFraQUcZ_LjSAwENQA_RVqXokKKgfOZh7WD1vKmJ+5KstQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2014 18:07, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 04, 2014 at 04:58:49PM +0100, Ulf Hansson wrote:
>> Use clk_disable_unprepare and clk_prepare_enable from the runtime PM
>> callbacks, to fully gate|ungate clocks. Potentially this will save more
>> power, depending on the clock tree for the current SOC.
>
> The same patch has already been applied (I noticed and fixed it while
> doing unrelated code review).

Sorry, didn't notice that.

Thanks!

Kind regards
Ulf Hansson

>
>>       pinctrl_pm_select_default_state(dev);
>> -     clk_enable(pl022->clk);
>> +     clk_prepare_enable(pl022->clk);
>
> Someone should really make this check errors though!
