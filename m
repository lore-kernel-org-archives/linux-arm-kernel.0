From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 6 May 2018 18:54:04 +0100
Subject: [PATCH v2 0/3] Add support for STM32MP1 ADC
In-Reply-To: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180506185404.1e2b1d7a@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 May 2018 09:44:48 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add support for STM32MP1 Analog to Digital Converter variant.
> It's quite similar to STM32H7 ADC and re-use most of existing driver.
This series looks good to me. I just want to give Rob in particular
time to have another look if he likes.

Give me a poke if I seem to have forgotten it in a week or so.

Thanks,

Jonathan

> 
> ---
> Changes in v2:
> - Update dt-bindings following Rob's remark: STM32MP1 ADC has two
>   interrupt lines
> 
> Fabrice Gasnier (3):
>   dt-bindings: iio: stm32-adc: add support for STM32MP1
>   iio: adc: stm32-adc: add support for STM32MP1
>   ARM: dts: stm32: Add ADC support to stm32mp157c
> 
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  6 +-
>  arch/arm/boot/dts/stm32mp157c.dtsi                 | 32 +++++++++++
>  drivers/iio/adc/stm32-adc-core.c                   | 66 ++++++++++++++++------
>  drivers/iio/adc/stm32-adc.c                        | 47 +++++++++++++--
>  4 files changed, 128 insertions(+), 23 deletions(-)
> 
