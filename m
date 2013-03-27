From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Mar 2013 11:29:14 +0800
Subject: [PATCH 1/2] clk: mxs: get base address from device tree
In-Reply-To: <CAHXqBFK+VHTDHNcTcsmYkxtMPE-qxsZAO5w02YVkXnraWHGo3A@mail.gmail.com>
References: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
 <1364306374-10481-2-git-send-email-shawn.guo@linaro.org>
 <CAHXqBFK+VHTDHNcTcsmYkxtMPE-qxsZAO5w02YVkXnraWHGo3A@mail.gmail.com>
Message-ID: <20130327032913.GB2767@r65073-Latitude-E6420>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 04:12:35PM +0100, Micha? Miros?aw wrote:
> 2013/3/26 Shawn Guo <shawn.guo@linaro.org>:
> > Instead of using the static definitions, get clkctrl and digctl base
> > addresses with mapping from device tree.
> >
> > Use macro on variable is not nice, but it's done here to save huge
> > pointless diff stat.
> >
> [...]
> > @@ -100,6 +105,14 @@ int __init mx23_clocks_init(void)
> >         struct device_node *np;
> >         u32 i;
> >
> > +       np = of_find_compatible_node(NULL, NULL, "fsl,imx23-digctl");
> > +       digctrl = of_iomap(np, 0);
> > +       WARN_ON(!digctrl);
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "fsl,imx23-clkctrl");
> > +       clkctrl = of_iomap(np, 0);
> > +       WARN_ON(!clkctrl);
> > +
> 
> WARN? Won't the system die soon anyway if the addresses cannot be found?

Probably.  But this big fat warning is also good at telling where goes
wrong at the first place, so I do not see much difference than using BUG.

Shawn
