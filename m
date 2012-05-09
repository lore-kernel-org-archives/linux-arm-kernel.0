From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 09 May 2012 14:09:12 +0200
Subject: [PATCH] ARM: exynos: Adapt to cpuidle core time keeping and irq
 enable
In-Reply-To: <019801cd2dda$5dbbc680$19335380$%kim@samsung.com>
References: <1335355912-26063-1-git-send-email-amit.kachhap@linaro.org>
 <4F980DE6.1020504@linaro.org>
 <CAMXH7KG_=oupDTe7vcbDdp6wb=gHc3s8Z4EwxVeJBPGDNC8FSQ@mail.gmail.com>
 <CADGdYn6KLNA+EG4DCmvP_ZohORe0LjtUi+7m0DTxcjgqwUC1HQ@mail.gmail.com>
 <019801cd2dda$5dbbc680$19335380$%kim@samsung.com>
Message-ID: <4FAA5E68.1060204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2012 01:53 PM, Kukjin Kim wrote:
> amit kachhap wrote:
>>
>> Hi Mr Kukjin,
>>
>> Any comment or update about this patch?
>>
> I'm not sure we don't need to check the idle_time?
> Others, looks ok to me.

Hi,

may be I misunderstood your question but the behavior is not changed 
here, just the code is refactored and using a common routine where the 
time is computed.

The idle_time computation is done by the cpuidle core now if the 
en_core_tk_irqen flag is enabled. That allows to remove a lot of 
duplicated code across the cpuidle drivers.

Thanks
   -- Daniel
