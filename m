From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Oct 2015 18:38:05 +0200
Subject: [PATCH 5/7] ARM: exynos_defconfig: Normalize exynos defconfig
In-Reply-To: <CAGOxZ52bGrHo0DzjhyjGPXwX0CWUn0Oqkx-EGZY51zC5FWcAKw@mail.gmail.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <1445234635-3950-6-git-send-email-alim.akhtar@samsung.com>
 <5624EF5D.7080403@osg.samsung.com>
 <CAGOxZ52bGrHo0DzjhyjGPXwX0CWUn0Oqkx-EGZY51zC5FWcAKw@mail.gmail.com>
Message-ID: <56251C6D.9000708@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/19/2015 05:58 PM, Alim Akhtar wrote:
> Hi Javier,
> 
> On Mon, Oct 19, 2015 at 6:55 PM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> Hello Alim,
>>
>> On 10/19/2015 08:03 AM, Alim Akhtar wrote:
>>> make savedefconfig result in some difference, lets normalize the
>>> defconfig.
>>>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>
>> Did you make savedefconfig against v4.3-rc6 or tot linux-next?
>>
> These are based on v4.3-rc5.
> 
>> I remember we had issues in the past due savedefconfig made against
>> linux-next but then some of the patches in linux-next not making it
>> to the next release. So I think it should be good to mention what's
>> the base used for this patch.
>>
> Ah, ok I didn't follow that, will check again on Linux-next as well as

IIRC the problem was in that case that a patch was adding a new select
that made the symbol not necessary in the defconfig. So a patch against
linux-next was posted removing the unneeded symbol but at the end the
select patch didn't make it to the release but the one removing the
symbol did.

> on 4.3-rc5
>

OK, using 4.3-rcX should be safe AFAICT.

>>>  arch/arm/configs/exynos_defconfig |    8 ++------
>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>>> index 1ff2bfa2e183..3349713e6c63 100644
>>> --- a/arch/arm/configs/exynos_defconfig
>>> +++ b/arch/arm/configs/exynos_defconfig
>>> @@ -99,10 +99,8 @@ CONFIG_SENSORS_LM90=y
>>>  CONFIG_SENSORS_NTC_THERMISTOR=y
>>>  CONFIG_SENSORS_PWM_FAN=y
>>>  CONFIG_SENSORS_INA2XX=y
>>> -CONFIG_THERMAL=y
>>>  CONFIG_CPU_THERMAL=y
>>>  CONFIG_THERMAL_EMULATION=y
>>> -CONFIG_EXYNOS_THERMAL=y
>>
>> I would prefer to split all the changes that removes symbols into a
>> separate patch explaining why these are not needed anymore (i.e: it
>> is selected now by symbol $foo).
>>
> Ok ..let me rebase my patches and check these config changes again....


Thanks, the changes looks good to me though so please feel free
to add my Reviewed-by tag if you re-spin and split the changes.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
