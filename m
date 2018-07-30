From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 30 Jul 2018 13:57:07 +0300
Subject: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
 <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
Message-ID: <c82487a125591c14e66ba56dc3202aa0093f0aba.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-30 at 10:55 +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 30, 2018 at 10:36 AM Phil Edworthy
> <phil.edworthy@renesas.com> wrote:

> > +struct clk *of_clk_get_by_name_optional(struct device_node *np,
> > +                                       const char *name)
> > +{
> > +       if (!np)
> > +               return ERR_PTR(-ENOENT);
> 
> Shouldn't this return NULL?
> Or let __of_clk_get_by_name() handle that (cfr. above)?
> 
> Hmm, of_clk_get_by_name() has a similar check, while the current
> __of_clk_get_by_name() already handle np == NULL, too.

This check is needed to prevent NULL pointer dereference below.

And I agree that absence of device node should be considered as okay
case for optional clock (!CONFIG_OF case, for example).

> > +
> > +       return __of_clk_get_by_name(np, np->full_name, name, true);
> > +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
