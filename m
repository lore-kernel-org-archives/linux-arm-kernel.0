From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:53:09 -0800
Subject: [GIT PULL] STM32 DT changes for v4.11 #1
In-Reply-To: <e36f6aca-120c-b2a5-52da-06e12e5cfb9f@st.com>
References: <e36f6aca-120c-b2a5-52da-06e12e5cfb9f@st.com>
Message-ID: <20170117065309.GS16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 04:49:29PM +0100, Alexandre Torgue wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STM32 DT updates for v4.11:
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-dt-for-v4.11-1
> 
> for you to fetch changes up to d99c66406a846748e26989759caa7e966c1804dd:
> 
>   ARM: dts: stm32: enable RTC on stm32429i-eval (2017-01-16 14:38:14 +0100)
> 
> ----------------------------------------------------------------
> STM32 DT updates for v4.11, round 1.
> 
> Highlights:
> ----------
> 
>  - ADD RTC support on STM32F429 MCU
>  - Enable RTC on STM32F469and STM32F429 boards
>  - ADD ADC support on STM32F429 MCU
>  - Enable ADC on STM32F429 Eval board
>  - Add I2S external clock
>  - Fix memory size for STM32F429 Disco
> 
> Note:
> -----
> First patch "clk: stm32f4: Update DT bindings documentation")
> has already been merged in clock tree.

Ugh. That patch doesn't just update documentation. It also updates the
dt-include file.

So, if it's already been merged into the clock tree, then we can't merge
a separate copy here.

By now, easiest is to hold off making use of it until it's on a shared
branch, i.e. next release. Use the numerical values until then.

> ----------------------------------------------------------------
> Amelie Delaunay (5):
>       ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f429
>       ARM: dts: stm32: Add RTC support for STM32F429 MCU
>       ARM: dts: stm32: enable RTC on stm32f429-disco
>       ARM: dts: stm32: enable RTC on stm32f469-disco
>       ARM: dts: stm32: enable RTC on stm32429i-eval
> 
> Bruno Herrera (1):
>       ARM: dts: stm32: Fix memory size from 8MB to 16MB on stm32f469-disco
> board
> 
> Bruno Meirelles Herrera (1):
>       ARM: dts: stm32: Add missing USART3 pin config to stm32f469-disco
> board
> 
> Fabrice GASNIER (2):
>       ARM: dts: stm32: Add ADC support to stm32f429
>       ARM: dts: stm32: enable ADC on stm32f429i-eval board
> 
> Gabriel Fernandez (3):
>       clk: stm32f4: Update DT bindings documentation
>       ARM: dts: stm32: Add external I2S clock on stm32f429 MCU
>       ARM: dts: stm32: Include auxiliary stm32fx clock definition

How did you generate this pull request? You didn't include a diffstat with it,
which is useful for us to make sure that what we merged is what you expected us
to merge.

Not merging, please revisit based on the above.


-Olof
