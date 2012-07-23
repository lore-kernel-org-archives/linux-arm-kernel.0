From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 23 Jul 2012 18:54:33 +0900
Subject: [PATCH V2 6/7] ARM: EXYNOS5: Add the bus clock for FIMD
In-Reply-To: <500D0C8B.3080007@samsung.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-7-git-send-email-l.krishna@samsung.com>
 <500D0C8B.3080007@samsung.com>
Message-ID: <500D1F59.9030807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jingoo.

On 07/23/2012 05:34 PM, Joonyoung Shim wrote:
> On 07/18/2012 02:57 PM, Leela Krishna Amudala wrote:
>> This patch adds the bus clock for FIMD and changes
>> the device name for lcd clock
>
> Please refer below patch for exynos4.
>
> http://lists.linaro.org/pipermail/linaro-dev/2011-December/008872.html
>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>   arch/arm/mach-exynos/clock-exynos5.c |    7 ++++++-
>>   1 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/clock-exynos5.c 
>> b/arch/arm/mach-exynos/clock-exynos5.c
>> index 774533c..f001876 100644
>> --- a/arch/arm/mach-exynos/clock-exynos5.c
>> +++ b/arch/arm/mach-exynos/clock-exynos5.c
>> @@ -634,6 +634,11 @@ static struct clk exynos5_init_clocks_off[] = {
>>           .enable        = exynos5_clk_ip_disp1_ctrl,
>>           .ctrlbit    = (1 << 3),
>>       }, {
>> +        .name           = "fimd",
>> +        .devname        = "exynos5-fb",
>> +        .enable         = exynos5_clk_ip_disp1_ctrl,
>> +        .ctrlbit        = (1 << 0),
>> +    }, {

With this patch, it causes below error at the DP driver because fimd 
clock is disabled.

[    0.210000] exynos-dp exynos-dp: Timeout of video streamclk ok
[    0.210000] exynos-dp exynos-dp: unable to config video
[    0.210000] exynos-dp: probe of exynos-dp failed with error -110

I wonder fimd clock has any dependency with DP

Thanks.
