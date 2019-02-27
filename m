Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:39:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8480218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iuR2mWIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8480218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9jq+R1Z5/uSdD2nOWX3Wt6jHHSi1kMQhFHbKMCQzaqQ=; b=iuR2mWIjlvpZaJ
	MMtFPPlncJibRcPOxofUU7fttcttJLyZBdIDXzHZhl9x+Ea3+LDRJzDWW8LR4x6UX4heD5JWx7Q//
	U/jZzP/g47X3aTfTPoLLsaZj1YzfQNl5hHjkXkOm1p/1YeWkSGvO8BCI0tl5Bj/efnK0P4rDsEC1+
	UuAGo4egLp5uUgDyBaWnfpBGTlFLRF16QWLcBzh9O+sZ6JZherG++ki+RSrW2mtYrlMBJY0BrIF19
	M9gPHAxs2BTW9SwXQzvw423W+LV18fHglbL2eykUaYeP3r9vagSinQ8CRrLWePFt4+lWwZxg/XaGa
	SyBvv89uE+Ms6b9JcGQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyr0U-00037O-Om; Wed, 27 Feb 2019 04:39:46 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyr0P-000370-Lo; Wed, 27 Feb 2019 04:39:44 +0000
X-UUID: 1dd9d77990ee42c297ee4a4df6634aa3-20190226
X-UUID: 1dd9d77990ee42c297ee4a4df6634aa3-20190226
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1720278583; Tue, 26 Feb 2019 20:39:17 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 20:39:16 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 12:39:14 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 12:39:14 +0800
Message-ID: <1551242354.1047.37.camel@mtksdaap41>
Subject: Re: [PATCH v4 01/12] clk: mediatek: Disable tuner_en before change
 PLL rate
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Wed, 27 Feb 2019 12:39:14 +0800
In-Reply-To: <1551239460.1047.30.camel@mtksdaap41>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-3-weiyi.lu@mediatek.com>
 <41aed6f5-8794-ddf5-d5c2-17ee82e33db3@gmail.com>
 <1551239460.1047.30.camel@mtksdaap41>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_203941_721388_8D11EB46 
X-CRM114-Status: GOOD (  27.95  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, James Liao <jamesjj.liao@mediatek.com>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, Owen Chen <owen.chen@mediatek.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-02-27 at 11:51 +0800, Weiyi Lu wrote:
> On Tue, 2019-02-26 at 16:59 +0100, Matthias Brugger wrote:
> > 
> > On 01/02/2019 09:30, Weiyi Lu wrote:
> > > From: Owen Chen <owen.chen@mediatek.com>
> > > 
> > > PLLs with tuner_en bit, such as APLL1, need to disable
> > > tuner_en before apply new frequency settings, or the new frequency
> > > settings (pcw) will not be applied.
> > > The tuner_en bit will be disabled during changing PLL rate
> > > and be restored after new settings applied.
> > > Another minor change is to correct the macro name of pcw change bit
> > > to CON1_PCW_CHG because PCW_CHG(BIT31) is on CON1.
> > > 
> > > Fixes: e2f744a82d725 (clk: mediatek: Add MT2712 clock support)
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > > ---
> > >  drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++--
> > >  1 file changed, 31 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > > index f54e4015b0b1..f0ff5f535c7e 100644
> > > --- a/drivers/clk/mediatek/clk-pll.c
> > > +++ b/drivers/clk/mediatek/clk-pll.c
> > > @@ -27,7 +27,7 @@
> > >  #define CON0_BASE_EN		BIT(0)
> > >  #define CON0_PWR_ON		BIT(0)
> > >  #define CON0_ISO_EN		BIT(1)
> > > -#define CON0_PCW_CHG		BIT(31)
> > > +#define CON1_PCW_CHG		BIT(31)
> > >  
> > >  #define AUDPLL_TUNER_EN		BIT(31)
> > >  
> > > @@ -93,9 +93,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> > >  {
> > >  	u32 con1, val;
> > >  	int pll_en;
> > > +	u32 tuner_en = 0;
> > > +	u32 tuner_en_mask;
> > > +	void __iomem *tuner_en_addr = NULL;
> > >  
> > >  	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> > >  
> > > +	/* disable tuner */
> > > +	if (pll->tuner_en_addr) {
> > > +		tuner_en_addr = pll->tuner_en_addr;
> > > +		tuner_en_mask = BIT(pll->data->tuner_en_bit);
> > > +	} else if (pll->tuner_addr) {
> > > +		tuner_en_addr = pll->tuner_addr;
> > > +		tuner_en_mask = AUDPLL_TUNER_EN;
> > > +	}
> > > +
> > > +	if (tuner_en_addr) {
> > > +		val = readl(tuner_en_addr);
> > > +		tuner_en = val & tuner_en_mask;
> > > +
> > > +		if (tuner_en) {
> > > +			val &= ~tuner_en_mask;
> > > +			writel(val, tuner_en_addr);
> > > +		}
> > > +	}
> > > +
> > 
> > Why don't we use a flag here, it would make the code easier to understand.
> > I think it would also help if you put this code in a separate function.
> > 
> > Regards,
> > Matthias
> > 
> 
> Hi Matthias,
> 
> I guess you suggest to add a flag (e.g. CLK_TUNER_SUPPORT) and declare
> the PLL clock with this flag. And inside this mtk_pll_set_rate_regs()
> function, we could modify it as below. Am I right?
> 
> if (pll->data->flags & CLK_TUNER_SUPPORT)
>     disable_tuner();
> [...]
> if (pll->data->flags & CLK_TUNER_SUPPORT)
>     enable_tuner();
> 
> 
> But I thought this flag might be a customized flags and can only be put
> in clk-mtk.h not clk-provider.h so far. And it might cause 
> potential problem of clock flag re-definition. May I have more
> suggestion?
> 

Please ignore the potential problem I mentioned, I just checked it
carefully and that redefinition problem won't happen in current flow.
Sorry for having you confused.
But I still need to confirm with you if the method in previous mail is
correct? Thanks.

> > 
> > >  	/* set postdiv */
> > >  	val = readl(pll->pd_addr);
> > >  	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
> > > @@ -116,12 +138,19 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> > >  	con1 = readl(pll->base_addr + REG_CON1);
> > >  
> > >  	if (pll_en)
> > > -		con1 |= CON0_PCW_CHG;
> > > +		con1 |= CON1_PCW_CHG;
> > >  
> > >  	writel(con1, pll->base_addr + REG_CON1);
> > >  	if (pll->tuner_addr)
> > >  		writel(con1 + 1, pll->tuner_addr);
> > >  
> > > +	/* restore tuner_en */
> > > +	if (tuner_en_addr && tuner_en) {
> > > +		val = readl(tuner_en_addr);
> > > +		val |= tuner_en_mask;
> > > +		writel(val, tuner_en_addr);
> > > +	}
> > > +
> > >  	if (pll_en)
> > >  		udelay(20);
> > >  }
> > > 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
