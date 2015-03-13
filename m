From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Mar 2015 11:25:29 +0100
Subject: [PATCH v3 05/12] clocksource: add dependencies for Vybrid pit
 clocksource
In-Reply-To: <1426203380-7155-6-git-send-email-stefan@agner.ch>
References: <1426203380-7155-1-git-send-email-stefan@agner.ch>
 <1426203380-7155-6-git-send-email-stefan@agner.ch>
Message-ID: <5502BB19.1020509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2015 12:36 AM, Stefan Agner wrote:
> Add the minimal dependencies required to use the Vybrid PIT
> clocksource driver. Those are not part of the SoC dependencies.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/clocksource/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 1c2506f..350e742 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -164,6 +164,8 @@ config FSL_FTM_TIMER
>
>   config VF_PIT_TIMER
>   	bool
> +	select CLKSRC_MMIO
> +	select CLKSRC_OF
>   	help
>   	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
