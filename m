From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Mar 2018 08:27:20 +0100
Subject: [PATCH v2] pinctrl: sunxi: always look for apb block
In-Reply-To: <20180303122554.20984-1-andre.przywara@arm.com>
References: <20180303122554.20984-1-andre.przywara@arm.com>
Message-ID: <20180305072720.bzqb2vkizbcxh7me@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2018 at 12:25:54PM +0000, Andre Przywara wrote:
> The Allwinner pinctrl device tree binding suggests that a clock named
> "apb" would drive the pin controller IP. However (for legacy reasons) we
> rely on this clock actually being the first clock defined.
> Since named clocks can be in any order, let's explicitly check for a
> clock called "apb" if there is more than one clock referenced.
> 
> Kudo to Maxime for suggesting this much more elegant approach.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/8fe50507/attachment.sig>
