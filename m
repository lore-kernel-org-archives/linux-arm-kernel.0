From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jan 2014 14:47:41 +0000
Subject: [PATCH v2 1/7] mfd: Move pm8xxx-irq.c contents into only driver
 that uses it
In-Reply-To: <1387831563-13535-2-git-send-email-sboyd@codeaurora.org>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140106144741.GH30156@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Dec 2013, Stephen Boyd wrote:

> The pm8xxx-irq.c code is practically mandatory given that the
> pm8921-core driver will WARN about it missing and the Kconfig
> marks it as default y when a PM8xxx chips is enabled. The only
> reason the file was split out was because we planned to support
> other pm8xxx chips with different pm8xxx-core.c files. Now that
> we have DT on ARM this isn't necessary because we should be able
> to support all the ssbi based PM8xxx chips in one driver and one
> file with no data bloat. Let's move this code into the only
> driver that uses it right now (pm8921) so that it's always compiled when
> needed. In the future we can rename pm8921-core.c to something
> more generic.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/Kconfig            |  10 --
>  drivers/mfd/pm8921-core.c      | 348 ++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/pm8xxx-irq.c       | 371 -----------------------------------------
>  include/linux/mfd/pm8xxx/irq.h |  23 ---
>  4 files changed, 348 insertions(+), 404 deletions(-)
>  delete mode 100644 drivers/mfd/pm8xxx-irq.c

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
