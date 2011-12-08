From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 21:25:53 -0800
Subject: [PATCH V3] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <1322616559-31941-1-git-send-email-swarren@nvidia.com>
References: <1322616559-31941-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111208052553.GA30037@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 06:29:19PM -0700, Stephen Warren wrote:
> From: pdeschrijver at nvidia.com <pdeschrijver@nvidia.com>
> 
> Convert tegra20 IRQ intialization to the GIC devicetree binding. Modify the
> interrupt definitions in the dts files according to
> Documentation/devicetree/bindings/arm/gic.txt
> 
> v3 (swarren):
> * Moved of_irq_init() call into board-dt.c to avoid ifdef'ing it.
>   - Even with a dummy replacement if !CONFIG_OF, the reference from
>     tegra_dt_irq_match[] to gic_of_init() would still have to be ifdef'd
>   - It's plausible that tegra_dt_irq_match[] may need to contain more
>     entries in the future, and defining what they are seems more suitable
>     for board-dt.c than irq.c
> v2 (swarren):
> * Removed some stale GIC init code from board-dt.c
> * Undid some accidental 0x -> 0x0 search/replace.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied with minor fixup since Marc's rework of the irq code isn't in my
branch; the resulting merge conflict is trivial to fix up.

I applied this to for-3.3/dt (see separate email about branch changes).


-Olof
