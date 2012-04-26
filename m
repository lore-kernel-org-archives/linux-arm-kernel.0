From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 10:42:01 +0200
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <4F98EB10.2000505@codeaurora.org>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <4F98EB10.2000505@codeaurora.org>
Message-ID: <20120426084201.GF17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 11:28:32PM -0700, Saravana Kannan wrote:
> 
> >diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> >index 6e58f11..8e97491 100644
> >--- a/drivers/clk/clk-mux.c
> >+++ b/drivers/clk/clk-mux.c
> >@@ -95,6 +95,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
> >  {
> 
> I would really like to remove these functions. At least until we add
> device tree support where each clock is listed in device tree.
> 
> At present, these functions seem to be abused more than actually
> being used appropriately.

I think this goes in my direction. Still exactly this abuse how you call
it makes me relatively independent of for example the changes you
introduce with your patch. Had I static initializers I would now have
to start a rebase orgy.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
