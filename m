From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 14:48:04 +0200
Subject: [PATCH RESEND 1/5] pinctrl: allows not to define the
 get_group_pins operation
In-Reply-To: <1397135274-10764-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdZrLZZwpVCzo_Ms2=7SqUoryt-6OtF7ePhGp4kwJgDgXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 3:07 PM, Antoine T?nart
<antoine.tenart@free-electrons.com> wrote:

> When using a group only pinctrl driver, which does not have any
> information on the pins it is useless to define a get_group_pins
> always returning an empty list of pins.
>
> When not using get_group_pin[1], a driver must implement it so
> pins = NULL and num_pins = 0. This patch makes it the default
> behaviour if not defined in the pinctrl driver when used in
> pinmux enable and disable funtions and in pinctrl_groups_show.
>
> It also adds a check in pinctrl_get_group_pins and return -EINVAL if
> not defined. This function is called in the gpiolib when adding when
> pingroup range. It cannot be used if no group is defined, so this seams
> reasonable.
>
> [1] get_group_pin(struct pinctrl_dev *pctldev,
>                   unsigned selector,
>                   const unsigned **pins,
>                   unsigned *num_pins);
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>

OK makes perfect sense.

Patch applied.

Can you please check the Documentation/pinctrl.txt to see
if anything needs to be updated due to this?

Yours,
Linus Walleij
