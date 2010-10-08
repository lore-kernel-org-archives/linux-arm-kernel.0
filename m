From: claude.youn@gmail.com (Seungwhan Youn)
Date: Fri, 8 Oct 2010 19:55:27 +0900
Subject: [PATCH 7/10] ARM: S5PV210: Fix wrong EPLL rate getting on setup
	clocks
In-Reply-To: <001e01cb66d4$c178a400$4469ec00$%kim@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286193919-19830-1-git-send-email-sw.youn@samsung.com>
	<001e01cb66d4$c178a400$4469ec00$%kim@samsung.com>
Message-ID: <AANLkTim4epO5cmoGw9ub1ERgHxruvoC+dFLP=k6aYms9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 8, 2010 at 7:37 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Seungwhan Youn wrote:
>>
>> This patch fix wrong EPLL getting on setup clocks on S5PV210.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/clock.c ? ? ? ? ? ? ? ? ? | ? ?3 ++-
>> ?arch/arm/mach-s5pv210/include/mach/regs-clock.h | ? ?3 ++-
>> ?2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> index 3f3b7ba..bcbe7e9 100644
>> --- a/arch/arm/mach-s5pv210/clock.c
>> +++ b/arch/arm/mach-s5pv210/clock.c
>> @@ -1040,7 +1040,8 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
>>
>> ? ? ? apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
>> ? ? ? mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
>> - ? ? epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
>> + ? ? epll = s5p_get_pll90xx(xtal, __raw_readl(S5P_EPLL_CON0),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? __raw_readl(S5P_EPLL_CON1));
>
> Maybe you wanted to implement fractional PLL 4600B...not used 90xx in there.
> So need to update plat/pll.h to epll of s5pv210.
>

Okay, I'll fix it and add PLL_4600B also.

Thanks,
Claude
