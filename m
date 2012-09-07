From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 23:59:23 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <20120907163542.GU1303@atomide.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
 <20120907110251.GA7968@glitch>
 <331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
 <20120907160025.GB14330@glitch> <20120907163542.GU1303@atomide.com>
Message-ID: <CACRpkdZbyUFvYuou015ge+k8zroNtL9s9HFKsVC5OJV8NHEorg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 6:35 PM, Tony Lindgren <tony@atomide.com> wrote:

> In the pure GPIO pins only case it could be all done in the GPIO controller,
> but it's probably best to have the pins muxed by the drivers using them.

Yes, that's an easier way to say the long unreadable thing I just
posted ...

> Some drivers doing runtime PM may need to dynamically toggle the pins
> for idle mode to stop leakage, enable wakeup events for rx pins etc.
> Probably no need for that in the gpio leds case, but it would be confusing
> to have some pins claimed by the GPIO driver and some by the drivers
> using the pins.

True. drivers/tty/serial/amba-pl011.c provides a simple example.

Yours,
Linus Walleij
