From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 16 Sep 2015 12:04:26 +0200
Subject: [PATCH 2/3] regulators: axp20x: Rename supply names for AXP221
 DC1SW and DC5LDO
In-Reply-To: <1442372732-27434-3-git-send-email-wens@csie.org>
References: <1442372732-27434-1-git-send-email-wens@csie.org>
 <1442372732-27434-3-git-send-email-wens@csie.org>
Message-ID: <20150916100426.GX4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 11:05:31AM +0800, Chen-Yu Tsai wrote:
> The DC1SW and DC5LDO regulators in the AXP221 are internally chained
> to DCDC1 and DCDC5, hence the names. The original bindings used the
> parent regulator names for the supply regulator property. This causes
> some confusion when we actually use it in the dts:
> 
> 	axp221 {
> 		/* self supplying? */
> 		dcdc1-supply = <&dcdc1>;
> 		dcdc5-supply = <&dcdc5>;
> 
> 		dcdc1: dcdc1 {
> 			...
> 		};
> 
> 		dcdc5: dcdc5 {
> 			...
> 		};
> 	};
> 
> Change them to the downstream regulator names, or "dc1sw" and "dc5ldo"
> respectively.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150916/6b238eb9/attachment.sig>
