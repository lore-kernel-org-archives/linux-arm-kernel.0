From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 13:25:19 +0100
Subject: [PATCH v3 5/6] pwm: stm32: use input prescaler to improve period
 capture
In-Reply-To: <1522404084-24903-6-git-send-email-fabrice.gasnier@st.com>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-6-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180416122519.5fnnyuuel64kfjfw@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Mar 2018, Fabrice Gasnier wrote:

> Using input prescaler, capture unit will trigger DMA once every
> configurable /2, /4 or /8 events (rising edge). This helps improve
> period (only) capture accuracy at high rates.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> Changes in v2:
> - Adopt DMA read from MFD core.
> ---
>  drivers/pwm/pwm-stm32.c          | 63 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/mfd/stm32-timers.h |  1 +

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 62 insertions(+), 2 deletions(-)

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
