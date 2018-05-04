From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 4 May 2018 09:42:03 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 analog & timer
 drivers
In-Reply-To: <CAK8P3a0maxno4S-dXoT1O5zp3NgHP2LWuGhtVoqFMMEv-tm07Q@mail.gmail.com>
References: <1525274696-11968-1-git-send-email-fabrice.gasnier@st.com>
 <cc934eb9-f9e4-3c52-7f38-413a1b63fce2@st.com>
 <CAK8P3a0maxno4S-dXoT1O5zp3NgHP2LWuGhtVoqFMMEv-tm07Q@mail.gmail.com>
Message-ID: <84f8b1bf-d6df-ca0e-cb3f-e5b7f7ded14b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/04/2018 12:12 AM, Arnd Bergmann wrote:
> On Thu, May 3, 2018 at 10:05 AM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> Hi Fabrice,
>>
>> On 05/02/2018 05:24 PM, Fabrice Gasnier wrote:
>>>
>>> This enables drivers for STM32 timer, low power timer and analog hardware
>>> that can be used on STM32MP1 SoC:
>>> - Timer & LP Timer MFD core, PWM, trigger & encoder drivers
>>> - IIO ADC/DAC/DFSDM
>>> - vrefbuf regu driver (voltage reference buffer).
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>>    arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>
>> Applied on stm32-next.
>>
>> Arnd,
>> Do you agree if I take multi_v7_defconfig related patches in my stm32 pull
>> requests ?
> 
> Yes, just make sure that all drivers that can reasonably be loadable
> modules are configured that way rather than as built-in, so a defconfig
> build doesn't become too big.

Ok. You're right, this drivers could be configured as module. We just 
need to verify impact before send it.

Regards
alex

> 
>         Arnd
> 
