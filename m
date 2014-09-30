From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 30 Sep 2014 23:56:24 +0800
Subject: [PATCH v2 1/7] clk: sunxi: Specify number of child clocks for
 divs clocks
In-Reply-To: <20140930154043.GN4081@lukather>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
 <1411807795-6575-2-git-send-email-wens@csie.org>
 <20140930154043.GN4081@lukather>
Message-ID: <CAGb2v64RPi2J4gpWu7X15xSx89guPSoEs2_7Bxs9ywj023fabA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 11:40 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Sep 27, 2014 at 04:49:49PM +0800, Chen-Yu Tsai wrote:
>> Currently sunxi_divs_clk_setup assumes the number of child clocks
>> to be the same as the number of clock-output-names, and a maximum
>> of SUNXI_DIVS_MAX_QTY child clocks.
>>
>> On sun6i, PLL6 only has 1 child clock, but the parent would be used
>> as well, thereby also having it's own clock-output-names entry. This
>> results in an extra bogus clock being registered.
>
> Isn't PLL6 having two childs as well?

No. It has one child, the normal PLL6 output clock.

The last "clock-output-names" entry refers to the factors clock itself,
in this case, the 2x clock output.

ChenYu
