From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 13 Feb 2015 16:35:36 +0200
Subject: [PATCH RFC v9 01/20] clk: divider: Correct parent clk round rate
 if no bestdiv is normally found
In-Reply-To: <20150212134131.GX12209@pengutronix.de>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-2-git-send-email-Ying.Liu@freescale.com>
 <20150212093356.GR12209@pengutronix.de> <20150212103944.GA1290@victor>
 <20150212122405.GW12209@pengutronix.de>
 <20150212125646.GT8656@n2100.arm.linux.org.uk>
 <20150212134131.GX12209@pengutronix.de>
Message-ID: <54DE0BB8.7070004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/15 15:41, Sascha Hauer wrote:

> Tomis patch is based on the assumption that clk_set_rate(clk_round_rate(rate))
> is equal to clk_round_rate(rate). So when this assumption is wrong then
> it should simply be reverted.

When is it not equal?

I agree that doing clk_set_rate(clk, clk_round_rate(clk, rate)) is
pointless, but shouldn't it still work?

And we can forget about clk_round_rate. Without my patch, this would
behave oddly also:

rate = clk_get_rate(clk);
clk_set_rate(clk, rate);

The end result could be something else than 'rate'.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150213/50a7ea41/attachment.sig>
