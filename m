From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 4 Jun 2018 07:13:02 +0100
Subject: [PATCH 1/2] mfd: stm32-timers: fix pwm-stm32 linker issue with
 COMPILE_TEST
In-Reply-To: <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180604061302.GD25455@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2018, Fabrice Gasnier wrote:

> This is seen when COMPILE_TEST=y and MFD_STM32_TIMERS=n.
> drivers/pwm/pwm-stm32.o: In function 'stm32_pwm_raw_capture':
> pwm-stm32.c:... undefined reference to 'stm32_timers_dma_burst_read'
> Fixes: 0c6609805b63 ("mfd: stm32-timers: Add support for DMAs")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  include/linux/mfd/stm32-timers.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
