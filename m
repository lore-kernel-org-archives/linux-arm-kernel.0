From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 20 Jan 2017 14:55:13 +0100
Subject: [PATCH] clk: samsung: exynos5420: Mark CLK_ACLK432_SCALER as
 CLK_IS_CRITICAL
In-Reply-To: <551ac156-0cfa-29be-335f-d8a1f171cd8a@samsung.com>
References: <CGME20170120104148epcas5p11af0e630f0881092a9b3b43e8b5b1aac@epcas5p1.samsung.com>
 <1484908891-11820-1-git-send-email-javier@osg.samsung.com>
 <551ac156-0cfa-29be-335f-d8a1f171cd8a@samsung.com>
Message-ID: <0ffa0d28-1086-887c-dcfc-590b6146b03e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 01:32 PM, Sylwester Nawrocki wrote:
> On 01/20/2017 11:41 AM, Javier Martinez Canillas wrote:
>> On Exynos5800 SoC the SCALER block uses 2 input clocks: CLK_ACLK_300_GSCL
>> and CLK_ACLK432_SCALER, so both needs to be ungated in order to access it.
>>
>> But Exynos5420 only has the CLK_ACLK_300_GSCL as gsc_pd clk. So just using
>> this definition from exynos5420.dtsi in Exynos5800 leads to the following:
> [...]
>> So until a proper solution based on runtime PM gets merged, mark the clock
>> as critical to prevent it to be gated.
>>
>> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Oops, the $subject patch can be dropped since as Marek just pointed out
to me the changes introduced by that patch are already included in a patch
which is already in the v4.10 fixes queue:

https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=318fa46cc60d37fec1e87dbf03a82aca0f5ce695

-- 
Thanks,
Sylwester
