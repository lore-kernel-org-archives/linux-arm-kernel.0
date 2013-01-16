From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 Jan 2013 11:44:44 +0100
Subject: [PATCH  0/5] W1: Support onewire master on i.MX53
In-Reply-To: <20130116094821.9660.18278.stgit@localhost>
References: <20130116094821.9660.18278.stgit@localhost>
Message-ID: <20130116104444.GS1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Wed, Jan 16, 2013 at 10:48:21AM +0100, Martin Fuzzey wrote:
> W1: Support onewire master on i.MX53
> 	* Add device tree and pinctrl support to the MXC master driver
> 	* Add i.MX53 clocks
> 	* Add i.MX53 device tree entries
> 
> The final patch converts the driver to use devm_

Looks mostly good. I think the patch converting to devm_ should come
before the one adding pinctrl for the driver, just because the driver
should first be switched to devm_ and afterwards the devm_ usage should
be extended.

Other than that I just noticed that the clk_prepare_enable/clk_disable_unprepare
is unbalanced in the error case of the driver (clk_disable_unprepare
missing after the failed_add label). Might be worth fixing this in this series.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
