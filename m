From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 09:35:42 -0700
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <20120907160025.GB14330@glitch>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
 <20120907110251.GA7968@glitch>
 <331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
 <20120907160025.GB14330@glitch>
Message-ID: <20120907163542.GU1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Domenico Andreoli <cavokz@gmail.com> [120907 09:01]:
> 
> So is this the preferred way to attach gpio users to gpio provides in DT
> whenever gpios are muxed?
> 
> I would well see these info hidden in the gpio controller so, at least
> for gpios, no magic numbers would be required in the DT (except the gpio
> number relative to the owning controller).

In the pure GPIO pins only case it could be all done in the GPIO controller,
but it's probably best to have the pins muxed by the drivers using them.

Some drivers doing runtime PM may need to dynamically toggle the pins
for idle mode to stop leakage, enable wakeup events for rx pins etc.
Probably no need for that in the gpio leds case, but it would be confusing
to have some pins claimed by the GPIO driver and some by the drivers
using the pins.

Regards,

Tony
