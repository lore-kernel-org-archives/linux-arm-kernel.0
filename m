From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 May 2018 12:27:15 +0200
Subject: [RFC PATCH 00/10] Add persistent clock support
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Message-ID: <20180515102715.GO29062@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
> Hi,
> 
> We will meet below issues when compensating the suspend time for the timekeeping.
> 
> 1. We have too many different ways of dealing with persistent timekeeping
> across architectures, so it is hard for one driver to compatable with different
> architectures.
> 
> 2. On some platforms (such as Spreadtrum platform), we registered the high
> resolution timer as one clocksource to update the OS time, but the high
> resolution timer will be stopped in suspend state. So we use another one
> always-on timer (but low resolution) to calculate the suspend time to
> compensate the OS time. Though we can register the always-on timer as one
> clocksource, we need re-calculate the mult/shift with one larger conversion
> range to calculate the suspend time and need update the clock in case of
> running over the always-on timer.

First, can you elaborate what you mean by 'suspend state' ? On which power
domain the clocksource belongs to?


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
