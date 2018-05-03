From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 May 2018 18:12:52 -0400
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 analog & timer
 drivers
In-Reply-To: <cc934eb9-f9e4-3c52-7f38-413a1b63fce2@st.com>
References: <1525274696-11968-1-git-send-email-fabrice.gasnier@st.com>
 <cc934eb9-f9e4-3c52-7f38-413a1b63fce2@st.com>
Message-ID: <CAK8P3a0maxno4S-dXoT1O5zp3NgHP2LWuGhtVoqFMMEv-tm07Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2018 at 10:05 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Fabrice,
>
> On 05/02/2018 05:24 PM, Fabrice Gasnier wrote:
>>
>> This enables drivers for STM32 timer, low power timer and analog hardware
>> that can be used on STM32MP1 SoC:
>> - Timer & LP Timer MFD core, PWM, trigger & encoder drivers
>> - IIO ADC/DAC/DFSDM
>> - vrefbuf regu driver (voltage reference buffer).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>
> Applied on stm32-next.
>
> Arnd,
> Do you agree if I take multi_v7_defconfig related patches in my stm32 pull
> requests ?

Yes, just make sure that all drivers that can reasonably be loadable
modules are configured that way rather than as built-in, so a defconfig
build doesn't become too big.

       Arnd
