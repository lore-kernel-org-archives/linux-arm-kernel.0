From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 7 Aug 2013 08:51:49 +0530
Subject: [PATCH 1/3] clk: exynos4: Make exynos4_plls static
In-Reply-To: <20130806200219.GD23006@n2100.arm.linux.org.uk>
References: <1375788675-2638-1-git-send-email-sachin.kamat@linaro.org>
 <20130806200219.GD23006@n2100.arm.linux.org.uk>
Message-ID: <CAK9yfHxKn9JaA5Tbuw9qXeyEX_kio4mt3gOgJxkMNSoDHkHnBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+CC Joe Perches

On 7 August 2013 01:32, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> Also note:
>
> On Tue, Aug 06, 2013 at 05:01:13PM +0530, Sachin Kamat wrote:
>> @@ -984,7 +984,7 @@ static __initdata struct of_device_id ext_clk_match[] = {
>
> For the declaration above...
>
>> -struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
>> +static struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
>
> And this one... __initdata should come just before the '=', not at the
> start, not in the middle and not before the variable.
>
> The reasoning is that with how you have it above, the attributes are
> applied to the structure.  You want to apply the attributes to the
> declaration instead, so it should come after the variable name.
>
> So, for example:
>
>         struct foo *foo __attribute__((section(".foo"))) = (void *)1;
>
> will place the "foo" variable into a section called ".foo", but:
>
>         struct __attribute__((section(".foo"))) foo *foo = (void *)1;
>
> will place "foo" into the normal .data section.
>
> So, the rule with variable declarations is that the __ specifiers we
> have as macros in the kernel always come after the variable name being
> declared and nowhere else.  We consider anywhere else buggy.

Thanks for this useful tip, Russell. There are several instances in
the kernel where these attributes are used at the beginning of the
variable declaration.

Probably it would be useful to add this to checkpatch. Joe?

-- 
With warm regards,
Sachin
