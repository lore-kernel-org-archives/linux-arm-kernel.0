From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 15:54:06 +0800
Subject: [PATCH 02/11] ARM: imx: use dynamic mapping for CCM
In-Reply-To: <CAH=tA9G1JQ-smg_V+dUkZLtkERiswh-EK1y013tEua6iNKCbRQ@mail.gmail.com>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
 <1430058672-9267-3-git-send-email-shawn.guo@linaro.org>
 <CAH=tA9G1JQ-smg_V+dUkZLtkERiswh-EK1y013tEua6iNKCbRQ@mail.gmail.com>
Message-ID: <20150427075405.GB9231@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 26, 2015 at 10:45:18PM +0300, Nicolae Rosia wrote:
> > diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> > index 4ef1e8bdac5b..14f33ec049bc 100644
> > --- a/arch/arm/mach-imx/clk-imx35.c
> > +++ b/arch/arm/mach-imx/clk-imx35.c
> > @@ -71,11 +71,14 @@ static struct clk *clk[clk_max];
> >
> >  int __init mx35_clocks_init(void)
> >  {
> > -       void __iomem *base = MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR);
> > +       void __iomem *base;
> >         u32 pdr0, consumer_sel, hsp_sel;
> >         struct arm_ahb_div *aad;
> >         unsigned char *hsp_div;
> >
> > +       base = ioremap(MX35_CCM_BASE_ADDR, SZ_4K);
> > +       BUG_ON(base);
> BUG_ON(!base) ?

Oops.  Fixed.  Thanks for spotting it, Nicolae.

Shawn
