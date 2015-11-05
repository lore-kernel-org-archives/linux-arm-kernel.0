From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Nov 2015 16:16:15 +0000
Subject: [PATCH v1 1/5] ASoC: rockchip: i2s: Support to set the divider
 clock API
In-Reply-To: <563AEF97.1080304@gmail.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
 <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
 <20151104143431.GH1717@sirena.org.uk> <563AEF97.1080304@gmail.com>
Message-ID: <20151105161615.GS18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 01:56:39PM +0800, Caesar Wang wrote:
> ? 2015?11?04? 22:34, Mark Brown ??:

> >Same thing as your other very similar patch: why does this feature
> >require set_clkdiv()?

> Okay, you said "
> Why is this a requirement?  The clock to use as a source should normally
> be specified via set_sysclk() and any internal dividers calculated
> automatically by the driver.
> "

> I think we should divider settings for these different sample rates.

Sure, the question is how these things get set.

>  If the codec is master mode, we are *not* need this operate.
>  If the codec is slave mode, we are need to divider the MCLK to setting the different sample rates.
> (for example, the sample rates (8k, 48k) the clock is MCLK, the clock should be divider cpu ip )

> "dividers calculated automatically by the driver", that should be occured by codec(max98090
> ) driver, but the divider clocks (LRCK, SCLK) should need to set for cpu internal side.

So the CPU knows what rates it needs to set and what clocks it's getting
in, why can't it set the dividers autonomously.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151105/9aea7e8c/attachment-0001.sig>
