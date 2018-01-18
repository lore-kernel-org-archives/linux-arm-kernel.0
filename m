From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 Jan 2018 11:53:23 +0100
Subject: [PATCH v3 01/12] clk: sunxi-ng: Mask nkmp factors when setting
 register
In-Reply-To: <20180117201421.25954-2-jernej.skrabec@siol.net>
References: <20180117201421.25954-1-jernej.skrabec@siol.net>
 <20180117201421.25954-2-jernej.skrabec@siol.net>
Message-ID: <20180118105323.fk65vo42eyc6dbzz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 09:14:10PM +0100, Jernej Skrabec wrote:
> Currently, if one of the factors isn't present, bit 0 gets always set to
> 1. For example, A83T has NMP PLLs modelled as NKMP PLL without K. Since
> K is not specified, it's offset, width and shift is 0. Driver assumes
> that lowest value possible is 1, otherwise we would get division by 0.
> That situation causes that bit 0 is always set, which may change wanted
> clock rate.
> 
> Fix that by masking every factor according to it's specified width.
> Factors with width set to 0 won't have any influence to final register
> value.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/8f3fe6a8/attachment.sig>
