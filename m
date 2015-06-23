From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 23 Jun 2015 09:25:17 +0100
Subject: [PATCH v3 2/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <20150622232114.GK22132@codeaurora.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-3-git-send-email-daniel.thompson@linaro.org>
 <20150622232114.GK22132@codeaurora.org>
Message-ID: <558917ED.8080404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/15 00:21, Stephen Boyd wrote:
> On 06/10, Daniel Thompson wrote:
>> The driver supports decoding and statically modelling PLL state (i.e.
>> we inherit state from bootloader) and provides support for all
>> peripherals that support simple one-bit gated clocks. The covers all
>> peripherals whose clocks come from the AHB, APB1 or APB2 buses.
>>
>> It has been tested on an STM32F429I-Discovery board. The clock counts
>> for TIM2, USART1 and SYSTICK are all set correctly and the wall clock
>> looks OK when checked with a stopwatch. I have also tested a prototype
>> driver for the RNG hardware. The RNG clock is correctly enabled by the
>> framework (also did inverse test and proved that by changing DT to
>> configure the wrong clock bit then we observe the RNG driver to fail).
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Reviewed-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>
> I also squashed in some sparse fixes. Please check.

That was extremely generous! Thanks.

The changes all eyeball OK but I'll double check things tonight just in 
case.


Daniel.
