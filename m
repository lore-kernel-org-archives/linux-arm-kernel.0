From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Dec 2017 14:40:43 +0100
Subject: [PATCH 1/6] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <CACRpkdaKZk5N9F=_nYSzKWyXgW4xQ9Ltft7-UNM+a-nOpqq2xg@mail.gmail.com>
References: <1512742277-28205-1-git-send-email-ludovic.Barre@st.com>
 <1512742277-28205-2-git-send-email-ludovic.Barre@st.com>
 <CACRpkdaKZk5N9F=_nYSzKWyXgW4xQ9Ltft7-UNM+a-nOpqq2xg@mail.gmail.com>
Message-ID: <CAK8P3a2rrpFuwET8r1H0YWVABbCZr5c2ySrKCgA4mfoZPfWp6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 11:25 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, Dec 8, 2017 at 3:11 PM, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch prepares the STM32 machine for the integration of Cortex-A
>> based microprocessor (MPU), on top of the existing Cortex-M
>> microcontroller family (MCU). Since both MCUs and MPUs are sharing
>> common hardware blocks we can keep using ARCH_STM32 flag for most of
>> them. If a hardware block is specific to one family we can use either
>> ARCH_STM32_MCU or ARCH_STM32_MPU flag.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

To what degree do we need to treat them as separate families
at all then? I wonder if the MCU/MPU distinction is always that
clear along the Cortex-M/Cortex-A separation, especially if
we ever get to a chip that has both types of cores. What
exactly would we miss if we do away with the ARCH_STM32_MCU
symbol here?

> So yesterdays application processors are todays MCU processors.
>
> I said this on a lecture for control systems a while back and
> stated it as a reason I think RTOSes are not really seeing a bright
> future compared to Linux.
>
> It happened quicker than I thought though, interesting.

I think there is still lots of room for smaller RTOS in the long run,
but it's likely that the 'MPU + external DRAM' design point will
shift further to Linux, as there isn't really a benefit in squeezing
in anything smaller when the minimum is 32MB or 128MB of
RAM, depending on the interface.

For on-chip eDRAM or SRAM based MPUs, that doesn't hold
true, the memory size is what drives the cost here.

        Arnd
