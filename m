From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 31 Mar 2014 08:00:18 -0700
Subject: [PATCH] clk: reverse default clk provider initialization order in
 of_clk_init()
In-Reply-To: <20140329084147.5762.51815@quantum> (Mike Turquette's message of
 "Sat, 29 Mar 2014 01:41:47 -0700")
References: <1395917012-23483-1-git-send-email-s.nawrocki@samsung.com>
 <20140329084147.5762.51815@quantum>
Message-ID: <7h1txi76rh.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette <mturquette@linaro.org> writes:

> Quoting Sylwester Nawrocki (2014-03-27 03:43:32)
>> This restores the default clocks registration order as parsed from
>> devicetree, i.e. as before commit 1771b10d605d26ccee771a7fb4b08718
>> "clk: respect the clock dependencies in of_clk_init", for when there
>> is no explicit parent clock dependencies between clock providers
>> specified in the device tree.
>> 
>> It prevents regressions (boot failure, division by 0 errors) on
>> imx and exynos platforms.
>> 
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> I pulled this into clk-next but it didn't seem to get picked up by
> linux-next in time for today's build. Let's test the next linux-next to
> insure that the regressions are gone. If not then I'll likely need to
> drop "clk: respect the clock dependencies in of_clk_init" from clk-next
> for 3.15.

It looks like all the boot failures caused by this problem are gone as
of next-20140331[1], so it looks good to me.

Kevin

[1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-March/002988.html
