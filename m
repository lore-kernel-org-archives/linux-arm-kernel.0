From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 4 Jun 2013 09:52:42 +0000
Subject: [PATCH 09/11] mmc: omap_hsmmc: enhance pinctrl support
In-Reply-To: <CACRpkdYeh6UXnbUXiiZLPP+FUz11HKaD-FrHHaqUGX8AmA_p6g@mail.gmail.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-10-git-send-email-gururaja.hebbar@ti.com>
 <CACRpkdbiYX5q8rvtV3Xcv7VdiJo2-6rGHNtvB1V=8C_qCpc=JA@mail.gmail.com>
 <CACRpkdYeh6UXnbUXiiZLPP+FUz11HKaD-FrHHaqUGX8AmA_p6g@mail.gmail.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC2235F@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 12:49:57, Linus Walleij wrote:
> On Tue, Jun 4, 2013 at 9:11 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, May 31, 2013 at 12:13 PM, Hebbar Gururaja
> > <gururaja.hebbar@ti.com> wrote:
> >
> >> Amend the hsmmc controller to optionally take a pin control handle and
> >> set the state of the pins to:
> >>
> >> - "default" on boot, resume and before performing a mmc transfer
> >> - "idle" after initial default, after resume default, and after each
> >> mmc/sd card access
> >> - "sleep" on suspend()
> >>
> >> By optionally putting the pins into sleep state in the suspend callback
> >> we can accomplish two things.
> >> - One is to minimize current leakage from pins and thus save power,
> >> - second, we can prevent the IP from driving pins output in an
> >> uncontrolled manner, which may happen if the power domain drops the
> >> domain regulator.
> >>
> >> If any of the above pin states are missing in dt, a warning message
> >> about the missing state is displayed.
> >> If certain pin-states are not available, to remove this warning message
> >> pass respective state name with null phandler.
> >>
> >> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> >> Cc: Balaji T K <balajitk@ti.com>
> >> Cc: Chris Ball <cjb@laptop.org>
> >> Cc: linux-mmc at vger.kernel.org
> >> Cc: linux-omap at vger.kernel.org
> >
> > This is perfectly correct.
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> So please consider my other option given in patch 2 instead.

I will check how I can be a part of this implementation

> 
> Yours,
> Linus Walleij
> 


Regards, 
Gururaja
