From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jan 2013 09:35:18 -0700
Subject: [PATCH v4 2/9] clk: tegra: Add tegra specific clocks
In-Reply-To: <20130117.070327.1625310713330263780.hdoyu@nvidia.com>
References: <1357890387-23245-3-git-send-email-pgaikwad@nvidia.com><20130116.171242.2189136612266237422.hdoyu@nvidia.com><50F7096C.7020803@wwwdotorg.org>
 <20130117.070327.1625310713330263780.hdoyu@nvidia.com>
Message-ID: <50F82846.2030008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 10:03 PM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 16 Jan 2013 21:11:24 +0100:
> 
>>>> +static int clk_frac_div_set_rate(struct clk_hw *hw, unsigned long rate,
>>>> +                               unsigned long parent_rate)
>>>> +{
>>>> +       struct tegra_clk_frac_div *divider = to_clk_frac_div(hw);
>>>> +       int div;
>>>> +       unsigned long flags = 0;
>>>
>>> nit, is "flags" not needed to initialize here?
>>
>> It avoids a compiler warning; the compiler doesn't that the if condition
>> that guards the path that uses flags is the same condition as the path
>> that initializes it. Or, it may be related to the fact that
>> spin_lock_irqsave() writes to the value through a pointer parameter, and
>> the compiler doesn't know it's an out-only parameter.
> 
> It might be better to append the special comment /* GCC */[1] on that line.
> 
> [1] https://lwn.net/Articles/529954/

I note that patch hasn't actually been merged though, so I think I'll
avoid doing that for now.
