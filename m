From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Wed, 5 Jul 2017 16:23:45 +0800
Subject: [PATCH V4 0/2] timer: add imx tpm timer support
In-Reply-To: <1499222112-9988-1-git-send-email-aisheng.dong@nxp.com>
References: <1499222112-9988-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170705162345.0000020e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Jul 2017 10:35:10 +0800
Dong Aisheng <aisheng.dong@nxp.com> wrote:

> The Timer/PWM Module (TPM) supports input capture, output compare,
> and the generation of PWM signals to control electric motor and power
> management applications. The counter, compare and capture registers
> are clocked by an asynchronous clock that can remain enabled in low
> power modes. TPM can support global counter bus where one TPM drives
> the counter bus for the others, provided bit width is the same.
> 
> This patch only adds the timer support. PWM would be added later.
Hi Dong,

Not relevant to this patch - just an observation!

Just came across this thread and took a look at the hardware. I see
some of the timers (particularly the flextimers) support quadrature
encoder modes.  Just thought I'd point you at some on going discussions
on the IIO list (linux-iio at vger.kernel.org) trying to improve the
interface for such devices.  Might be of interest (or not depending on
whether support for that functionality is of interest!)

http://marc.info/?l=linux-iio&m=149904379731556&w=2

Jonathan
> 
> ChangeLog:
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
>   timer: imx-tpm: add imx tpm timer support
> 
>  .../devicetree/bindings/timer/nxp,tpm-timer.txt    |  28 +++
>  drivers/clocksource/Kconfig                        |   8 +
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/timer-imx-tpm.c                | 239
> +++++++++++++++++++++ 4 files changed, 276 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt create mode
> 100644 drivers/clocksource/timer-imx-tpm.c
> 
