From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 14:46:33 -0700
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <CACRpkdYgcYAFy7bBn3XNcrkSoCpeA8yNaa9LZNd4w33Zp3Jjnw@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <201209050513.08588.marex@denx.de>
 <20120905233416.GP1303@atomide.com>
 <201209060405.08997.marex@denx.de>
 <20120906174531.GX1303@atomide.com>
 <CACRpkdYgcYAFy7bBn3XNcrkSoCpeA8yNaa9LZNd4w33Zp3Jjnw@mail.gmail.com>
Message-ID: <20120907214633.GO1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120907 14:40]:
> On Thu, Sep 6, 2012 at 7:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> >> > The warning should be pinctrl related as the pinctrl drivers may not be
> >> > device tree based drivers.
> >>
> >> Exactly my concern. Also the warning shouldnt be present on systems where
> >> pinctrl is disabled.
> >
> > But pinctrl_get_select() returns 0 in include/linux/pinctrl/consumer.h if
> > CONFIG_PINCTRL is not selected, so no warning is produced AFAIK ;)
> 
> This is correct, nothing to worry about.
> 
> The one troublesome case is if a pinctrl driver is present but not
> being used, then you might need to call pinctrl_provide_dummies().

Thanks that's good to know.

Regards,

Tony
