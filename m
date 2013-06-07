From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Jun 2013 09:53:36 +0200
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
In-Reply-To: <51AF73E9.90506@wwwdotorg.org>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
 <51AF73E9.90506@wwwdotorg.org>
Message-ID: <CACRpkdZ4mO27NX0ccc7d_zmNoBQbvYZKOYm3NRH7f12HD9=NqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 7:22 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
>
>> +int pinctrl_pm_select_default_state(struct device *dev)
>
>> +int pinctrl_pm_select_sleep_state(struct device *dev)
>
>> +int pinctrl_pm_select_idle_state(struct device *dev)
>
> The implementation of those 3 functions is basically identical. I'd be
> inclined to move it to a helper function, and just pass (dev,
> pins->xxx_state) to it.

Point taken, but as the comments only affect pinctrl/core.c
and I got so many nice ACKs on the patch, I'll apply this
and think about a refactoring patch only hitting the core
in drivers/pinctrl/* to nice this up. (Need this infrastructure
in place for the OMAP work now I think...)

Yours,
Linus Walleij
