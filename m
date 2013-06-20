From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Jun 2013 10:21:37 +0200
Subject: [PATCH 1/2] clk: nomadik: implement the Nomadik clocks properly
In-Reply-To: <20130620063801.9136.80841@quantum>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
 <20130620063801.9136.80841@quantum>
Message-ID: <CACRpkdaxdFaj_gLjDCUXeN047uf-nfmLVfxmMioh9BL6B2JryQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 8:38 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Linus Walleij (2013-06-09 03:55:47)
>> +static void pll_clk_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_pll *pll = to_pll(hw);
>> +       u32 val;
>> +
>> +       return;
>
> Is the early return intentional? Everything else looks good.

Of course not :-)

At one time it had no proper children registered so would
declock the entire system if I didn't have that in... fixed up.

> Acked-by: Mike Turquette <mturquette@linaro.org>

Thanks, sending this to ARM SoC now.

Yours,
Linus Walleij
