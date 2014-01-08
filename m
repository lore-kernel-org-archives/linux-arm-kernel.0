From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Jan 2014 21:36:49 +0000
Subject: [PATCH v3 3/7] mfd: pm8921: Migrate to irqdomains
In-Reply-To: <1389206270-3728-4-git-send-email-sboyd@codeaurora.org>
References: <1389206270-3728-1-git-send-email-sboyd@codeaurora.org>
 <1389206270-3728-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140108213649.GB18611@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Jan 2014, Stephen Boyd wrote:

> Convert this driver to use irqdomains so that the PMIC's child
> devices can be converted to devicetree.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/pm8921-core.c         | 198 +++++++++++++++-----------------------
>  include/linux/mfd/pm8xxx/irq.h    |  36 -------
>  include/linux/mfd/pm8xxx/pm8921.h |  30 ------
>  3 files changed, 75 insertions(+), 189 deletions(-)
>  delete mode 100644 include/linux/mfd/pm8xxx/irq.h
>  delete mode 100644 include/linux/mfd/pm8xxx/pm8921.h

I'm still a little dubious over the lack of an irq_create_mapping()
call, but if you say you've tested it and it works I guess something
else must be going on in its place.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
