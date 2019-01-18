Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9215CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:45:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506E02086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nbi673Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506E02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0L2YMFLW28FP/CGotxVMCgXmYQcCnDj7b7j5jSH1LyA=; b=nbi673XtBFmHb2
	QOoPnLQN52JokLw6R4muDh61dM7ykTxeBYI6kHG/7fgtj/KHZBJY9nYq1IO5mIDcwtftcEIELyWyE
	RWoOvoISqMit+NobpEFfK2/4mxZwksYjkxZLwdd5ZcVCrq7RkViHwGEAb9QGLZr2gMsvqPXvQ6nSA
	xDdHZo1Df8HEfZ7AV18RF1gGb/Bv3NKV6PUDrdEE2yUH1GWhAQODJ1ZWtsF+ZPEtH69L05GS3pph8
	6eBUPG+pamqD26y12OfOe7wHG3b1YMcOvtrScTiWEczhZLg4mPIFleLi974Zcns6ND6Hz5IcSSJKD
	+wGCzuw5iswSh6lFJc8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkJDq-00057M-F8; Fri, 18 Jan 2019 01:45:26 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJDm-00055z-4U; Fri, 18 Jan 2019 01:45:23 +0000
X-UUID: 9b0ae756f3574f9f87adfffe84fefdf3-20190117
X-UUID: 9b0ae756f3574f9f87adfffe84fefdf3-20190117
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 5108527; Thu, 17 Jan 2019 17:45:13 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 17:45:11 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 09:45:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 09:45:02 +0800
Message-ID: <1547775902.22794.1.camel@mtkswgap22>
Subject: Re: [PATCH 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From: Ryder Lee <ryder.lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Fri, 18 Jan 2019 09:45:02 +0800
In-Reply-To: <0546d8b6-ac67-d445-677a-ff888edf9646@gmail.com>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
 <0546d8b6-ac67-d445-677a-ff888edf9646@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_174522_184871_4BCA3516 
X-CRM114-Status: GOOD (  24.06  )
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

On Mon, 2019-01-14 at 12:16 +0100, Matthias Brugger wrote:
> 
> On 14/01/2019 09:21, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" to avoid having an endless
> > list of compatibles with no other differences for the same driver.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index eb6674c..37daa84 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -55,7 +55,6 @@ enum {
> >  };
> >  
> >  struct mtk_pwm_platform_data {
> > -	unsigned int num_pwms;
> >  	bool pwm45_fixup;
> >  	bool has_clks;
> >  };
> > @@ -226,10 +225,11 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >  
> >  static int mtk_pwm_probe(struct platform_device *pdev)
> >  {
> > +	struct device_node *np = pdev->dev.of_node;
> >  	const struct mtk_pwm_platform_data *data;
> >  	struct mtk_pwm_chip *pc;
> >  	struct resource *res;
> > -	unsigned int i;
> > +	unsigned int i, num_pwms;
> >  	int ret;
> >  
> >  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > @@ -246,7 +246,13 @@ static int mtk_pwm_probe(struct platform_device *pdev)
> >  	if (IS_ERR(pc->regs))
> >  		return PTR_ERR(pc->regs);
> >  
> > -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> > +	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
> >  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> >  		if (IS_ERR(pc->clks[i])) {
> >  			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> > @@ -260,7 +266,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
> >  	pc->chip.dev = &pdev->dev;
> >  	pc->chip.ops = &mtk_pwm_ops;
> >  	pc->chip.base = -1;
> > -	pc->chip.npwm = data->num_pwms;
> > +	pc->chip.npwm = num_pwms;
> >  
> >  	ret = pwmchip_add(&pc->chip);
> >  	if (ret < 0) {
> > @@ -279,32 +285,23 @@ static int mtk_pwm_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct mtk_pwm_platform_data mt2712_pwm_data = {
> > -	.num_pwms = 8,
> > -	.pwm45_fixup = false,
> > -	.has_clks = true,
> > -};
> > -
> > -static const struct mtk_pwm_platform_data mt7622_pwm_data = {
> > -	.num_pwms = 6,
> >  	.pwm45_fixup = false,
> >  	.has_clks = true,
> >  };
> 
> From my point of view that's not perfect. We should make sure that a newer
> kernel does not break with an older device tree and vice versa.
> Just imagine I use some board where u-boot passes the device tree to the kernel,
> I update the kernel and PWM is broken.
> 
> So also it is crappy we will need to have the num_pwms variable for the older
> boards.
> Maybe put a switch in the probe function which checks the compatible with a
> comment message saying that this is for legacy device tree, so that no new
> contributer just copys the wrong code.
> 
> What do you think?

Okay, I will do that.

Ryder
> 
> >  
> >  static const struct mtk_pwm_platform_data mt7623_pwm_data = {
> > -	.num_pwms = 5,
> >  	.pwm45_fixup = true,
> >  	.has_clks = true,
> >  };
> >  
> >  static const struct mtk_pwm_platform_data mt7628_pwm_data = {
> > -	.num_pwms = 4,
> >  	.pwm45_fixup = true,
> >  	.has_clks = false,
> >  };
> >  
> >  static const struct of_device_id mtk_pwm_of_match[] = {
> >  	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
> > -	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
> > +	{ .compatible = "mediatek,mt7622-pwm", .data = &mt2712_pwm_data },
> >  	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
> >  	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
> >  	{ },
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
