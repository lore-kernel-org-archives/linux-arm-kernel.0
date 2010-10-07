From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Oct 2010 11:10:09 +0200
Subject: [PATCH 1/3] ARM: imx: fix/define clocks and create devices for
	imx dma
In-Reply-To: <625327.65828.qm@web51005.mail.re2.yahoo.com>
References: <1286359219-5869-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<625327.65828.qm@web51005.mail.re2.yahoo.com>
Message-ID: <20101007091009.GC28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Wed, Oct 06, 2010 at 06:04:23PM -0700, Fabio Estevam wrote:
> Hi Uwe,
> 
> --- On Wed, 10/6/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > +#if defined(CONFIG_ARCH_MX35)
> > +??? if (cpu_is_mx35())
> > +??? ??? ret = imx_add_imx_sdma(&imx35_imx_sdma_data);
> > +??? else
> 
> Shouldn't you check the MX35 silicon version like you did for MX31?
> 
> If not checked this would fail for the old MX35 silicon. I understand
> that MX31 has mx31_revision() function, but there is no
> mx35_revision() currently.

You are right. I will add a mx35_revision function.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
