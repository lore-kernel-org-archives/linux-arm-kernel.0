From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 17:57:24 +0200
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <CAGb2v64bNTn5H1k-=rdTLPGYMfhTT8BuriaSAh9dNM__rLUi=Q@mail.gmail.com>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
 <CAGb2v64bNTn5H1k-=rdTLPGYMfhTT8BuriaSAh9dNM__rLUi=Q@mail.gmail.com>
Message-ID: <1502467044.2310.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-08-11 at 23:51 +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 11, 2017 at 9:06 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > +static int reset_simple_probe(struct platform_device *pdev)
> > +{
> > +???????struct device *dev = &pdev->dev;
> > +???????const struct of_device_id *of_id =
> > +???????????????of_match_device(of_match_ptr(reset_simple_dt_ids), dev);
> > +???????const struct reset_simple_devdata *devdata = of_id->data;
> 
> Just use of_device_get_match_data().

Will do that, thanks.

> > +struct reset_simple_data {
> > +???????spinlock_t??????????????????????lock;
> > +???????void __iomem????????????????????*membase;
> > +???????struct reset_controller_dev?????rcdev;
> > +???????bool????????????????????????????inverted;
> 
> You should document this option. "Inverted" by itself does not
> say a whole lot, as there is no mention about what the normal
> or non-inverted behavior is. Is the reset active low (assert
> reset when bit is cleared)? Or active high (assert reset when
> bit is set)?

You are right. Also, maybe I should rename this to
"bool active_low;" to avoid confusion where it is used.

regards
Philipp
