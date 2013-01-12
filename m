From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 11 Jan 2013 18:53:19 -0800
Subject: [PATCH] ARM: OMAP4: clock/hwmod data: remove MODULEMODE entries
 in mux + gate combos
In-Reply-To: <alpine.DEB.2.00.1212172240101.29833@utopia.booyaka.com>
References: <alpine.DEB.2.00.1212172240101.29833@utopia.booyaka.com>
Message-ID: <20130112025319.4361.29079@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Paul Walmsley (2012-12-17 14:41:13)
> Convert all DEFINE_OMAP_MUX_GATE() combinations that list MODULEMODE
> registers in their gate arguments to DEFINE_OMAP_MUX(), dropping the
> MODULEMODE data.  This is possible because the MODULEMODE bits control
> IP blocks, not clocks; and the hwmod code takes care of IP block
> control.  Rename these clocks to reflect the original multiplexer name
> as specified in the comments.  And convert the hwmod data to use the
> multiplexer clock name.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
> 
> Seems to boot with omap2plus_defconfig, anyway.
> 

It looks good to me, and I am happy to see fewer clocks in favor of
using the hwmods.  However I did not test it.

Regards,
Mike
