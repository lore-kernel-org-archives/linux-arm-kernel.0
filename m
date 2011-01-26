From: ccross@android.com (Colin Cross)
Date: Tue, 25 Jan 2011 19:21:21 -0800
Subject: [PATCH v2 28/28] ARM: tegra: clock: Add forward reference to
	struct clk
In-Reply-To: <AANLkTimKqkKFuKCKPV2jSjUtPqo4tbonwR1iO2rsrK1r@mail.gmail.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-29-git-send-email-ccross@android.com>
	<AANLkTimKqkKFuKCKPV2jSjUtPqo4tbonwR1iO2rsrK1r@mail.gmail.com>
Message-ID: <AANLkTi=3P5VWv2PA3R9=UZtwBkUxauhVGyCAzp_XNTBp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 7:19 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Sun, Jan 23, 2011 at 7:01 PM, Colin Cross <ccross@android.com> wrote:
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> Hi Colin,
>
> This build warning exists in current mainline. ?It should go out to
> Linus now instead of waiting for 2.6.29.
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> g.
>
>> ---
>> ?arch/arm/mach-tegra/include/mach/clk.h ? ?| ? ?2 ++
>> ?arch/arm/mach-tegra/include/mach/clkdev.h | ? ?2 ++
>> ?2 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/include/mach/clk.h b/arch/arm/mach-tegra/include/mach/clk.h
>> index d772395..a217f68 100644
>> --- a/arch/arm/mach-tegra/include/mach/clk.h
>> +++ b/arch/arm/mach-tegra/include/mach/clk.h
>> @@ -20,6 +20,8 @@
>> ?#ifndef __MACH_CLK_H
>> ?#define __MACH_CLK_H
>>
>> +struct clk;
>> +
>> ?void tegra_periph_reset_deassert(struct clk *c);
>> ?void tegra_periph_reset_assert(struct clk *c);
>>
>> diff --git a/arch/arm/mach-tegra/include/mach/clkdev.h b/arch/arm/mach-tegra/include/mach/clkdev.h
>> index 412f5c6..66cd3f4 100644
>> --- a/arch/arm/mach-tegra/include/mach/clkdev.h
>> +++ b/arch/arm/mach-tegra/include/mach/clkdev.h
>> @@ -20,6 +20,8 @@
>> ?#ifndef __MACH_CLKDEV_H
>> ?#define __MACH_CLKDEV_H
>>
>> +struct clk;
>> +
>> ?static inline int __clk_get(struct clk *clk)
>> ?{
>> ? ? ? ?return 1;
>> --
>> 1.7.3.1

It will, I just haven't sent it yet.  I have one more patch I'd like
to send with it to prevent a possible variable name conflict in
2.6.39.
