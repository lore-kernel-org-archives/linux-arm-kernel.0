From: chunkeey@googlemail.com (Christian Lamparter)
Date: Sun, 08 May 2016 20:27:24 +0200
Subject: [PATCH v8 2/3] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <CAGhQ9VyG6yX+g=FjfB6VP0pUNYGYXo60CHkWmSiiOisjeX20cg@mail.gmail.com>
References: <cover.1462543457.git.chunkeey@googlemail.com>
 <535f785bf6116c0fb6f46afbb77e6d4bd3ef5f60.1462543458.git.chunkeey@googlemail.com>
 <CAGhQ9VyG6yX+g=FjfB6VP0pUNYGYXo60CHkWmSiiOisjeX20cg@mail.gmail.com>
Message-ID: <1946866.9Xyiz0Lzsg@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 08, 2016 07:17:13 PM Joachim Eastwood wrote:
> > +#define ADD(_name, _func) { .compatible = _name, .data = _func }
> 
> I don't see the point in having a macro for such a simple data
> structure, but since this v8 and Linus hasn't complained I guess it's
> fine.
>
> Using a macro here makes it impossible to grep for 'compatible'. Doing
> 'git grep compatible drivers/gpio/' is sometimes very useful to see
> which hardware the driver actually supports.

Ok. I'll definitely picking it up. I'll wait until Tuesday/Wednesday
for more comments and then release a new series.
 
> > +static const struct of_device_id bgpio_of_match[] = {
> > +       ADD("wd,mbl-gpio", bgpio_basic_mmio_parse_dt),
> > +       { }
> > +};
> > +#undef ADD
> > +MODULE_DEVICE_TABLE(of, bgpio_of_match);
> > +
> > +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> > +                                         unsigned long *flags)
> > +{
[...]
> > +       of_id = of_match_node(bgpio_of_match, node);
> > +       if (!of_id)
> > +               return NULL;
[...]
> You can retrieve OF match data using of_device_get_match_data().
> Saves you a couple of lines and better explains what your doing.
Yes thanks that's useful too since I don't need the of_id variable
anymore.

Both improvements save a total of 8 lines. so it's 328 insertions(+)
vs 380 deletions(-).

Regards,
Christian
