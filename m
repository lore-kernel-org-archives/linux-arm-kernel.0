Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E69BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:36:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECA121903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qSUf1fbr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYmVann3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECA121903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PFYew9jZG76Cx9gYrd+OvyTegTLI4z7LfhafnV2SMSk=; b=qSUf1fbrXxjrBl
	1NEkvs4wdYS1cow4DY0fNNZ+DZDRfwdAUvoREjjGz2IL3xjRUeZp9zX0re2tjPPtmcvt67rG8U+gv
	xUWd59ueLFTSxitpyx7WDYyvJCW/MKB2j6Zpb9Q65lF1c0SK9ukz8c7c0AeQVLRIxiNz+0iURHP+H
	ULAjVpZW8qcZ9wSYpE8rS1Rz2qrdZl5GZvUYIcdWaT5TxW5/U5nRqGBZNi8AY7g9EQOVxfYfQ03e+
	gEVBzGgn2Ltfey9ivQ8iAkGrVrr89X6u1l1vwskFONQeh1ytWIw9R1y8JGfFQMB17U0ZfjLgmJEDK
	u3hPxDoAetgE8Fguv/0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaBbm-0003f2-RS; Fri, 21 Dec 2018 03:36:18 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaBbi-0003dT-WE
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 03:36:17 +0000
Received: by mail-qt1-x842.google.com with SMTP id l11so4311393qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 19:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1YKu3l2W2tnjwEusBHKXK1YRzv6cTe2O21eT23+mEyU=;
 b=OYmVann3ocxoEst0RrE5++bYdAiYd1ZyviOS/oRcs3l1x+M0+pga7amLk2552x5uXa
 pSvHdvGPYIJpj4XDkyUz9qmyY0tHI7Q11yC66OLNwyPfP17ZGIj/S0zJa4MFKkc1DIXY
 uA0B2vJx4V4oYWqBcKds2EI3AfZss7ktv1Cz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1YKu3l2W2tnjwEusBHKXK1YRzv6cTe2O21eT23+mEyU=;
 b=YM3uZ2rSJUXF21B8kvHKhz4BUCmUDx5DYgVxKFBkxIGp5GCvMtjwhB5vL7Ogc1EqT1
 85VXqzswQo16lQTl0Po1JkI1zjeuajFVf5U/SzPu03tHpwzC4YU7nAlxGmdQf5okCYcc
 y9RwdWmxZVAHIIDE0hc92ZIOIqBDKNhZECspfq41+ycufd8WqXZsu9SrqR3XRPK7An1/
 nANKgyc51iJO9QiCwRS9S2uX22tJawS9f4Nu18FYWO5TcgPEJ7q5s0Xh+yXAyieQqFJE
 g7AHX3oreRfVa6XylwN2oaZWGlqnGJIS2ptM9Ii2iMyb3OfzgJf4bVVeK+O4j6LGt7me
 TSTg==
X-Gm-Message-State: AJcUukdgFxD62oXyr7K9oO7SqZanIVOHolOHRRNhgjtk633R1onXzWJj
 0tYJnHbYbEihUT7oToV15hxw5Xcpy1615Q1qrE2DhA==
X-Google-Smtp-Source: ALg8bN4amSwWukkVzC9WFmuyGIAa98Ef1i3/sWMAuO/47Fu+m8QmPDRsZqxyYGHjQN3rCLzAvfDN15LGoRsxIe/ztQo=
X-Received: by 2002:a0c:db04:: with SMTP id d4mr824527qvk.114.1545363362797;
 Thu, 20 Dec 2018 19:36:02 -0800 (PST)
MIME-Version: 1.0
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 21 Dec 2018 11:35:51 +0800
Message-ID: <CANMq1KDHTPbYHXVsf+_=ER3HYjfFPjv6LTTZMvmM7WChiFDyZQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] iommu/mediatek: Add larb-id remapped support
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_193615_034301_5A30D9A4 
X-CRM114-Status: GOOD (  20.99  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, arnd@arndb.de,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 8, 2018 at 4:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
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
> This also is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 +++
>  drivers/iommu/mtk_iommu.h | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index eda062a..8ab3b69 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -220,6 +220,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>         fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
>         fault_port = F_MMU0_INT_ID_PORT_ID(regval);
>
> +       if (data->plat_data->larbid_remap_enable)
> +               fault_larb = data->plat_data->larbid_remapped[fault_larb];
> +
>         if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>                                write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>                 dev_err_ratelimited(
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b8749ac..3877050 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -47,6 +47,10 @@ struct mtk_iommu_plat_data {
>
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
> +
> +       /* The larb-id may be remapped in the smi-common. */
> +       bool                larbid_remap_enable;
> +       unsigned int        larbid_remapped[MTK_LARB_NR_MAX];

Wouldn't it be a little simpler if you just had
larbid_remap[MTK_LARB_NR_MAX] (no larbid_remap_enable), and just set
it to {0, 1, 2, 3, 4, 5, 6, 7} in platforms that don't need
complicated remapping?

Also, unsigned char/u8 array would be enough.

>  };
>
>  struct mtk_iommu_domain;
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
