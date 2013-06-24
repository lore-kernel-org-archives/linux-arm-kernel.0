From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 24 Jun 2013 20:42:33 +0200
Subject: [PATCH] clk: Handle CLK_GET_RATE_NOCACHE flag in clk_set_rate()
In-Reply-To: <20130621161627.9136.84494@quantum>
References: <1371820055-14147-1-git-send-email-s.nawrocki@samsung.com>
 <20130621161627.9136.84494@quantum>
Message-ID: <51C89319.3080409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 06:16 PM, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2013-06-21 06:07:35)
>> > If a clock has CLK_GET_RATE_NOCACHE flag set the rate needs to
>> > be recalculated, rather than referencing the cached value.
>> > 
>> > Currently cached clk->rate is compared with new value to see if
>> > anything needs to be done in clk_set_rate(). This may cause required
>> > clock controller registers update to not happen when same clock
>> > frequency value is being set subsequently.
>> > 
>> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Peter already sent a patch for this:
> https://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commitdiff;h=34e452a152efd25d654b7bc809df429337115b03

Thanks Mike, that also helps. My apologies for not having
it noticed earlier. I'm going to post a patch for the Exynos
clock driver, which adds missing CLK_GET_RATE_NOCACHE flags to
the ISP clock group and would be really effective together
with the above one.

Thanks,
Sylwester
