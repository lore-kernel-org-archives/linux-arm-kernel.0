From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Aug 2017 10:30:08 +0200
Subject: [PATCH 1/1] ARM: imx7ulp: add cpuidle support
In-Reply-To: <1503841421-17677-1-git-send-email-aisheng.dong@nxp.com>
References: <1503841421-17677-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <b8d1f428-a4f5-5a02-8aa4-379b5c85e8d7@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2017 15:43, Dong Aisheng wrote:
> i.MX7ULP support 3 levels idle as below:
> 1. patial stop mode 3;
> 2. patial stop mode 2;
> 3. patial stop mode 1.
> 
> PSTOP1 - Partial Stop with system and bus clock disabled
> PSTOP2 - Partial Stop with system clock disabled and bus clock enabled
> PSTOP3 - Partial Stop with system clock enabled and bus clock enabled
> 
> For PSTOP 1/2 mode, as the system and bus clock will be disabled, the
> devices working inprogress may not be able to work anymore, driver needs
> to use pm_qos API to prevent system enter those modes.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Will you consider in the future to move the driver to a DT based
description and to the cpuidle-arm driver ?

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
