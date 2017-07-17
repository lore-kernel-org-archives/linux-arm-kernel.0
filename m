From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 17 Jul 2017 13:19:11 +0200
Subject: [RFC PATCH] ARM: dts: stm32: change pinctrl bindings definition
In-Reply-To: <CAK8P3a2tfCjWyOGoatXGydVU21pfAxVf96JsRVgMHFpG5sCWeg@mail.gmail.com>
References: <1500289258-3700-1-git-send-email-alexandre.torgue@st.com>
 <1500289258-3700-2-git-send-email-alexandre.torgue@st.com>
 <CAK8P3a2tfCjWyOGoatXGydVU21pfAxVf96JsRVgMHFpG5sCWeg@mail.gmail.com>
Message-ID: <25cebb45-b770-c0b4-a478-13b01b5cfd0e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 07/17/2017 01:15 PM, Arnd Bergmann wrote:
> On Mon, Jul 17, 2017 at 1:00 PM, Alexandre TORGUE
> <alexandre.torgue@st.com> wrote:
>> blabla
>>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
> 
> You may want to provide a little more detail here ;-)
> 
Oh!! Sorry, I changed it but no sent the good commit :).

Please translate blablable by:

Initially each pin was declared in 
"include/dt-bindings/stm32f429-pinfunc.h"and each definition contained 
SOC names (ex: STM32F429_PA9_FUNC_USART1_TX).
Since this approach was approved, the number of supported MCU has
increased (STM32F429/STM32F469/STM32f746/STM32H743). To avoid to add a 
new file in "include/dt-bindings" each time a new STM32 SOC arrives I 
propose a new approach which consist to use a macro to define pin muxing 
in device tree. All STM32 will use the common macro to define pinmux. 
Furthermore, it will make easy maintenance and integration of new SOC.

Regards
Alex



>           Arnd
> 
