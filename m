From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 13 Jun 2017 14:21:10 +0200
Subject: [PATCH v2] clockevents/tcb_clksrc: implement suspend/resume
In-Reply-To: <20170512182251.23948-1-alexandre.belloni@free-electrons.com>
References: <20170512182251.23948-1-alexandre.belloni@free-electrons.com>
Message-ID: <926f790a-3041-69fb-1501-2c8137f1ba65@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2017 20:22, Alexandre Belloni wrote:
> On sama5d2, power to the core may be cut while entering suspend mode. It is
> necessary to save and restore the TCB registers.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

The context will be saved/restored on all the platforms (other than
sama5d2) using this timer even if the clock is not powered down. Is that ok?

Should it be tagged for stable@?

Side note: the config option is in drivers/misc, any particular reason
to have it there and not in the clocksource's Kconfig?




-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
