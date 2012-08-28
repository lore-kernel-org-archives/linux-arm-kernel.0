From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Aug 2012 16:20:18 -0700
Subject: [PATCH] ARM: Exynos4: Turn off clocks for NAND, OneNAND and TSI
 controllers
In-Reply-To: <CAJuYYwSFMR1cJm7SB-eF_aYM9SPMaopvw3K9stiPvabCfjH=QA@mail.gmail.com>
References: <1345819936-6503-1-git-send-email-chander.kashyap@linaro.org>
 <CAJuYYwSFMR1cJm7SB-eF_aYM9SPMaopvw3K9stiPvabCfjH=QA@mail.gmail.com>
Message-ID: <503D5232.5040101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/12 01:15, Thomas Abraham wrote:
> On 24 August 2012 20:22, Chander Kashyap<chander.kashyap@linaro.org>  wrote:
>> The clocks for NAND, OneNAND and Transport Stream Interface(TSI)
>> controllers could be either enabled or disabled at boot. To ensure
>> that these are turned off until used, add them to the list of clocks
>> to be turned off during boot.
>>
>> Signed-off-by: Chander Kashyap<chander.kashyap@linaro.org>
>> ---
>>   arch/arm/mach-exynos/clock-exynos4.c |   12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
>> index 2f51293..7cc5491 100644
>> --- a/arch/arm/mach-exynos/clock-exynos4.c
>> +++ b/arch/arm/mach-exynos/clock-exynos4.c
>> @@ -501,6 +501,10 @@ static struct clk exynos4_init_clocks_off[] = {
>>                  .enable         = exynos4_clk_ip_cam_ctrl,
>>                  .ctrlbit        = (1<<  3),
>>          }, {
>> +               .name           = "tsi",
>> +               .enable         = exynos4_clk_ip_fsys_ctrl,
>> +               .ctrlbit        = (1<<  4),
>> +       }, {
>>                  .name           = "hsmmc",
>>                  .devname        = "exynos4-sdhci.0",
>>                  .parent         =&exynos4_clk_aclk_133.clk,
>> @@ -530,6 +534,14 @@ static struct clk exynos4_init_clocks_off[] = {
>>                  .enable         = exynos4_clk_ip_fsys_ctrl,
>>                  .ctrlbit        = (1<<  9),
>>          }, {
>> +               .name           = "onenand",
>> +               .enable         = exynos4_clk_ip_fsys_ctrl,
>> +               .ctrlbit        = (1<<  15),
>> +       }, {
>> +               .name           = "nfcon",
>> +               .enable         = exynos4_clk_ip_fsys_ctrl,
>> +               .ctrlbit        = (1<<  16),
>> +       }, {
>>                  .name           = "dac",
>>                  .devname        = "s5p-sdo",
>>                  .enable         = exynos4_clk_ip_tv_ctrl,
>> --
>> 1.7.9.5
>
> Reviewed-by: Thomas Abraham<thomas.abraham@linaro.org>

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
