From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 09 Sep 2014 13:52:52 -0700
Subject: [PATCH] clk: efm32: fix build warning
In-Reply-To: <34912135.k5JMtvLE1Q@wuerfel>
References: <3456522.oqa7pbstSD@wuerfel>
 <20140908174805.GL23009@pengutronix.de>
 <34912135.k5JMtvLE1Q@wuerfel>
Message-ID: <20140909205252.19023.35880@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2014-09-08 11:18:57)
> On Monday 08 September 2014 19:48:05 Uwe Kleine-K?nig wrote:
> > On Mon, Sep 08, 2014 at 05:19:40PM +0200, Arnd Bergmann wrote:
> > > The normal prototype for of clk init functions is to return void,
> > > while efm32gg_cmu_init return an int, resulting in this harmless
> > > build warning:
> > > 
> > > drivers/clk/clk-efm32gg.c:81:189: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> > >  CLK_OF_DECLARE(efm32ggcmu, "efm32gg,cmu", efm32gg_cmu_init);
> > > 
> > > This changes the return type to avoid the warning.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > I already sent the exact same patch some time ago, even the sha1 sums in
> > the diff match.
> > 
> >         Subject: [PATCH] clk/efm32gg: fix dt init prototype
> >         Message-Id: <1406558301-17866-1-git-send-email-u.kleine-koenig@pengutronix.de>
> >         Date: Mon, 28 Jul 2014 16:38:21 +0200
> > 
> 
> Ok, good to see that we came to the same conclusion.
> 
> Mike, could you please try to get Uwe's patch into 3.17?

Done. Added your reviewed-by tag as well.

Regards,
Mike

> 
>         Arnd
