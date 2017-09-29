From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Sep 2017 10:33:10 +0200
Subject: [PATCH 1/7] regulator: axp20x: Fix poly-phase bit offset for
 AXP803 DCDC5/6
In-Reply-To: <20170929032514.31727-2-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
 <20170929032514.31727-2-wens@csie.org>
Message-ID: <20170929083310.eswbl6l5tac3vbwj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 03:25:08AM +0000, Chen-Yu Tsai wrote:
> The bit offset used to check if DCDC5 and DCDC6 are tied together in
> poly-phase output is wrong. It was checking against a reserved bit,
> which is always false.
> 
> In reality, neither the reference design layout nor actually produced
> boards tie these two buck regulators together. But we should still
> fix it, just in case.
> 
> Fixes: 1dbe0ccb0631 ("regulator: axp20x-regulator: add support for AXP803")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/b46b5306/attachment.sig>
