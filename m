Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB36C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37192087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qTuA6Uaa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhzLAC8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37192087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ov/Z0j99GgwndLJpuKzedksUgRbIxxSNmq7NH3h6kXw=; b=qTuA6UaaWa8kbJ
	3DVWvVJGNqb2U1mdNbloK0r+1bzWVlqMVR+FJv3bkApQu4t0FxWfdDFu2nY2T0xWYoWC9YEq2QI0X
	JnLBAwVzOxnEE9wHMPH6TL1G60riHcr+rowqckyZzB3s6rN3cBKsnSjXx66tjRyM6aoPqpihRA4MS
	N6geyW1C98g2c+H33F4EMcTfadu1ZvRUx7Kj9/klgDuGiizskLiEw8lc387voxZ9RI735FET16RIH
	a0dbfU/1smB5C6qAQQ7rv/lTqO2h32iM9Vzqa+5F/89obTIqEVj+YpobRdux0rRfCp2fxIoJCbB0Z
	6Orqivf385+572xfg+Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govRH-0004cm-1o; Wed, 30 Jan 2019 19:22:23 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govRD-0004bY-Gu
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:22:20 +0000
Received: by mail-lj1-x244.google.com with SMTP id g11-v6so601400ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xexnQxVTr0JWe6DMyf7KO14a0l6N+WxdulLMNHMHrpc=;
 b=mhzLAC8fG3PFzHNIiR53TJOj6/vdE+TDDmJ71ouQsTiIkIoPW71qH7yeYs/xA3iDiX
 Czvz2WgAUaBOub83O0lMCp+3c1NZxCjAMZ+XMgzpYBQx94HVmJvm/Nxhb/Qxn3PjbMD5
 axw1m8o1zkBLq/aEOgbaqRCf0BVtjeiWuq6jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xexnQxVTr0JWe6DMyf7KO14a0l6N+WxdulLMNHMHrpc=;
 b=stjBwtOwkYvFv+7gLjtf/RPZ+L5hoydUdciUEyXfvMzefm4NIGUMNGJwpaqGbyPT4J
 ugXobUDIKgkBZ609Zapm74Xc1r0Uu2AzlAKbmrLWfyw/3d8oTFyLJtFvRTlt7zN8ky5x
 mRzPHaEodCzyWi3/FmjZ45u1Sh5OZmd8unPBb5Xg9YrdiJpcgXNZ8hk3bsvtxfDLTzj5
 eQUtJoN5AWt0MJEjVLVSetoC7VWvgAqB/CHKBgOp7T3WyG2r6X0ceICnhzGV0RJyc9eB
 3s5OOkDgrdXIkU+otUxbRbxpALVhS9S7zbOhBKgNTag1/9PPTEM4IljqN19ONydDoztS
 AYHQ==
X-Gm-Message-State: AJcUukdcg/IIqVPJzhuS3V2ieQiOgNHURaCiVTAiQdDFdn2J2bw1Voy1
 mttKB8/OhmfNLi/e9LOPn3msjxjeYYg=
X-Google-Smtp-Source: ALg8bN4zDp4DbmyZ4xr7RIzBmHNXiwkugLDD1uVOB0n4iVf0sbaGQLWMyxQsW71flFBhyjRRO6I4TQ==
X-Received: by 2002:a2e:9b52:: with SMTP id
 o18-v6mr24935063ljj.108.1548876137676; 
 Wed, 30 Jan 2019 11:22:17 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id a2-v6sm428430lji.13.2019.01.30.11.22.16
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:22:17 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v15-v6so524272ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:22:16 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id
 z4-v6mr26585860ljc.97.1548876135969; 
 Wed, 30 Jan 2019 11:22:15 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-18-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-18-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 11:11:39 -0800
X-Gmail-Original-Message-ID: <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
Message-ID: <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] memory: mtk-smi: Get rid of need_larbid
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_112219_574831_680D3F21 
X-CRM114-Status: GOOD (  21.37  )
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

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> It's no need to parse it again in SMI driver. Only clean some codes.
> This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> and mt8183.
>
> After this patch, the "mediatek,larb-id" only be needed for mt2712
> which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> in which the larbs in the "mediatek,larbs" always are ordered.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 08cf40d..10e6493 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
>  };
>
>  struct mtk_smi_larb_gen {
> -       bool need_larbid;
>         int port_in_larb[MTK_LARB_NR_MAX + 1];
>         void (*config_port)(struct device *);
>         unsigned int larb_direct_to_common_mask;
> @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
>         struct mtk_smi_iommu *smi_iommu = data;
>         unsigned int         i;
>
> -       if (larb->larb_gen->need_larbid) {
> -               larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> -               return 0;
> -       }
> -
> -       /*
> -        * If there is no larbid property, Loop to find the corresponding
> -        * iommu information.
> -        */
> -       for (i = 0; i < smi_iommu->larb_nr; i++) {
> +       for (i = 0; i < MTK_LARB_NR_MAX; i++) {

Looks like this was the only use of mtk_smi_iommu.larb_nr. Should we
remove that now?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
