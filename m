From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Dec 2014 15:14:18 -0200
Subject: [PATCH] ARM: imx: irq: fix buggy usage of irq_data irq field
In-Reply-To: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
References: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAOMZO5DQTsc_dWnBrndsenhhVn-6rnjhmvGV_fYTYT8Rug27rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 1, 2014 at 2:25 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> mach-imx directly references to the irq field in
> struct irq_data, and uses this to directly poke hardware register.
>
> But irq is the *virtual* irq number, something that has nothing
> to do with the actual HW irq (stored in the hwirq field). And once
> we put the stacked domain code in action, the whole thing explodes,
> as these two values are *very* different.
>
> Just replacing all instances of irq with hwirq fixes the issue.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
