From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 Jul 2018 13:29:49 +0200
Subject: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <c82487a125591c14e66ba56dc3202aa0093f0aba.camel@linux.intel.com>
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
 <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
 <c82487a125591c14e66ba56dc3202aa0093f0aba.camel@linux.intel.com>
Message-ID: <CAMuHMdWXfS9gFxOq5nvJWx2KMOae5_c8Lb0omeE3P9yjyYZ7gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Mon, Jul 30, 2018 at 12:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2018-07-30 at 10:55 +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 30, 2018 at 10:36 AM Phil Edworthy
> > <phil.edworthy@renesas.com> wrote:
>
> > > +struct clk *of_clk_get_by_name_optional(struct device_node *np,
> > > +                                       const char *name)
> > > +{
> > > +       if (!np)
> > > +               return ERR_PTR(-ENOENT);
> >
> > Shouldn't this return NULL?
> > Or let __of_clk_get_by_name() handle that (cfr. above)?
> >
> > Hmm, of_clk_get_by_name() has a similar check, while the current
> > __of_clk_get_by_name() already handle np == NULL, too.
>
> This check is needed to prevent NULL pointer dereference below.

Thank, I had missed that unexpected detail.

> > > +
> > > +       return __of_clk_get_by_name(np, np->full_name, name, true);
> > > +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
