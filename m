From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Sep 2016 15:09:17 -0300
Subject: [PATCH] ARM: imx35: add iim module to imx35.dtsi
In-Reply-To: <20160908175546.lvc5qehbekx7s2ty@pengutronix.de>
References: <1473326895-19189-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5DmaLsxAsjORCauxBkqAmOMQxu4HTASo+jxBsoo+iL8Ow@mail.gmail.com>
 <20160908175546.lvc5qehbekx7s2ty@pengutronix.de>
Message-ID: <CAOMZO5BLJvL3ad5An2n=h0K+15qOZfWDVLbUz+fe_4Mz7NLMXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 2:55 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

>> Where is "fsl,imx35-iim" defined?
>
> right next to the other fsl,imx*-iim :-)

Ok,  "fsl,imx35-iim" is not being used arch/arm/mach-imx/cpu-imx35.c currently.

I suppose you want to replace
 "rev = imx_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));"

by retrieving the base address via dt, like we do in
imx5_read_srev_reg() at arch/arm/mach-imx/cpu-imx5.c.


> By the way, compared to the other imx*.dtsi I didn't declare
> compatibility to fsl,imx27-iim. I checked the i.MX25 reference manual
> and the i.MX35 looked different. Didn't check for imx5x and the i.MX27
> RM doesn't describe the registers. What do you think?

I think this is fine as is, so:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
