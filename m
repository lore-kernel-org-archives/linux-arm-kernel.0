Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65690C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D2720869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzo3W4lF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQC2KzBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D2720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=36jCXRiF4EfBubBhkpjyfIYX0mLdBMt87ggmAeVcBC0=; b=tzo3W4lFpVIQV2
	BBdOqlvgNdEvbKc4mKd3w2C+GJgroPtRVx0sxx5AxkvIxgQy0tHqi6fb4L1XK5eCH7W+GdfLWur2l
	xINes5c+In0gxqpQpM1LOrE7CKggy3fSRStiDJVJAc6ID5toMc8XrasnT8Ky6AwzZN3Wl0Gv+Xo/P
	RurpkzCGbV9stGsbmlCazTGHPTJ1EwhjskXwCteFUodVmm1BBuTSFQM75yTIPlaxQTFnk+5ku5oze
	m6QnhNoUcqI5SIQ3ZssNcr1ZMmU3WppaIOh53XZmhUCy3W+ylB7th1O5IEdyZy+L0WZIoysbn6iLS
	l7d6UHHTmk0gRYD5gsCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goujy-00019d-2n; Wed, 30 Jan 2019 18:37:38 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goujJ-0000bp-Go
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:37:00 +0000
Received: by mail-lj1-x242.google.com with SMTP id u89-v6so497296lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1e0nHX9Wr1oeqbeRBnTvuV8S/9zyEhNvko7O1JoesYs=;
 b=mQC2KzBypqrIbtKDzJzKS9MEhzEcGJxb4W/HQQYlgVp3aOAmgTL0xGekyrw+Tz3V7p
 JrDLEBOzpnX+G8RWr8e0xlBBCPzwHg56c/wYJ5/t2JQS1JyECzyWgZ/s/HRc1XAMvgAs
 EPahZKWuoBX3Me59vXJy6MeJnSlAuEu/IrGto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1e0nHX9Wr1oeqbeRBnTvuV8S/9zyEhNvko7O1JoesYs=;
 b=T5G1l6GQW+1wxeBC0ZTMCwhrvk6OmAb/CBxMmUTOs/MTJ/PbYcT+hTg422XVmfKZ3O
 UksrwelAZbc/u78rzNDK8l0jx/CUpXx4T91AqKF7jMmdCWiZMoqEaYXU4lNT/aYWfkEV
 pTsDx3FmPwTDl4mj8LJQ/eaUNcVe3LbyWtMsOYJr63BfhJZ5tW1Wj/qxtbNkbJYdTjfr
 HDd7mDrqKEBy+QXe1iqSASU4swIDZNfGfkqxtR0EvHr2VVlDF9jVWQdx0YY/LkjjONQ9
 IXTf2If6ScOKQReX+ECRmlA5BSD5Eh6cCMW14Tc2ZnsftFfBC1d3tGWsiqgbQl0czcYX
 uoGg==
X-Gm-Message-State: AHQUAuaBv/Pb2MUDW1wK2cOonqa3fGAWm64NhzPUEIz6qL6IOEAgUL4i
 MRPbSSKp+rEJ+qCDOGZ7e7zRBZcoF0U=
X-Google-Smtp-Source: AHgI3IayIZAyJb5DSxf0RfrTK30yylr1s4AaSwyiE95ymIlaphtBbFjA+gb2/y8Cf5clpOXFY4u+uA==
X-Received: by 2002:a2e:2246:: with SMTP id
 i67-v6mr20209710lji.154.1548873415775; 
 Wed, 30 Jan 2019 10:36:55 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id q10-v6sm422156ljh.72.2019.01.30.10.36.55
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:36:55 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id a16so420607lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:55 -0800 (PST)
X-Received: by 2002:a19:7352:: with SMTP id o79mr25476428lfc.104.1548873009496; 
 Wed, 30 Jan 2019 10:30:09 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-9-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-9-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:29:33 -0800
X-Gmail-Original-Message-ID: <CAE=gft7FOfqJir8n6wGvOcs0pdxtuvmd9jonHwD4Q_1Q8wM5oQ@mail.gmail.com>
Message-ID: <CAE=gft7FOfqJir8n6wGvOcs0pdxtuvmd9jonHwD4Q_1Q8wM5oQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] iommu/mediatek: Add larb-id remapped support
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_103657_575628_F1B77702 
X-CRM114-Status: GOOD (  21.39  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The larb-id may be remapped in the smi-common, this means the
> larb-id reported in the mtk_iommu_isr isn't the real larb-id,
>
> Take mt8183 as a example:
>                        M4U
>                         |
> ---------------------------------------------
> |               SMI common                  |
> -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
>  |     |     |     |     |     |      |     |
> larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> disp  vdec  img   cam   venc  img    cam
> As above, larb0 connects with the id 0 in smi-common.
>           larb1 connects with the id 7 in smi-common.
>           ...
> If the larb-id reported in the isr is 7, actually it's larb1(vdec).
> In order to output the right larb-id in the isr, we add a larb-id
> remapping relationship in this patch.
>
> If there is no this larb-id remapping in some SoCs, use the linear
> mapping array instead.
>
> This also is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 4 ++++
>  drivers/iommu/mtk_iommu.h | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 847082c..eca1536 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -220,6 +220,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>         fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
>         fault_port = F_MMU0_INT_ID_PORT_ID(regval);
>
> +       fault_larb = data->plat_data->larbid_remap[fault_larb];
> +
>         if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>                                write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>                 dev_err_ratelimited(
> @@ -742,12 +744,14 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .m4u_plat     = M4U_MT2712,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>
>  static const struct mtk_iommu_plat_data mt8173_data = {
>         .m4u_plat     = M4U_MT8173,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */

I briefly considered bikeshedding about how to define these arrays in
a way that might save memory for linear-map devices, but then decided
this is fine.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
