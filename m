From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Mar 2015 14:26:02 +0100
Subject: [PATCH v2] clocksource: atmel-st: select MFD_SYSCON
In-Reply-To: <1426771068-9657-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426771068-9657-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <550ACE6A.4000705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 02:17 PM, Alexandre Belloni wrote:
> Enforce MFD_SYSCON selection as the driver needs it. Else, it will still
> compile with some warning about X1, x2 or sr being used uninitialized.
>
> Reported-by: fengguang.wu at intel.com
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Daniel,
>
> I think this should go through the at91 tree as the patch introducing that issue
> went there.

Ok.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>   drivers/clocksource/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 168035883afa..55aef6f89074 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -146,6 +146,7 @@ config ATMEL_PIT
>   config ATMEL_ST
>   	bool
>   	select CLKSRC_OF
> +	select MFD_SYSCON
>
>   config CLKSRC_METAG_GENERIC
>   	def_bool y if METAG
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
