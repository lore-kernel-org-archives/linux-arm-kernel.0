From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 27 Aug 2012 10:36:56 +0200
Subject: [PATCH 1/4] clk: ux500: Adapt PRCMU and PRCC clocks for common clk
In-Reply-To: <201208260447.58396.arnd@arndb.de>
References: <1345807565-7729-1-git-send-email-ulf.hansson@stericsson.com>
 <1345807565-7729-2-git-send-email-ulf.hansson@stericsson.com>
 <201208260447.58396.arnd@arndb.de>
Message-ID: <CAPDyKFqntUxx2Sr=myk42xT2_Gf=dZJQq+ytxph5tYxAFLCVog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2012 06:47, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 24 August 2012, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> First version of common clock implementation of PRCMU clocks
>> and PRCC clocks for ux500 platforms.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Very nice, glad to see you got this working!
>
> I only noticed one thing that you should improve:
>

Thanks for your input. I will send an updated patch.

>> +#define to_clk_prcc(_hw) container_of(_hw, struct clk_prcc, hw)
>> +
>> +struct clk_prcc {
>> +     struct clk_hw hw;
>> +     unsigned int io_base;
>> +     u32 cg_sel;
>> +     int is_enabled;
>> +};
>> +
>> +/* PRCC clock operations. */
>> +
>> +static int clk_prcc_pclk_enable(struct clk_hw *hw)
>> +{
>> +     struct clk_prcc *clk = to_clk_prcc(hw);
>> +     void __iomem *io_base = __io_address(clk->io_base);
>
> In a proper device driver, we should not use hacks like __io_address. Please
> change the driver to ioremap the register area at initialization time, and
> don't pass a physical io_base like above but instead pass an offset into
> the register area.
>
>         Arnd

Kind regards
Ulf Hansson
