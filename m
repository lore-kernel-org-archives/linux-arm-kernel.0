From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 May 2014 11:19:10 +0200
Subject: [PATCH v2 0/8] pinctrl-rockchip: Change wrong initial assumptions
In-Reply-To: <11862890.WUjscWaP3U@diego>
References: <11862890.WUjscWaP3U@diego>
Message-ID: <CACRpkdbhfVj2-aW2-mJa0c6uq52EKgKJEFy=BJoiqR98F52RaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 1:57 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Initially due to lack of documentation and (personal) understanding
> I assumed that the area holding the iomux settings would be separate
> from everything else, while in fact the grf registers contain not only
> pinctrl stuff but also dma, usb-phy and general soc-status settings.
> Also things like drive-strength we do not support currently are intermixed.
>
> The same is true for the pmu, which does not only contain power domains
> but also the system reset as well as well as general registers surviving
> system-resets. Additionally the rk3188 moved parts of the pull-setting
> registers into the pmu space.
>
> While this wasn't a problem until now, the upcoming rk3288 introduces
> additional changes to both the grf and pmu areas. On it even part of
> the pinmux registers move into the pmu space.
>
> The code in it's current form supports both the old as well as the
> changed bindings.
>
> As stated in the v1 thread, this is also a first step to deprecate the
> wrongly included gpio-controllers which now duplicate the recently added
> gpio-dwapb, that should be used instead.

Patched 1 thru 7 applied to the pin control tree.

We knew this would be a bumpy ride when the merging started so this
is all expected.

Yours,
Linus Walleij
