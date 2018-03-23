From: abel.vesa@nxp.com (Abel Vesa)
Date: Fri, 23 Mar 2018 09:49:38 +0000
Subject: Return checks for clock calls
Message-ID: <20180323094937.5wx5exah6tfyl43u@fsr-ub1664-175>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn, Fabio,

I'm trying to get the imx clks changes upstreamed. To that end, I reached this
old commit that adds some wrappers over the generic clk API. Here is the commit
message:

	ARM: imx6: add return check for clock calls

	There are a bunch of clk_enable_prepare, clk_set_parent and clk_set_rate
	calls in imx6 clock driver's initialization.  They are called without
	retunr check.  If there is something going wrong with the calls, they
	will just fail silently.

	The patch creates a set of helper functions imx_clk_enable_prepare,
	imx_clk_set_parent and imx_clk_set_rate, and use them instead from clock
	initialization to check the return and print error message to tell
	failures if any.

	Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

And it adds the imx_clk_set_parent, imx_clk_prepare_enable and
imx_clk_set_rate which basically just print an error message if the generic
functions have failed.

The only plus of these wrappers is that we at least see that the generic
functions have failed, but the behaviour is not changed in any way.

Question is, do we want this upstreamed considering that we need to replace the
calls throughout all the older imx socs ?

Abel
