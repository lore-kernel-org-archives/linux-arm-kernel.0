From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 25 Jan 2013 22:01:52 +0100
Subject: [PATCH 01/10] gpio: pxa: set initcall level to module init
In-Reply-To: <1358929554-32265-2-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Wed, 23 Jan 2013 16:25:45 +0800")
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <87ham5nfi7.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> gpio & pinctrl driver are used together. The pinctrl driver is already
> launched before gpio driver in Makefile. So set gpio driver to module
> init level. Otherwise, the sequence will be inverted.
Hi Haojian,

If you switch gpio to module level, and as some modules use gpios in their init
path, isn't it possible that some modules will fail their init, as GPIO API
won't provide the gpio_*_value() functions ?

Cheers.

--
Robert
