From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Apr 2012 13:42:11 +0530
Subject: [PATCH 03/12] ARM: Exynos5: Add watchdog timer clock instance
In-Reply-To: <CAH9JG2WOUjG=spRGPCcWocLkhMXA7PtmdxLdq87VCez_6L84XA@mail.gmail.com>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-4-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2WOUjG=spRGPCcWocLkhMXA7PtmdxLdq87VCez_6L84XA@mail.gmail.com>
Message-ID: <CAJuYYwTLZ8TCkaTFOGB8cS9AXXf_OyTkCysWHoGR4h7C47-JWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2012 11:44, Kyungmin Park <kmpark@infradead.org> wrote:
> On 4/17/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> Add watchdog timer clock instance for Exynos5 watchdog controller.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/mach-exynos/clock-exynos5.c | ? ?5 +++++
>> ?1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/clock-exynos5.c
>> b/arch/arm/mach-exynos/clock-exynos5.c
>> index ad3bec4..662615d 100644
>> --- a/arch/arm/mach-exynos/clock-exynos5.c
>> +++ b/arch/arm/mach-exynos/clock-exynos5.c
>> @@ -474,6 +474,11 @@ static struct clk exynos5_init_clocks_off[] = {
>> ? ? ? ? ? ? ? .enable ? ? ? ? = exynos5_clk_ip_peris_ctrl,
>> ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 20),
>> ? ? ? }, {
>> + ? ? ? ? ? ? .name ? ? ? ? ? = "watchdog",
>> + ? ? ? ? ? ? .parent ? ? ? ? = &exynos5_clk_aclk_66.clk,
>> + ? ? ? ? ? ? .enable ? ? ? ? = exynos5_clk_ip_peris_ctrl,
>> + ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 19),
>
> Hi,
>
> Can you place this in order? It has same "exynos5_clk_ip_peris_ctrl",
> but located under (1 << 20).

Hi Mr. Park,

At present, there is only one clock gate from the peris register for
which there is a struct clock instance. This patch adds the watchdog
timer clock gate right below it and maintains the descending bit
position order.

Thanks,
Thomas.

>
> Thank you,
> Kyungmin Park
>> + ? ? }, {
>> ? ? ? ? ? ? ? .name ? ? ? ? ? = "hsmmc",
>> ? ? ? ? ? ? ? .devname ? ? ? ?= "exynos4-sdhci.0",
>> ? ? ? ? ? ? ? .parent ? ? ? ? = &exynos5_clk_aclk_200.clk,
>> --
>> 1.6.6.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
>> in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>>
