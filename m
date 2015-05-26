From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 26 May 2015 17:11:15 +0800
Subject: [PATCH 5/5] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <20150526080516.GG6325@pengutronix.de>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-6-git-send-email-jamesjj.liao@mediatek.com>
 <20150526080516.GG6325@pengutronix.de>
Message-ID: <1432631475.15597.29.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, 2015-05-26 at 10:05 +0200, Sascha Hauer wrote:
> On Thu, May 21, 2015 at 03:12:56PM +0800, James Liao wrote:
> > +static void __init mtk_clk_register_apmixedsys_special(struct device_node *node,
> > +			struct clk_onecell_data *clk_data)
> > +{
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +
> > +	base = of_iomap(node, 0);
> > +	if (!base) {
> > +		pr_err("%s(): ioremap failed\n", __func__);
> > +		return;
> > +	}
> > +
> > +	clk = mtk_clk_register_ref2usb_tx("ref2usb_tx", base + 0x8);
> 
> The function seems to be for one special clock only. Why do you pass the
> name to it? They will never be called with another name, right?

This function decides clock name and associates clock ID for special
clocks. In fact there may be another "special clocks" need to add into
apmixedsys. I think it's a better way to group clock names and clock IDs
in the same function for maintenance.


Best regards,

James 
