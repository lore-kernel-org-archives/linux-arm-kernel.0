Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798BDC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:55:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473262084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XA4CLhPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473262084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1XCXnXBFAyt1v85t3imvLRdhCBMeYeMmdAJj8ZaRXUQ=; b=XA4CLhPahxsLal
	VlJPaIK+Pg0GVpHN9PKeB60bTYLhkWpm7Yq1JK706bHyoU3A1UXI3vUcY8ZTP+CA/GZZbBb8oXVjy
	ocxGB/3xtIr6tLx3Re+VxAWvHbrh3KamYZBFUG94O8wMJshlMDLvmRHLwh73Phk0e9mJT3833TBjS
	5CktlZbAsKLaec5JdZZKTCH6x+X7SO0hfwci6H5rVgHLEu6nFHuNcRLCcev+T/hjP6SaC1dOQbAPO
	R7+LdNUvqcEdF4x0mMMgUpwz68KArEvIWv+JXOfBt7iyO4a4q2cJSGd/toDEoWs9nSoLzFbsFC4Hj
	6m6m8MGu6pjHJkqkMFRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkgmn-0008P9-Kp; Sat, 19 Jan 2019 02:55:05 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkgmi-0008J6-Fy; Sat, 19 Jan 2019 02:55:02 +0000
X-UUID: d07312970efa4b6d9af16dd93d6c50b5-20190118
X-UUID: d07312970efa4b6d9af16dd93d6c50b5-20190118
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1113742216; Fri, 18 Jan 2019 18:54:52 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 18:54:50 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 19 Jan 2019 10:54:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 19 Jan 2019 10:54:48 +0800
Message-ID: <1547866487.14213.10.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From: Ryder Lee <ryder.lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Sat, 19 Jan 2019 10:54:47 +0800
In-Reply-To: <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_185500_539240_13992AF4 
X-CRM114-Status: GOOD (  22.62  )
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
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-01-18 at 09:43 +0100, Matthias Brugger wrote:
> 
> On 18/01/2019 04:24, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" to avoid having an endless
> > list of compatibles with no differences for the same driver.
> > 
> > Thus, the driver should have backwards compatibility to older DTs.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > Changes since v1: add some checks for backwards compatibility.
> > ---
> >  drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index eb6674c..81b7e5e 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -55,7 +55,7 @@ enum {
> >  };
> >  
> >  struct mtk_pwm_platform_data {
> > -	unsigned int num_pwms;
> > +	unsigned int num_pwms;	/* it should not be used in the future SoCs */
> >  	bool pwm45_fixup;
> >  	bool has_clks;
> >  };
> > @@ -226,27 +226,36 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >  
> >  static int mtk_pwm_probe(struct platform_device *pdev)
> >  {
> > -	const struct mtk_pwm_platform_data *data;
> > +	struct device_node *np = pdev->dev.of_node;
> >  	struct mtk_pwm_chip *pc;
> >  	struct resource *res;
> > -	unsigned int i;
> > +	unsigned int i, num_pwms;
> >  	int ret;
> >  
> >  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> >  	if (!pc)
> >  		return -ENOMEM;
> >  
> > -	data = of_device_get_match_data(&pdev->dev);
> > -	if (data == NULL)
> > -		return -EINVAL;
> > -	pc->soc = data;
> > +	pc->soc = of_device_get_match_data(&pdev->dev);
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	pc->regs = devm_ioremap_resource(&pdev->dev, res);
> >  	if (IS_ERR(pc->regs))
> >  		return PTR_ERR(pc->regs);
> >  
> > -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> > +	/* Check if we have set 'num-pwms' in DTs. */
> > +	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > +	if (ret < 0) {
> > +		/* If no, fallback to use SoC data for backwards compatibility. */
> > +		if (pc->soc->num_pwms) {
> > +			num_pwms = pc->soc->num_pwms;
> 
> Maybe that's bike shedding, but I think it would be better to carve out the
> num_pwms from the mtk_pwm_platform_data and check against the compatible here.

I'm not sure how to properly curve it out? I think we still need this
variable to save the specific value for some legacy SoCs (with older
DTs).

> With a expressive comment it will help other driver developers to not start
> adding num_pwms in the platform data in their first attempt.

Definitely.

Ryder
> 
> > +		} else {
> > +			dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
> >  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> >  		if (IS_ERR(pc->clks[i])) {
> >  			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> > @@ -260,7 +269,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
> >  	pc->chip.dev = &pdev->dev;
> >  	pc->chip.ops = &mtk_pwm_ops;
> >  	pc->chip.base = -1;
> > -	pc->chip.npwm = data->num_pwms;
> > +	pc->chip.npwm = num_pwms;
> >  
> >  	ret = pwmchip_add(&pc->chip);
> >  	if (ret < 0) {
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
