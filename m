From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 2 Jul 2015 10:18:09 +0800
Subject: [PATCH v2 1/4] clk: mediatek: mt8173: Fix enabling of critical
 clocks
In-Reply-To: <CAGS+omDqSEn_WnUYz0XmeRpejhthb0J_qa4H9VEfihtA0Axorg@mail.gmail.com>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-2-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omDqSEn_WnUYz0XmeRpejhthb0J_qa4H9VEfihtA0Axorg@mail.gmail.com>
Message-ID: <1435803489.3526.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, 2015-07-01 at 22:21 +0800, Daniel Kurtz wrote:
> To be precise, it is the CLK_TOP clocks that have CLK_APMIXED PLLs as
> their parents, so we cannot enable the CLK_TOP critical clocks until
> the CLK_APMIXED clocks have all been registered.
> 
> Please add something like the above to the commit message.

OK. I'll add them.

> 
> >
> > +static struct clk_onecell_data *mt8173_top_clk_data;
> > +static struct clk_onecell_data *mt8173_pll_clk_data;
> 
> These globals can be:
> __initdata
> 
> > +
> > +static void mtk_clk_enable_critical(void)
> 
> And this function is:
> 
> static void __init

I'll add them in next patch.


Best regards,

James
