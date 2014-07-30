From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 30 Jul 2014 15:18:39 +0300
Subject: [PATCH] ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to
 round to next-lowest rate
In-Reply-To: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
Message-ID: <53D8E29F.3010906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/14 13:44, Paul Walmsley wrote:
> 
> Change the behavior of omap2_dpll_round_rate() to round to either the
> exact rate requested, or the next lowest rate that the clock is able to
> provide.
> 
> This is not an ideal fix, but is intended to provide a relatively safe
> way for drivers to set PLL rates, until a better solution can be
> implemented.
> 
> For the time being, omap3_noncore_dpll_set_rate() is still allowed to
> set its rate to something other than what the caller requested; but will
> warn when this occurs.
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Tested on AM437x GP EVM with today's linux-next + this patch. Without
the patch I was only able to use certain pixel clocks, but with this
patch I can select the pixel clock freely (they end up rounded, of course).

So looks good to me. Thanks for working on this!

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/a6768c2e/attachment.sig>
