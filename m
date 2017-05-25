From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 May 2017 22:54:55 +0200
Subject: [PATCH 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <1494660575-30465-2-git-send-email-aisheng.dong@nxp.com>
References: <1494660575-30465-1-git-send-email-aisheng.dong@nxp.com>
 <1494660575-30465-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170525205455.GB9501@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 03:29:35PM +0800, Dong Aisheng wrote:
> IMX Timer/PWM Module (TPM) supports both timer and pwm function while
> this patch only adds the timer support. PWM would be added later.
> 
> The TPM counter, compare and capture registers are clocked by an
> asynchronous clock that can remain enabled in low power modes.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

[ ... ]

> +	val = __raw_readl(timer_base + TPM_C0SC);
> +	val &= ~(TPM_C0SC_MODE_MASK | TPM_C0SC_CHIE);
> +	__raw_writel(val, timer_base + TPM_C0SC);

Hi Dong,

why are you using __raw_write/__raw_read instead of regular readl/writel?
