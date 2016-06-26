From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Jun 2016 18:24:31 +0200
Subject: [PATCH v2 00/15] clk: sunxi: introduce "modern" clock support
In-Reply-To: <20160621014816.GT1521@codeaurora.org>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160621014816.GT1521@codeaurora.org>
Message-ID: <20160626162431.GL4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jun 20, 2016 at 06:48:16PM -0700, Stephen Boyd wrote:
> On 06/07, Maxime Ripard wrote:
> > 
> > The current code has been tested on the H3 and an Orange Pi PC,
> > including making sure that MMC still works, so the general approach
> > seems ok.
> > 
> > Let me know what you think,
> 
> Overall this looks pretty good. Thanks for taking the time to
> rework the driver.
> 
> The macro nesting is sort of concerning, but if you're willing to
> live with a maze of macros I'm not too worried. Also, I don't see
> why we have to use the ccu_common structure everywhere even when
> we're not gaining from it, but it's not a huge problem either
> way. The non-mmio clks could be split off from the mmio list and
> then registered in two lists, or there could be mmio list that
> sets up the base address and then a larger list of clk_hw
> pointers that we just run through and register.

Ok, I'll move the fixed factor clocks out of the ccu_common list.

> It would be great if we could squeeze some more code reuse out of
> the basic types too, but I'm not sure if there's much more that
> can be done. Sometimes I'm seeing the same code multiple times
> for handling muxes with parents and dividers or muxes without
> dividers, etc. But that seems like future work that isn't going
> to block anything here.

I tried my best already to move the common code, but it's not clear at
this point what can be factorised and what will only be used by a
single clock driver. Obviously, as we will support more SoCs, that
will become clearer and we will be able to factor out the code that
needs to be.

> Finally, can you please use the clk_hw_register() APIs that we've
> recently added. That will save us some time converting a new
> driver over to use the new style of registering clks.

Ack, consider it done.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160626/ed09bfb9/attachment.sig>
