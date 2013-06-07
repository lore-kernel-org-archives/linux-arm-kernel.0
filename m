From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 12:54:13 +0200
Subject: [PATCH v2 5/6] ARM: hi3xxx: add board support with device tree
In-Reply-To: <CAD6h2NRPpLWCrSh_r=049AVKzvPOqVqsSVzM+twG1jRY0eSnmw@mail.gmail.com>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
 <1456134.qV9IZTo572@wuerfel>
 <CAD6h2NRPpLWCrSh_r=049AVKzvPOqVqsSVzM+twG1jRY0eSnmw@mail.gmail.com>
Message-ID: <3499350.BTphoei3mz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013 11:04:27 Haojian Zhuang wrote:
> On 4 June 2013 23:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 04 June 2013 23:05:16 Haojian Zhuang wrote:
> >
> >> +static void __init hi3xxx_timer_init(void)
> >> +{
> >> +     of_clk_init(NULL);
> >> +     clocksource_of_init();
> >> +}
> >
> > I plan to make this the default, so maybe we will be able to get rid
> > of this function soon. Right now it is still needed, as we only
> > call clocksource_of_init() but not of_clk_init().
> >
> But my timer driver accesses clk. So I need to call of_clk_init() before
> clocksource_of_init(). Up to now, of_clk_init() isn't called by default.

Yes, I know. I mean we should change the common code to call of_clk_init
by default, and do that before calling clocksource_of_init().

	Arnd
