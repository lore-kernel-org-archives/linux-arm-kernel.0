From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 May 2012 09:00:58 +0200
Subject: [PATCH] clk: Constify struct clk_init_data
In-Reply-To: <4FB1AF14.3050507@codeaurora.org>
References: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120514215304.GB3075@gmail.com> <4FB1AF14.3050507@codeaurora.org>
Message-ID: <20120515070058.GK30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 06:19:16PM -0700, Saravana Kannan wrote:
> On 05/14/2012 02:53 PM, Turquette, Mike wrote:
> >On Mon, May 14, 2012 at 7:12 AM, Mark Brown<broonie@opensource.wolfsonmicro.com>  wrote:
> >>Allow drivers to declare their clk_init_data const, the framework really
> >>shouldn't be modifying the data.
> >>
> >>Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> >
> >+interested parties
> >
> >>
> >>diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> >>index c1c23b9..fc43ea6 100644
> >>--- a/include/linux/clk-provider.h
> >>+++ b/include/linux/clk-provider.h
> >>@@ -143,7 +143,7 @@ struct clk_init_data {
> >>  */
> >>  struct clk_hw {
> >>        struct clk *clk;
> >>-       struct clk_init_data *init;
> >>+       const struct clk_init_data *init;
> 
> Oh, wait. This won't work for the case where the clock registration
> is completely dynamic. Say, created from device tree or thru some
> PCI/USB device probe, etc. That's why I didn't add it before.

Why not? In this case clk_init_data is also only used in clk_register.
Given that Mark has posted the patch I assume it actually works.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
