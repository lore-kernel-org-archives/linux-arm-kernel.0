From: ccross@android.com (Colin Cross)
Date: Mon, 24 Jan 2011 17:23:30 -0800
Subject: [PATCH v2 28/28] ARM: tegra: clock: Add forward reference to
	struct clk
In-Reply-To: <20110124102647.GF16202@n2100.arm.linux.org.uk>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-29-git-send-email-ccross@android.com>
	<20110124102647.GF16202@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=Ar7dAtRHj=uZ9a+CGSaU4FhJA92+AyHoJcrcH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 2:26 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 23, 2011 at 06:01:33PM -0800, Colin Cross wrote:
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
>> ? ? ? return 1;
>
> If you're having to add that, I suspect this include is being
> inappropriately included by files.
>

The Tegra clock definition file, arch/arm/mach-tegra/tegra2_clocks.c,
includes the private clock.h that defines struct clk after including
linux/clkdev.h, and does not include linux/clk.h, so the forward
declaration is necessary.
