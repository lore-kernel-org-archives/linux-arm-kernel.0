From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 17:46:20 +0000
Subject: [PATCH 05/10] clkdev: add clkdev_create() helper
In-Reply-To: <CAMuHMdWHAu+zDKce0+ianDb=RHYR59eeMoiYBDK4PC=YMY0JXg@mail.gmail.com>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnW-0001Jk-Tm@rmk-PC.arm.linux.org.uk>
 <CAMuHMdWHAu+zDKce0+ianDb=RHYR59eeMoiYBDK4PC=YMY0JXg@mail.gmail.com>
Message-ID: <20150302174619.GD29584@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 06:22:31PM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 2, 2015 at 6:06 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > --- a/include/linux/clkdev.h
> > +++ b/include/linux/clkdev.h
> > @@ -37,6 +37,9 @@ struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> >  void clkdev_add(struct clk_lookup *cl);
> >  void clkdev_drop(struct clk_lookup *cl);
> >
> > +struct clk_lookup *clkdev_create(struct clk *clk, const char *con_id,
> > +       const char *dev_fmt, ...);
> 
> __printf(3, 4)
> 
> While you're at it, can you please also add the __printf attribute to
> clkdev_alloc() and clk_register_clkdev()?

What's the behaviour of __printf() with a NULL format string?  The
clkdev interfaces permit that, normal printf() doesn't.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
