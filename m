From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Jun 2012 18:28:51 +0200
Subject: [PATCH v2] clk: Add support for rate table based dividers
In-Reply-To: <1340794893-20869-1-git-send-email-rnayak@ti.com>
References: <1340794893-20869-1-git-send-email-rnayak@ti.com>
Message-ID: <20120627162851.GT1623@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 04:31:33PM +0530, Rajendra Nayak wrote:
> Some divider clks do not have any obvious relationship
> between the divider and the value programmed in the
> register. For instance, say a value of 1 could signify divide
> by 6 and a value of 2 could signify divide by 4 etc.
> Also there are dividers where not all values possible
> based on the bitfield width are valid. For instance
> a 3 bit wide bitfield can be used to program a value
> from 0 to 7. However its possible that only 0 to 4
> are valid values.
> 
> All these cases need the platform code to pass a simple
> table of divider/value tuple, so the framework knows
> the exact value to be written based on the divider
> calculation and can also do better error checking.
> 
> This patch adds support for such rate table based
> dividers.
> 
> Also since this means adding a new parameter to the
> clk_register_divider(), update all existing users of
> it.

I'm not sure whether we should overload the divider code with another
type of divider. Maybe it would be better to add a new
clk-divider-table.c for this? Just an idea, the result may or may not be
better.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
