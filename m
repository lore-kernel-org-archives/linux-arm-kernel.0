From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 4 Mar 2012 18:26:11 +0000 (GMT)
Subject: Status of gpio-pxa driver and dummy clock
In-Reply-To: <87aa3wu0hp.fsf@free.fr>
Message-ID: <1330885571.28077.YahooMailClassic@web29015.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Sun, 4/3/12, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Subject: Re: Status of gpio-pxa driver and dummy clock
> To: "Haojian Zhuang" <haojian.zhuang@gmail.com>
> Cc: "Arnd Bergmann" <arnd@arndb.de>, linux-arm-kernel at lists.infradead.org
> Date: Sunday, 4 March, 2012, 10:25
> Haojian Zhuang <haojian.zhuang@gmail.com>
> writes:
> 
> > On Sun, Mar 4, 2012 at 5:34 AM, Robert Jarzmik <robert.jarzmik@free.fr>
> wrote:
> >> Hi Haojian,
> >>
> >> As you certainly know, Russell reverted the patch
> "ARM: pxa: add dummy clock for
> >> sa1100-rtc", id
> a55b5adaf403c4d032e0871ad4ee3367782f4db6. As a consequence,
> the
> >> dummy clock for gpio-pxa was removed, causing
> breakage of gpio-pxa driver.
> >>
> >> I wonder if you (or somebody through you) sent an
> update to fix the gpio-pxa by
> >> either fixing gpio-pxa or adding back "pxa-gpio"
> clock. As of today, I see no
> >> fix in 3.3-rc free (Linus tree).
> >>
> >
> > This patch is already merged into arm-soc tree for
> v3.4. I don't have
> > a plan to push it into
> > v3.3.
> 
> Oh, you should push it to 3.3. It's a fix, and the mioa701
> board is broken (and
> probably many others PXA based boards too) because no GPIO
> is available (as
> probe function of pxa-gpio always fail on clk_get()).
> 
> If you don't want to push it to 3.3, I'll have to send a fix
> to Arnd to fix the
> breakage.
> 
> Without it, a PXA based kernel (pxa2xx) will hang in its
> boot phase, on the
> first gpio_get_* or gpio_set_*, which is called by many
> drivers.

There are two further pxa gpio regressions still present in
linux-3.3-rc5:

mfp/gpio regression: pxa_last_gpio used before initialized
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082624.html

reboot/suspend regression: hx4700 freezes under linux-3.3-rc1
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/082873.html
(2 regressions are reported here; the reboot regression is still present in
linux-3.3-rc5 while the suspend regression has now been fixed).
