From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 06 Sep 2016 13:30:12 +0200
Subject: [PATCH] ARM: dts: exynos: Add entries for sound support on
 Odroid-XU board
In-Reply-To: <05c45777-732b-3701-36dc-2448003acd50@samsung.com>
References: <1471883654-2113-1-git-send-email-s.nawrocki@samsung.com>
 <05c45777-732b-3701-36dc-2448003acd50@samsung.com>
Message-ID: <bc8544f0-6a28-532f-cfdb-7ca28270b662@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2016 08:42 AM, Krzysztof Kozlowski wrote:
>> +&clock {
>> > +       clocks = <&fin_pll>;
> I dig into it and I have some questions:
> 1. Missing clock-names?
> 2. What code parses it?
> 3. Don't we need it also for other SoC/boards?

Apologies, I missed this one.

Ad.1. clock-names is not needed as there will be only one clock and there
is no need to get the clock by name.  If it bothers you we could add e.g.
clock-names = "osc", but IMO it's just an unnecessary complication.

Ad.2 of_clk_get() called from within of_clk_init() and exynos5410_clk_init.

Ad.2. I think it makes sense to add it for all Exynos SoCs where it's missing.

-- 
Regards,
Sylwester
