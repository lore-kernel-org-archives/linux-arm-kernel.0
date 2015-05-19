From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 16:58:19 +0200
Subject: [PATCH v2 04/10] pinctrl: sunxi: Prepare for building SoC
 specific drivers as modules
In-Reply-To: <20150519075537.GU4004@lukather>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-5-git-send-email-jenskuske@gmail.com>
 <20150517141922.GE4004@lukather> <5559B1AF.2010200@gmail.com>
 <20150519075537.GU4004@lukather>
Message-ID: <CACRpkdaUHiqKaVr71p9sVaXHAdVYC2v6u-OT8pdnVC5rN_t+0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 9:55 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

>> Apart from that, currently the kernel panics some seconds after removing
>> the pinctrl module because mmc wants to access a gpio. Can this be
>> prevented somehow? I think pinctrl must not be removed once other
>> devices use any pin-related things.
>
> pinctrl_unregister doesn't look like it cares about whether or not
> there's users left in the system.

Both GPIO and pinctrl has this problem, Johan Hovold has been
looking at fixing the GPIO side of things.

Patches welcome.

Yours,
Linus Walleij
