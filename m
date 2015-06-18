From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Jun 2015 09:05:01 +0200
Subject: [PATCH v2 0/3] Add the efuse driver on rockchip platform
In-Reply-To: <55800070.5030509@linaro.org>
References: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
 <557FE3EA.4000306@i2se.com> <557FEAB2.1040101@linaro.org>
 <557FF50C.10809@rock-chips.com> <55800070.5030509@linaro.org>
Message-ID: <55826D9D.2060106@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

Am 16.06.2015 um 12:54 schrieb Srinivas Kandagatla:
>
>
> On 16/06/15 11:06, Caesar Wang wrote:
>> Hi Srinivas,
>>
>> ? 2015?06?16? 17:21, Srinivas Kandagatla ??:
>>> Hi Stefan,
>>>
>>>
>>> On 16/06/15 09:52, Stefan Wahren wrote:
>>>> Hi Caesar,
>>>>
>>>> [add Maxime and Srinivas]
>>>>
>>>> Am 16.06.2015 um 09:27 schrieb Caesar Wang:
>>>>> The original driver is uploaded by Jianqun.
>>>>> Here is his patchs:
>>>>>      https://patchwork.kernel.org/patch/5410341/
>>>>>      https://patchwork.kernel.org/patch/5410351/
>>>>>
>>>>> Jianqun, nevermind!
>>>>> I check-pick it and re-upload the driver for the upstream.
>>>>> e.g.:
>>>>>      Tested by on minnie board.(kernel-4.1-rc8)
>>>>>      cd /sys/devices/platform/ffb40000.efuse
>>>>>      localhost ffb40000.efuse # cat cpu_leakage_show
>>>>>      cpu_version_show
>>>>>      The results:
>>>>>              19
>>>>>              2
>>>>>
>>>>> Changes in v2:
>>>>> - Change the document decription.
>>>>> - Move the efuse driver into driver/soc/vendor.
>>>>> - update the efuse driver.
>>>>> - Add the dts node on RK3288.
>>>>>
>>>>>
>>>>
>>>> i want to mention that there is a upcoming new framework suitable for
>>>> efuse drivers:
>>>>
>>>> https://lkml.org/lkml/2015/5/21/643
>>>>
>>>> Unfortunately i don't know the current development state.
>>>>
>>>
>>> Currently this framework is used by atleast 3 drivers(qcom-tsens,
>>> qcom-cpr, begel-bone-cape manager) which are still floating in the
>>> mailing list.
>>>
>>> I was hoping that these 3 users would getback with tested-by.. which
>>> did not happen for last 3-4 weeks.
>>>
>>> I would appreciate, If you could try framework too, and let me know.
>>

yes i work on OCOTP driver for MXS platform and i will try ...

>
> int rockchip_efuse_reg_read(void *context, unsigned int reg, unsigned
> int *val)
> {
>     /* efuse specific read sequence */
>     ...
> }

I will need a specific read sequence too.

Sorry for these newbie questions:

What data structure does context points to for this reg_read opteration?

Do we need range checking of reg or is it handled by the framework?

Are there any limitation for reg_read regarding sleeping or locking
operations?

In case of a read only driver, is everything handle by devicetree or do
we need an empty write operation?

Best regards
Stefan
