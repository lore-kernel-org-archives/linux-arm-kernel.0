From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 04 Aug 2015 12:31:19 +0200
Subject: [PATCH 19/20] clocksource: atmel-st: get and use slow clock
In-Reply-To: <1438215726-27452-20-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438215726-27452-20-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55C09477.3080209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2015 02:22 AM, Alexandre Belloni wrote:
> The current slow clock rate is hardcoded. Properly get the slow clock
> and use its rate.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

[ ... ]

> +struct clk *sclk;

Do you need this variable global ? AFAICS, its scope is in the init 
function, no ?

> +int timer_latch;

static.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
