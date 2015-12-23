From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 22 Dec 2015 16:37:25 -0800
Subject: [PATCHv2] clk: ti: omap5+: dpll: implement errata i810
In-Reply-To: <20151216171650.GS23396@atomide.com>
References: <1450256530-10251-1-git-send-email-t-kristo@ti.com>
 <20151216171650.GS23396@atomide.com>
Message-ID: <20151223003725.GB14912@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On 12/16, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [151216 01:00]:
> > Errata i810 states that DPLL controller can get stuck while transitioning
> > to a power saving state, while its M/N ratio is being re-programmed.
> > 
> > As a workaround, before re-programming the M/N ratio, SW has to ensure
> > the DPLL cannot start an idle state transition. SW can disable DPLL
> > idling by setting the DPLL AUTO_DPLL_MODE=0 or keeping a clock request
> > active by setting a dependent clock domain in SW_WKUP.
> > 
> > This errata is known to impact OMAP5 and DRA7 chips, but lets enable it
> > unconditionally to avoid any potential problems with earlier generation
> > SoCs also.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> > v2: made the fix to be applied unconditionally on all OMAP3+ SoCs
> 
> Thanks looks good to me now:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Patch looks good to me too.

Stephen and I were discussing clk pull requests, more specifically how
to vet the contents of them. So we came up with the idea to add our acks
to patches that we take into our tree, but that we expect to get batched
up into a pull request. To that end:

Acked-by: Michael Turquette <mturquette@baylibre.com>

Regards,
Mike
