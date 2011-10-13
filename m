From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 13 Oct 2011 09:55:04 +0200
Subject: [PATCH V4 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using
	generic names
In-Reply-To: <CAPs=JDeFyoCYnR-Xa_fdmBVHxfNGuVNfdHd-MZgYcPytprsmFg@mail.gmail.com>
References: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
	<1318412587-29987-4-git-send-email-rajeshwari.s@samsung.com>
	<4E956ADB.3060604@samsung.com>
	<CAPs=JDf2N1kh4BO9nPBb-J6k51e-ytntrNOvw_UOKtw-ktdycA@mail.gmail.com>
	<4E95BDF8.2080406@samsung.com>
	<CAPs=JDeFyoCYnR-Xa_fdmBVHxfNGuVNfdHd-MZgYcPytprsmFg@mail.gmail.com>
Message-ID: <4E969958.9020200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2011 09:16 AM, Rajeshwari Birje wrote:
> On Wed, Oct 12, 2011 at 9:49 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 10/12/2011 02:36 PM, Rajeshwari Birje wrote:
>>> On Wed, Oct 12, 2011 at 3:54 PM, Sylwester Nawrocki
>>> <s.nawrocki@samsung.com> wrote:
>>>> Hi Rajeshwari,
>>>>
>>>> On 10/12/2011 11:43 AM, Rajeshwari Shinde wrote:
>>>>> Add support for lookup of sdhci-s3c controller clocks using generic names
>>>>> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
>>>>>
>>>>> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
>>>>> ---
>>>>>  arch/arm/mach-exynos4/clock.c         |   88 ++++++++++-------
>>>>>  arch/arm/mach-s3c2416/clock.c         |   68 +++++++------
>>>>>  arch/arm/mach-s3c64xx/clock.c         |  126 +++++++++++++++----------
>>>>>  arch/arm/mach-s5pc100/clock.c         |  130 ++++++++++++++++----------
>>>>>  arch/arm/mach-s5pv210/clock.c         |  167 ++++++++++++++++++++-------------
>>>>>  arch/arm/plat-s3c24xx/s3c2443-clock.c |   15 ++-
>>>>>  6 files changed, 359 insertions(+), 235 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
>>>>> index 9f50e33..c6383b9 100644
>>>>> --- a/arch/arm/mach-exynos4/clock.c
>>>>> +++ b/arch/arm/mach-exynos4/clock.c
>>>>> @@ -1157,42 +1157,6 @@ static struct clksrc_clk clksrcs[] = {
>>>>>               .reg_div = { .reg = S5P_CLKDIV_MFC, .shift = 0, .size = 4 },
>> ...
>>>>> +static struct clksrc_clk clk_sclk_mmc0 = {
>>>>> +     .clk            = {
>>>>> +             .name           = "sclk_mmc",
>>>>> +             .devname        = "s3c-sdhci.0",
>>>>
>>>> Would it make sense to drop this 'devname' field here and others
>>>> until sclk_mmc3 ....
>>>
>>> *** The devname here distinguishes these clocks. So it should be okay
>>> to have a devname for these clocks.
>>
>> I'm not sure what's Mr Kukjin's opinion on that, but I personally would really
>> like to see all the devname fields disappear from samsung clk data structures.
>> Possibly if all involved people would keep that in mind we could achieve this
>> over time.
> 
> 
> **** Devname field is still required for clocks like hsmmc for driver
> to work fine. Hence it would be tough to remove the devname
> completely.

Yes, it allowed to add clkdev support with minimal changes required.

But let's see what happens when the works on common struct clk for all
architectures are more or less completed and we convert Samsung platforms
to use it;)

Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
