From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 Aug 2012 10:34:00 -0700
Subject: [PATCH] ARM: tegra_defconfig: enable APB DMA support
In-Reply-To: <20120829094957.GF28643@pengutronix.de>
References: <1346230800-3167-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <503DDEA8.1000405@nvidia.com> <20120829094957.GF28643@pengutronix.de>
Message-ID: <503E5288.90602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/12 02:49, Uwe Kleine-K?nig wrote:
> On Wed, Aug 29, 2012 at 02:49:36PM +0530, Laxman Dewangan wrote:
>> On Wednesday 29 August 2012 02:30 PM, Uwe Kleine-K?nig wrote:
>>> Additionally DMADEVICES needs to be enabled as TEGRA20_APB_DMA depends
>>> on that.
>>>
>>> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
>>> ---
>>>   arch/arm/configs/tegra_defconfig |    2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
>>> index db22453..0d6bb73 100644
>>> --- a/arch/arm/configs/tegra_defconfig
>>> +++ b/arch/arm/configs/tegra_defconfig
>>> @@ -145,6 +145,8 @@ CONFIG_MMC_SDHCI_TEGRA=y
>>>   CONFIG_RTC_CLASS=y
>>>   CONFIG_RTC_DRV_EM3027=y
>>>   CONFIG_RTC_DRV_TEGRA=y
>>> +CONFIG_DMADEVICES=y
>>> +CONFIG_TEGRA20_APB_DMA=y
>>>   CONFIG_STAGING=y
>>>   CONFIG_SENSORS_ISL29018=y
>>>   CONFIG_SENSORS_ISL29028=y
>>
>> Hi Uwe,
>> Tegra team is working on to enable the new dma drivr which is
>> dmaengine based. We have dma legacy driver as of now in mach-tegra.
>> Some of the tests are failing with new dmadriver and so we are not
>> able to enable it.
> So it depends on what you wanna do with the defconfig. There are two
> purposes for them:
>
>   a) compile coverage
>   b) starting point for machine support
>
> So it all depends on what you consider to be more important.

I'd prefer tegra_defconfig to produce a useful working system. I believe 
that enabling both DMA drivers at the same time will cause conflicts. 
Hopefully the switch to the new DMA driver is coming very soon, and this 
patch (or equivalent) will be part of that.
