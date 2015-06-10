From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 09:48:21 +0200
Subject: [RFC] pinctrl: pinctrl-imx: implement suspend/resume
In-Reply-To: <9333041871b27a3099b185e26b564e2a@agner.ch>
References: <1433171567-24571-1-git-send-email-stefan@agner.ch>
 <CAHrpEqS8qYUrcSoNSDMB9tA+D_KcfoSWz75VDSk-S=ZNpwU7mg@mail.gmail.com>
 <9333041871b27a3099b185e26b564e2a@agner.ch>
Message-ID: <CACRpkdYoAZyP5AHeOjksdSVN9H+crOse2syDTSOb_Mh7NyMbhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 10:24 PM, Stefan Agner <stefan@agner.ch> wrote:

> I actually tried to experiment with pinctrl_pm_select_default_state and
> pinctrl_pm_select_sleep_state. I think, one solution would be to create
> sleep states for all drivers. However, it's not necessary to change to a
> sleep state, since the controller looses the state anyway. What would be
> required is having a function which allows to force the default state
> for all pinctrl settings... As far as I can tell, there is no such
> functionality currently...? Linus?

You could do it that way, but it requires that the driver depends
on CONFIG_PM as the states are not cached in the driver
core otherwise (drivers/base/pinctrl.c).

I have no strong opinion on the subject really... either way works.

Yours,
Linus Walleij
