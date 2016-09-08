From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 8 Sep 2016 20:18:18 +0200
Subject: [PATCH] ARM: imx35: add iim module to imx35.dtsi
In-Reply-To: <CAOMZO5BLJvL3ad5An2n=h0K+15qOZfWDVLbUz+fe_4Mz7NLMXw@mail.gmail.com>
References: <1473326895-19189-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5DmaLsxAsjORCauxBkqAmOMQxu4HTASo+jxBsoo+iL8Ow@mail.gmail.com>
 <20160908175546.lvc5qehbekx7s2ty@pengutronix.de>
 <CAOMZO5BLJvL3ad5An2n=h0K+15qOZfWDVLbUz+fe_4Mz7NLMXw@mail.gmail.com>
Message-ID: <20160908181818.lxx6gi2surk6sl5v@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Thu, Sep 08, 2016 at 03:09:17PM -0300, Fabio Estevam wrote:
> On Thu, Sep 8, 2016 at 2:55 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> >> Where is "fsl,imx35-iim" defined?
> >
> > right next to the other fsl,imx*-iim :-)
> 
> Ok,  "fsl,imx35-iim" is not being used arch/arm/mach-imx/cpu-imx35.c currently.
> 
> I suppose you want to replace
>  "rev = imx_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));"
> 
> by retrieving the base address via dt, like we do in
> imx5_read_srev_reg() at arch/arm/mach-imx/cpu-imx5.c.

Yes, that's the plan, imx5_read_srev_reg could even be used for this, so
I intend to rename it and move it to a place where it is compiled for
i.MX[23]5.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
