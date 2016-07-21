From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jul 2016 10:56:15 +0200
Subject: [PATCH 2/3] mmc: sunxi: Set the 'New Timing' register for 8 bits
 DDR transfers
In-Reply-To: <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
Message-ID: <20160721085615.GG5993@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 20, 2016 at 08:16:28PM +0200, Jean-Francois Moine wrote:
> The 'new timing mode' with 8 bits DDR works correctly when the NewTiming
> register is set.

What does that mode brings to the table?

> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> Note about the 'new timing mode'.
> 
> This patch assumes that, when the new mode is used, the clock driver
> sets the mode select in the MMC clock and multiplies the clock rate
> by 2:
> - MMC side:
>   - with a timing 8 bits DDR at 50MHz, the MMC driver calls
>     clk_set_rate() with a rate 50*2 = 100MHz,
> - clock side:
>   - the clock driver sets the hardware MMC clock to 100*2 = 200MHz,
>   - setting the 'mode select' of the hardware MMC clock divides the
>     rate by 2,
> - MMC side:
>   - setting the MMC clock divider register to 1 divides the rate by 2.
> So, the final rate is 50MHz.

What happens if you actually want to set it to 100MHz?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/39cd3e0c/attachment.sig>
