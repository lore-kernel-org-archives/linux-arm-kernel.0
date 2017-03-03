From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 3 Mar 2017 12:45:54 +0100
Subject: [PATCH v3 6/6] iio: adc: stm32: add support for EXTI trigger
In-Reply-To: <1488300679-3259-7-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-7-git-send-email-fabrice.gasnier@st.com>
Message-ID: <5be44ed9-2c86-ac51-d964-d231d5ca62fa@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2017 05:51 PM, Fabrice Gasnier wrote:
> EXTi (external interrupt) signal can be routed internally as trigger
> source for ADC conversions: STM32F4 ADC can use EXTI11.
> 
> Retrieve interrupt trigger from DT, so it can be muxed into ADC IP,
> via extsel.

Hi,

Sorry, I have some trouble understanding the specifics of this. Is EXTI a
hardware input signal into the ADC that automatically triggers a conversion
when asserted? If yes how is it configured which external signal is used
here. Your bindings suggest that any GPIO can be used, but the driver only
differentiates between EXTI on or EXTI off.

Or is this just a software triggered conversion? The GPIO triggers a
software interrupt routine and the interrupt routine than triggers conversion?
