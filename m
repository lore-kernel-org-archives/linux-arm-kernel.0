From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Sep 2017 16:05:29 -0500
Subject: [PATCH v4] ARM: dts: stm32: change pinctrl bindings definition
In-Reply-To: <1504104653-26804-1-git-send-email-alexandre.torgue@st.com>
References: <1504104653-26804-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <20170911210529.2kbt6j54ohokmb4b@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 04:50:52PM +0200, Alexandre Torgue wrote:
> Initially each pin was declared in "include/dt-bindings/stm32<SOC>-pinfunc.h"
> and each definition contained SOC names (ex: STM32F429_PA9_FUNC_USART1_TX).
> Since this approach was approved, the number of supported MCU has
> increased (STM32F429/STM32F469/STM32f746/STM32H743). To avoid to add a new
> file in "include/dt-bindings" each time a new STM32 SOC arrives I propose
> a new approach which consist to use a macro to define pin muxing in device
> tree. All STM32 DT will use the common macro to define pinmux. Furthermore, it
> will make maintenance and integration of new SOC easier.
> 
> I made only one patch to avoid dependencies. Let me know if you prefer that I
> split it.

It doesn't have to be one patch to go thru one tree. But I'm fine either 
way.

Rob
