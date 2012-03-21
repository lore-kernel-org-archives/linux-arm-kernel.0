From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 21 Mar 2012 13:46:28 +0800
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <CAJOA=zOZ=XNwhEwUSD34AERi+f8fnMqG9EmS5hxCx+2u8qnkgw@mail.gmail.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <20120320140220.GE32469@S2101-09.ap.freescale.net>
 <CAJOA=zOZ=XNwhEwUSD34AERi+f8fnMqG9EmS5hxCx+2u8qnkgw@mail.gmail.com>
Message-ID: <CAAQ0ZWRyowjHvR0_T-cA8UmbMNpo6yd6OLJ_HPh4foVULF0Tyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2012 07:46, Turquette, Mike <mturquette@ti.com> wrote:
...
> As mentioned above, you'll still need to check for CLK_SET_RATE_PARENT
> in your .round_rate implementation with __clk_get_flags(hw->clk).
>
For my particular case, the clk is PLL with fixed rate clk
(oscillator) as parent.  It's known that flag CLK_SET_RATE_PARENT will
never be set for this type of clks.

> Did you want to send a formal patch or just have me absorb this into
> the fixes I'm brewing already? ?I've already fixed the potential null
> ptr dereferences in clk_calc_new_rates, but that's no big deal.
>
The code was attached for better discussion, and I would leave the
formal patch to you.

Regards,
Shawn
