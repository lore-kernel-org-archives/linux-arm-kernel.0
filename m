From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 21 May 2012 11:58:31 +0300
Subject: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings
 in OFF mode
In-Reply-To: <87d363928g.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com>
Message-ID: <1337590711.2149.387.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-16 at 15:42 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > SAR/ROM code restores only CORE DPLL to its original state
> > post wakeup from OFF mode.
> > The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
> > are saved and restored here during an OFF transition.
> >
> > [nm at ti.com: minor cleanups]
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Some general comments:
> 
> - the register dump/print doesn't belong here.  If needed, should be a
>   debug feature if needed.

Okay, I'll just drop it out.

> 
> - Rather than hooking into omap4_enter_lowpower(), should use
>   the cluster PM enter/exit notifier chain.

Yes can do that.

-Tero
