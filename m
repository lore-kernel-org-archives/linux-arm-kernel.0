From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Sep 2014 17:40:43 +0200
Subject: [PATCH v2 1/7] clk: sunxi: Specify number of child clocks for
 divs clocks
In-Reply-To: <1411807795-6575-2-git-send-email-wens@csie.org>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
 <1411807795-6575-2-git-send-email-wens@csie.org>
Message-ID: <20140930154043.GN4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 04:49:49PM +0800, Chen-Yu Tsai wrote:
> Currently sunxi_divs_clk_setup assumes the number of child clocks
> to be the same as the number of clock-output-names, and a maximum
> of SUNXI_DIVS_MAX_QTY child clocks.
> 
> On sun6i, PLL6 only has 1 child clock, but the parent would be used
> as well, thereby also having it's own clock-output-names entry. This
> results in an extra bogus clock being registered.

Isn't PLL6 having two childs as well?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/54912c5c/attachment.sig>
