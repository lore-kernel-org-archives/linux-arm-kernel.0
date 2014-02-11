From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Feb 2014 21:38:42 -0800
Subject: [PATCH v3 2/5] clocksource: qcom: Move clocksource code out of
 mach-msm
In-Reply-To: <1391725484-6673-3-git-send-email-galak@codeaurora.org>
References: <1391725484-6673-1-git-send-email-galak@codeaurora.org>
 <1391725484-6673-3-git-send-email-galak@codeaurora.org>
Message-ID: <20140211053842.GE10784@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06, Kumar Gala wrote:
> diff --git a/arch/arm/mach-msm/timer.c b/drivers/clocksource/qcom-timer.c
> similarity index 98%
> rename from arch/arm/mach-msm/timer.c
> rename to drivers/clocksource/qcom-timer.c
> index fd16449..dca829e 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/drivers/clocksource/qcom-timer.c
> @@ -1,7 +1,7 @@
>  /*
>   *
>   * Copyright (C) 2007 Google, Inc.
> - * Copyright (c) 2009-2012, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2009-2012,2014, The Linux Foundation. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -26,10 +26,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  
> -#include <asm/mach/time.h>
> -
> -#include "common.h"
> -

This will cause sparse warnings because we no longer have the header included.

  CHECK   drivers/clocksource/qcom-timer.c
drivers/clocksource/qcom-timer.c:304:13: warning: symbol 'msm7x01_timer_init' was not declared. Should it be static?
drivers/clocksource/qcom-timer.c:317:13: warning: symbol 'msm7x30_timer_init' was not declared. Should it be static?
drivers/clocksource/qcom-timer.c:324:13: warning: symbol 'qsd8x50_timer_init' was not declared. Should it be static?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
