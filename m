From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Aug 2013 11:10:00 +0200
Subject: [RFC 06/17] ARM: imx: remove custom .init_time hook
In-Reply-To: <52132D6C.2080606@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-7-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130820072642.GJ31036@pengutronix.de>
 <52132D6C.2080606@gmail.com>
Message-ID: <20130820091000.GK31036@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 10:48:44AM +0200, Sebastian Hesselbarth wrote:
> On 08/20/2013 09:26 AM, Sascha Hauer wrote:
> >On i.MX5 the init_time hook calls mx5x_clocks_init_dt which calls
> >mx5x_clocks_init which not only calls of_clk_init() but also registers
> >all clocks in the system. You can't remove it.
> >
> >I am missing some
> >
> >CLK_OF_DECLARE(imx51, "fsl,imx51-ccm", imx51_clocks_init);
> >CLK_OF_DECLARE(imx53, "fsl,imx53-ccm", imx53_clocks_init);
> >
> >Somewhere.
> 
> Sascha,
> 
> you are right, I forgot to add the two lines above as replacement for
> the now removed direct call. If the general approach is accepted, I'll
> add them for sure.
> 
> Do imx51/imx53 still boot with CLK_OF_DECLARE added?

I can test this once the whole series arrived here. So far I only have
6/16 and 10/17. I probably need at least 1/17.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
