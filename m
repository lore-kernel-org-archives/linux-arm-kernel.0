From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 21 Nov 2018 00:03:24 -0800
Subject: [PATCH v1 02/11] clk: mediatek: add new member to mtk_pll_data
In-Reply-To: <1542685880.5132.11.camel@mtksdaap41>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
 <20181106064206.17535-4-weiyi.lu@mediatek.com>
 <CANMq1KBjtyQFyJ-mZBndPDSfSDnD0K8izy39jp9zKE4xfiCiog@mail.gmail.com>
 <1542685880.5132.11.camel@mtksdaap41>
Message-ID: <154278740462.88331.17720342357503268022@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Weiyi Lu (2018-11-19 19:51:20)
> On Tue, 2018-11-13 at 08:18 -0800, Nicolas Boichat wrote:
> > On Mon, Nov 5, 2018 at 10:43 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > > @@ -138,9 +140,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> > >  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> > >                 u32 freq, u32 fin)
> > >  {
> > > -       unsigned long fmin = 1000 * MHZ;
> > > +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : 1000 * MHZ;
> > 
> > I'd put parentheses around (1000 * MHZ), to avoid the need to think
> > about precedence...
> > 
> 
> OK, thanks for the suggestion. will add in next version

Better style would be to not use a ternary statement for anything like
this and have an if condition instead.
