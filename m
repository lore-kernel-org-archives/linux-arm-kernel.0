From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Sep 2014 11:16:26 +0800
Subject: [PATCH 3/7] clk: sunxi: unify sun6i AHB1 clock with proper PLL6
 pre-divider
In-Reply-To: <20140911210211.GM31276@lukather>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-4-git-send-email-wens@csie.org>
 <20140911210211.GM31276@lukather>
Message-ID: <CAGb2v66L36nsoucSgLY8pV8f=wjKTvtjJby43Z=Ct+NiRonptQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 12, 2014 at 5:02 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sat, Sep 06, 2014 at 06:47:24PM +0800, Chen-Yu Tsai wrote:
>> This patch unifies the sun6i AHB1 clock, originally supported
>> with separate mux and divider clks. It also adds support for
>> the pre-divider on the PLL6 input, thus allowing the clock to
>> be muxed to PLL6 with proper clock rate calculation.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> It looks fine, but I'd rather see this in a separate file, especially
> since we don't seem to have any order dependency.

Sorry, just to be clear, separate file under clk/sunxi?

This cannot be in a separate file, as it shares a spinlock with apb1
divider. They share the same register.

We could move apb1 out though. But i would prefer to do that when
we split out all the clocks into individual OF_CLK_DECLAREs.

ChenYu
