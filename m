From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Dec 2014 18:16:37 +0100
Subject: [PATCH] ARM: imx: irq: fix buggy usage of irq_data irq field
In-Reply-To: <1417454074.4624.28.camel@pengutronix.de>
References: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
 <CAOMZO5DoR57Afc3SH-gV3-dZkHvBab1LXKCWDajpf_sRDKpzSw@mail.gmail.com>
 <547C9F58.5070903@arm.com> <1417454074.4624.28.camel@pengutronix.de>
Message-ID: <1417454197.4624.30.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 01.12.2014, 18:14 +0100 schrieb Philipp Zabel:
> Am Montag, den 01.12.2014, 17:03 +0000 schrieb Marc Zyngier:
> > On 01/12/14 17:00, Fabio Estevam wrote:
> > > Hi Marc,
> > > 
> > > On Mon, Dec 1, 2014 at 2:25 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > >> mach-imx directly references to the irq field in
> > >> struct irq_data, and uses this to directly poke hardware register.
> > >>
> > >> But irq is the *virtual* irq number, something that has nothing
> > >> to do with the actual HW irq (stored in the hwirq field). And once
> > >> we put the stacked domain code in action, the whole thing explodes,
> > >> as these two values are *very* different.
> > >>
> > >> Just replacing all instances of irq with hwirq fixes the issue.
> > >>
> > >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > 
> > > I tested your patch and I still have the following problem on a mx6q:
> > 
> > [...]
> > 
> > > This issue does not happen on linux-next 20141126, but it stats at 201411267.
> > > 
> > > I haven't bisect it yet, but if you have any ideas, please let me know. Thanks
> > 
> > I do have an idea indeed, as well as a patch for this. I'll put you on
> > Cc, watch that space.
> 
> I've just arrived att his workaround for the issue by just directly
> going to hwirq 32, please put me on Cc, too.

Never mind that, I just got that mail. Thanks!

regards
Philipp
