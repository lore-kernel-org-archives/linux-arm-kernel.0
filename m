From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 13:53:27 +0100
Subject: [PATCH v9 04/10] pinctrl: check pinctrl ready for gpio range
In-Reply-To: <1361101376-3783-5-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
 <1361101376-3783-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkda0Qt8qsJHGBCmRM1dRqhQSZcBY-ujCeKNJOpzvm2TraQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> pinctrl_get_device_gpio_range() only checks whether a certain GPIO pin
> is in gpio range. But maybe some GPIO pins don't have back-end pinctrl
> interface, it means that these pins are always configured as GPIO
> function. For example, gpio159 isn't related to back-end pinctrl device
> in Hi3620 while other GPIO pins are related to back-end pinctrl device.
>
> Append pinctrl_ready_for_gpio_range() that is used to check whether
> pinctrl device with GPIO range is ready. This function will be called
> after pinctrl_get_device_gpio_range() fails.
>
> If pinctrl device with GPIO range is found, it means that pinctrl device
> is already launched and a certain GPIO pin just don't have back-end pinctrl
> interface. Then pinctrl_request_gpio() shouldn't return -EPROBE_DEFER in
> this case.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Patch applied to the pinctrl tree for v3.10.

Thanks,
Linus Walleij
