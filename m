From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 21 Aug 2015 10:27:53 +0900
Subject: [PATCH 1/5] drivers: soc: add support for exynos SROM driver
In-Reply-To: <55D5BB56.1030405@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
 <1430296712-10287-2-git-send-email-pankaj.dubey@samsung.com>
 <5565AFE6.5030106@samsung.com> <55D5BB56.1030405@samsung.com>
Message-ID: <55D67E99.60505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.08.2015 20:34, Pankaj Dubey wrote:
> Hi Krzysztof,
> 
> Sorry for delay in reply, as I got busy in some other official
> assignments and could not take this series further at that time.
> 
> On Wednesday 27 May 2015 05:22 PM, Krzysztof Kozlowski wrote:
>> W dniu 29.04.2015 o 17:38, Pankaj Dubey pisze:
>>> This patch adds Exynos SROM controller driver which will handle
>>> save restore of SROM registers during S2R.
>>>
>>> Change-Id: Iaddaaebc1d7090c9889e948e68e886519562c43c
>>
>> Please remove it.
> 
> Will do it.
> 
>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> ---
>>>   drivers/soc/Kconfig               |   1 +
>>>   drivers/soc/Makefile              |   1 +
>>>   drivers/soc/samsung/Kconfig       |  14 ++++
>>>   drivers/soc/samsung/Makefile      |   1 +
>>>   drivers/soc/samsung/exynos-srom.c | 142
>>> ++++++++++++++++++++++++++++++++++++++
>>>   drivers/soc/samsung/exynos-srom.h |  51 ++++++++++++++
>>>   6 files changed, 210 insertions(+)
>>>   create mode 100644 drivers/soc/samsung/Kconfig
>>>   create mode 100644 drivers/soc/samsung/Makefile
>>>   create mode 100644 drivers/soc/samsung/exynos-srom.c
>>>   create mode 100644 drivers/soc/samsung/exynos-srom.h
>>>
>>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>>> index 76d6bd4..c3abfbe 100644
>>> --- a/drivers/soc/Kconfig
>>> +++ b/drivers/soc/Kconfig
>>> @@ -1,6 +1,7 @@
>>>   menu "SOC (System On Chip) specific Drivers"
>>>
>>>   source "drivers/soc/qcom/Kconfig"
>>> +source "drivers/soc/samsung/Kconfig"
>>>   source "drivers/soc/ti/Kconfig"
>>>   source "drivers/soc/versatile/Kconfig"
>>>
>>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>>> index 063113d..620366f 100644
>>> --- a/drivers/soc/Makefile
>>> +++ b/drivers/soc/Makefile
>>> @@ -3,6 +3,7 @@
>>>   #
>>>
>>>   obj-$(CONFIG_ARCH_QCOM)        += qcom/
>>> +obj-$(CONFIG_SOC_SAMSUNG)    += samsung/
>>>   obj-$(CONFIG_ARCH_TEGRA)    += tegra/
>>>   obj-$(CONFIG_SOC_TI)        += ti/
>>>   obj-$(CONFIG_PLAT_VERSATILE)    += versatile/
>>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>>> new file mode 100644
>>> index 0000000..b6fa4e6
>>> --- /dev/null
>>> +++ b/drivers/soc/samsung/Kconfig
>>> @@ -0,0 +1,14 @@
>>> +#
>>> +# SAMSUNG SoC drivers
>>> +#
>>> +menu "Samsung SOC driver support"
>>> +
>>> +config SOC_SAMSUNG
>>> +    bool
>>
>> Any reason for not using menuconfig?
>>
> 
> For one of my Exynos PMU patchset [1] this suggestion came from Russel
> King, not to use user-visible sysmbol if not required.
> [1]:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304451.html

Okay, thanks. I'm fine with that.

Best regards,
Krzysztof
