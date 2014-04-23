From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 23 Apr 2014 10:24:09 +0200
Subject: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
In-Reply-To: <CAL_JsqJwC2xcZakXiJXJscK7tN7xt2OotBKyr9u+aK3bOP+7GQ@mail.gmail.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
 <CAL_JsqJwC2xcZakXiJXJscK7tN7xt2OotBKyr9u+aK3bOP+7GQ@mail.gmail.com>
Message-ID: <20140423082409.GC24355@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, Apr 22, 2014 at 01:54:33PM -0500, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 1:47 PM, Rob Herring <robherring2@gmail.com> wrote:
> > On Tue, Apr 22, 2014 at 10:38 AM, Antoine T?nart
> > <antoine.tenart@free-electrons.com> wrote:
> >> Add support for the Berlin SoCs AHCI SATA controller allowing to
> >> interface with devices like external hard drives.
> 
> One more thing.
> 
> >> +       nports = readl(hpriv->mmio + HOST_PORTS_IMPL);
> >> +
> >> +       /* force_map is modified only if the property is found */
> >> +       of_property_read_u32(np, "marvell,force-port-map", &force_map);
> 
> This property does not appear to be documented.

I'll update it regarding Sebastian comments, or maybe drop it if it is
possible to enable each port individually.

> 
> >> +       if (force_map)
> >> +               nports = force_map;
> 
> You don't need this as your comment says, you can just do:
> 
> of_property_read_u32(np, "marvell,force-port-map", &nports);
> 
> nports will only be changed if property is present.

Sure.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
