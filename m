From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 15:40:32 +0100
Subject: [PATCH 2/3] pinctrl: at91: initialize config parameter to 0
In-Reply-To: <52A5938E.40201@free-electrons.com>
References: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1386421734-10240-2-git-send-email-alexandre.belloni@free-electrons.com>
 <52A57E55.40808@atmel.com> <52A5938E.40201@free-electrons.com>
Message-ID: <CACRpkdbxq-w8KquMjQVSbkEZcsMLsSRc3BqfuLLDM7c1P3UOxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 9, 2013 at 10:55 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> I'm actually wondering if the checks for the ops->pin_config_get are not
> a bit overkill. We check for that function in:
>  - pinconf_check_ops()
>  - before calling it in pin_config_get_for_pin() which is only used
> once, in the same path : dump using debugfs and having ops->is_generic
> == true
>  - in pinconf_pins_show() which is the function calling also in the same
> path
>
> What I would do is:
>  - remove all the checks in pinconf_check_ops() and pinconf_pins_show()
> so that people are not pressured to implement a function that is simply
> never used.
>  - modify pin_config_get_for_pin() by removing the dev_err() call and
> returning -ENOTSUPP instead of -EINVAL (it doesn't change the behaviour
> but I feel -ENOTSUPP is more appropriate)
>
> I have a patch ready but I can't test it as I don't own any of the
> is_generic platforms.

Mail it out with a [CFT: ] "call for testing" prefix.

Yours,
Linus Walleij
