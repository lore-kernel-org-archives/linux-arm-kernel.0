From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 1 Aug 2017 11:32:04 +0200
Subject: [PATCH V5 0/2] timer: add imx tpm timer support
In-Reply-To: <1501576817-18681-1-git-send-email-aisheng.dong@nxp.com>
References: <1501576817-18681-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170801093204.GA1919@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 04:40:15PM +0800, Dong Aisheng wrote:
> The Timer/PWM Module (TPM) supports input capture, output compare,
> and the generation of PWM signals to control electric motor and power
> management applications. The counter, compare and capture registers
> are clocked by an asynchronous clock that can remain enabled in low
> power modes. TPM can support global counter bus where one TPM drives
> the counter bus for the others, provided bit width is the same.
> 
> This patch only adds the timer support. PWM would be added later.
> 
> ChangeLog:
> v4->v5:
>  * use request_irq instead of setup_irq
>  * switch to TIMER_OF_DECLARE from CLOCKSOURCE_OF_DECLARE
>  * add more error check
>  * patch title change to clocksource/drivers/imx-tpm: add imx tpm timer support
> v3->v4:
>  * also add ETIME explanation in function
> v2->v3:
>  * address a few minor comments from Daniel Lezcano
>  * add more explaination on ETIME check in commit message
> v1->v2:
>  * change to readl/writel from __raw_readl/writel according to Arnd's
>    suggestion to avoid endian issue
>  * add help information in Kconfig
>  * add more error checking
> 
> Dong Aisheng (2):
>   dt-bindings: timer: add nxp tpm timer binding doc
>   clocksource/drivers/imx-tpm: add imx tpm timer support
> 
>  .../devicetree/bindings/timer/nxp,tpm-timer.txt    |  28 +++
>  drivers/clocksource/Kconfig                        |   8 +
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/timer-imx-tpm.c                | 239 +++++++++++++++++++++
>  4 files changed, 276 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
>  create mode 100644 drivers/clocksource/timer-imx-tpm.c
> 

Hi Dong,

applied for 4.14.

Thanks.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
