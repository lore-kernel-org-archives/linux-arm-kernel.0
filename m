Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82053C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:32:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E40218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k9Kn2MT2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhfaw26h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E40218D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YKyKHHfPjd++YDFbevlwlXV5MQ4aPnIeCxFoZgfOTUk=; b=k9Kn2MT28aY+Cx
	pT/zljq9WWRxwWfkZSeiCf88XW2P6iMd99zNivUwpiUy0gbWStHpxLG6+YUekPC77bNZWOf7KJ+px
	F0pfj3oZp7UuZ722E7Fx1XNrAqTUPiYWgWS7iLAqlimXDg5QOBBdAGbNNaJQ2pNUPiWGPu/SO+Fp9
	U79NcN8ySHLuISXUMo3K3mUPC8Ogl+ld4kgsRHOYCDr5d8zXTsxBa73NvoJzJ5M1ksnKyi1m0UtFW
	ug4uh0UipGhMFbuCNRQpDa66Cs1FIZGuMWW8egHnjAcd6TNQrLoalhcFCaY7iNkMgrzX1uUDW0xVU
	0q8vcOrfTEijZNH6g7/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTKZ-0006Gt-Qv; Fri, 04 Jan 2019 17:32:23 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTKX-0006GQ-6l
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:32:22 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so1930532wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KMtwuIOEghKVjxfWhtNx5q1cXe98/sXY0O1Q4BdCfjM=;
 b=jhfaw26hniHl7QF+M9ttRhq/dj0Pec8jgLLVPJOCVQ+dJTTTQpVOce6SI7OEBhVHgv
 gOX4g+6no19mGqKSp+gNUiZBZBzsMUFgfwMahmQ+69BFa1dn8JRhPoBo6Hkcd7WblPog
 Cp4XSD6+2Epo1skU26s2rEZEJoKsTD9/dult8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KMtwuIOEghKVjxfWhtNx5q1cXe98/sXY0O1Q4BdCfjM=;
 b=qF1arm3PfzENWzzdsEHIGSeR4+YWgI7VR3aONNNqbOUf9VeUKpchHuO142RhG+Oign
 zBiG6zTMNYK4zOTK4rC8bAuJz+1QkKC63Hut0eL27RcoD8H34UxmNFhtAPMXXwy1ad+r
 CocKyOK/biMO/6O9Etfa/KxzsMBUzAcwp3xoT7jSNc85E2xWDc7d6FcOwVt+EzWCfvzH
 44YG4VcsHosubJz+LiLkapzba3XUkKQpHHFnxXy1F3h5AeYJ/0uMKAHciNYki6zLNPbX
 +J/4DH3QbzdF14WYsz7lgH+5/izEytIvD72tWUMPmQVk3/f5RbWexya/VPt8L5CAJxeH
 gX5g==
X-Gm-Message-State: AJcUuke+1Ho6n4+lEb9ZgICscd0i2/aWXLBpdkIwYbE689+CEo3tgb70
 EQ9NHC2H0+3IXwRPVxl7sDjmp7w2bNsIXXWnbfk07w==
X-Google-Smtp-Source: ALg8bN5VdMxVkLZlC+G1VPl+I1Q0qtTfqzCtc/3GQm4avYLCybRF2ye6N1W/2bZAygqJ9xAMac206vjyifn0qA0EUAU=
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr382766wme.64.1546623138927; 
 Fri, 04 Jan 2019 09:32:18 -0800 (PST)
MIME-Version: 1.0
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
 <20190104172405.GR13372@vkoul-mobl.Dlink>
In-Reply-To: <20190104172405.GR13372@vkoul-mobl.Dlink>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 4 Jan 2019 09:32:06 -0800
Message-ID: <CALAqxLVrK+cBNsyt62Q6gb_SXc_04-LjO02hnhG24bJ6TAXapQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] k3dma: Upgrade k3dma drever to support hisi_asp_dma
 hardware
To: Vinod Koul <vkoul@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_093221_266757_1A3BF9B9 
X-CRM114-Status: GOOD (  18.85  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Youlin Wang <wwx575822@notesmail.huawei.com>,
 h00249924 <hutenghui@huawei.com>, hanxiaolong3@hisilicon.com,
 Zhuangluan Su <suzhuangluan@hisilicon.com>, Hantanglei <hantanglei@huawei.com>,
 lkml <linux-kernel@vger.kernel.org>, Kongfei <kongfei@hisilicon.com>,
 ninggaoyu <ninggaoyu@hisilicon.com>, Liyuequan <liyuequan@hisilicon.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 "huangli \(I\)" <huangli295@hisilicon.com>,
 wangyoulin <wangyoulin1@hisilicon.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Qianli \(A\)" <cash.qianli@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 9:25 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 28-12-18, 14:36, h00249924 wrote:
> > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> >
> > There is an new "hisi-pcm-asp-dma-1.0" device added in
> > "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> > So we have to add a matching id in the driver file:
> > "{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", }"
> >
> > And also hisi-pcm-asp dma device needs no setting to the clock.
> > So we skip this by "if" sentence on id string matching:
> > "if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0)"
> >
> > After above this driver will support both k3 and hisi_asp dma hardware.
> >
> > Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> > Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/k3dma.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> > index fdec2b6..10eecc2 100644
> > --- a/drivers/dma/k3dma.c
> > +++ b/drivers/dma/k3dma.c
> > @@ -792,6 +792,7 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
> >
> >  static const struct of_device_id k3_pdma_dt_ids[] = {
> >       { .compatible = "hisilicon,k3-dma-1.0", },
> > +     { .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", },
>
> The binding doc patch should precede this..
>
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> > @@ -835,10 +836,12 @@ static int k3_dma_probe(struct platform_device *op)
> >                               "dma-requests", &d->dma_requests);
> >       }
> >
> > -     d->clk = devm_clk_get(&op->dev, NULL);
> > -     if (IS_ERR(d->clk)) {
> > -             dev_err(&op->dev, "no dma clk\n");
> > -             return PTR_ERR(d->clk);
> > +     if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0) {
> > +             d->clk = devm_clk_get(&op->dev, NULL);
>
> who provides clk in this case? how does this scale if you have another
> compatible in future for newer version of controller?

Yea, I've pushed a few times in internal review to use match_data() here.

Tanglei Han: If its ok, I've spent some time integrating these changes
with some other pending k3dma changes. So I'll rework and integrate
some of the review feedback on this and resend it so we can get this
moving a little faster.

I'll leave the i2s feedback to you, so please continue reworking and
resubmitting those, but I'll handle upstreaming the k3dma changes
(keeping you on cc of course).

thanks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
