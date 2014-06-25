From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 25 Jun 2014 09:06:39 +0200
Subject: [PATCH v2 2/2] ARM: i.MX25 clk: Use of_clk_init() for DT case
In-Reply-To: <20140625062423.GH15686@pengutronix.de>
References: <1403529927-13868-1-git-send-email-denis@eukrea.com>
 <1403529927-13868-2-git-send-email-denis@eukrea.com>
 <20140625062423.GH15686@pengutronix.de>
Message-ID: <20140625090639.7eabbf70@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer wrote:
> On Mon, Jun 23, 2014 at 03:25:27PM +0200, Denis Carikli wrote:
[...]
> > @@ -93,134 +91,136 @@ static struct clk *clk[clk_max];
> >  
> >  static int __init __mx25_clocks_init(unsigned long osc_rate)
> >  {
> > +	BUG_ON(!ccm);
> > +
> >  	clk[dummy] = imx_clk_fixed("dummy", 0);
> >  	clk[osc] = imx_clk_fixed("osc", osc_rate);
> > -	clk[mpll] = imx_clk_pllv1("mpll", "osc", ccm(CCM_MPCTL));
> > -	clk[upll] = imx_clk_pllv1("upll", "osc", ccm(CCM_UPCTL));
> > +	clk[mpll] = imx_clk_pllv1("mpll", "osc", CCM_MPCTL);
> > +	clk[upll] = imx_clk_pllv1("upll", "osc", CCM_UPCTL);
> 
> This huge diffstat could be avoided by doing:
> 
> #define ccm(x)	((ccm_base) + (x))
> 
> And passing ccm_base as argument to __mx25_clocks_init.
> 
<nit>the parens around ccm_base are useless</nit>


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
