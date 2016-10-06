From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 6 Oct 2016 16:09:57 +0200
Subject: [PATCH -next] serial: stm32: fix build failure
In-Reply-To: <1475746413-18301-1-git-send-email-alexandre.torgue@st.com>
References: <1475746413-18301-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <2289a67f-ec12-a19b-750c-3cd4980ec311@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 10/06/2016 11:33 AM, Alexandre TORGUE wrote:
> While building m32r config the build failed with:
> ERROR: stm32-usart.c:(.text+0xdc988): undefined reference to `bad_dma_ops'
>
> To satisfy the dependency CONFIG_SERIAL_STM32 should depend on HAS_DMA.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index c783140..8a261c0 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1624,6 +1624,7 @@ config SERIAL_SPRD_CONSOLE
>
>  config SERIAL_STM32
>  	tristate "STMicroelectronics STM32 serial port support"
> +	depends on HAS_DMA
>  	select SERIAL_CORE
>  	depends on ARM || COMPILE_TEST
>  	help
>
Same patch has been sent in same time. Please abandon this one.

Regards
Alex
