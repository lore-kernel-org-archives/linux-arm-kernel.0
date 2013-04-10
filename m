From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Apr 2013 13:21:21 -0700
Subject: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support
 for AUXCLKs
In-Reply-To: <CAGo_u6rqN6YFQ6vX87-Cg28RbiR9UU2JHgLecOU5Nd=B5XPUEA@mail.gmail.com>
References: <20130405155851.GA10155@atomide.com> <5163E589.1040809@ti.com>
 <20130409164928.GL10155@atomide.com>
 <20130409174319.GP10155@atomide.com> <20130409204900.GA8815@kahuna>
 <20130410080630.14359.68178@quantum> <5165453E.6090503@ti.com>
 <20130410173921.GA31017@kahuna>
 <20130410184919.GJ10155@atomide.com>
 <CAGo_u6rqN6YFQ6vX87-Cg28RbiR9UU2JHgLecOU5Nd=B5XPUEA@mail.gmail.com>
Message-ID: <20130410202121.GM10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [130410 12:23]:
> On Wed, Apr 10, 2013 at 1:49 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > We can avoid the concern of storing the struct clk * and do the
> > look up lazily on consumer driver probe by setting a dummy struct
> > clk * here. Then replace of_clk_src_simple_get() with a custom
> > omap_clk_src_get() that does the lookup and replaces the struct
> > clk * with the real one.
> Hmm.. this is interesting. will give it a try. Thanks on the suggestion.

Setting the struct clk * to NULL initially might work too, but that
needs to be checked.

Regards,

Tony
