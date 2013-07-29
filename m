From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 29 Jul 2013 19:42:07 +0400
Subject: [PATCH] ARM: i.MX6Q clocks: Fix CKIH clock name
In-Reply-To: <51F622D1.5030009@de.bosch.com>
References: <1374908212-32008-1-git-send-email-shc_work@mail.ru>
 <51F622D1.5030009@de.bosch.com>
Message-ID: <20130729194207.bfb62131c3cfd29e5d5944ea@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jul 2013 10:07:45 +0200
Dirk Behme <dirk.behme@de.bosch.com> wrote:

> On 27.07.2013 08:56, Alexander Shiyan wrote:
> > i.MX6Q have only one High-frequency reference clock (CKIH).
> > Patch removes index from CKIH and makes name according datasheet.
> >
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >   arch/arm/mach-imx/clk-imx6q.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index 9181a24..8f2a8b5 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -292,7 +292,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
> >
> >   	clk[dummy] = imx_clk_fixed("dummy", 0);
> >   	clk[ckil] = imx_obtain_fixed_clock("ckil", 0);
> > -	clk[ckih] = imx_obtain_fixed_clock("ckih1", 0);
> > +	clk[ckih] = imx_obtain_fixed_clock("ckih", 0);
> >   	clk[osc] = imx_obtain_fixed_clock("osc", 0);
> >
> >   	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
> 
> Just for my understanding: This is a cosmetic change, only? And doesn't 
> change any functionality? Correct?

Yes, but in any case this is an incomplete patch, because I forgot to change
the relevant DTS.

-- 
Alexander Shiyan <shc_work@mail.ru>
