From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 29 Aug 2017 09:32:40 +0000
Subject: [PATCH 1/1] ARM: imx7ulp: add cpuidle support
In-Reply-To: <b8d1f428-a4f5-5a02-8aa4-379b5c85e8d7@linaro.org>
References: <1503841421-17677-1-git-send-email-aisheng.dong@nxp.com>
 <b8d1f428-a4f5-5a02-8aa4-379b5c85e8d7@linaro.org>
Message-ID: <AM3PR04MB30646BD7272372A182F22DA809F0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Daniel Lezcano [mailto:daniel.lezcano at linaro.org]
> Sent: Tuesday, August 29, 2017 4:30 PM
> To: A.s. Dong; linux-pm at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; rjw at rjwysocki.net;
> shawnguo at kernel.org; Anson Huang
> Subject: Re: [PATCH 1/1] ARM: imx7ulp: add cpuidle support
> 
> On 27/08/2017 15:43, Dong Aisheng wrote:
> > i.MX7ULP support 3 levels idle as below:
> > 1. patial stop mode 3;
> > 2. patial stop mode 2;
> > 3. patial stop mode 1.
> >
> > PSTOP1 - Partial Stop with system and bus clock disabled
> > PSTOP2 - Partial Stop with system clock disabled and bus clock enabled
> > PSTOP3 - Partial Stop with system clock enabled and bus clock enabled
> >
> > For PSTOP 1/2 mode, as the system and bus clock will be disabled, the
> > devices working inprogress may not be able to work anymore, driver
> > needs to use pm_qos API to prevent system enter those modes.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Will you consider in the future to move the driver to a DT based
> description and to the cpuidle-arm driver ?
> 

Thanks for the suggestion.
I will investigate it later when I'm free.

Shawn,
This is based on the former imx7ulp arch patch series.
Will notify you once they're merged.

Regards
Dong Aisheng

> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter | <http://www.linaro.org/linaro-
> blog/> Blog
