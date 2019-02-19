Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFD2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:38:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F36521738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HtDxjw65";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWzMxd2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F36521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=psHU82c8o590VK0m6/wIWrcK0SyT8Z96k4+2yLKAKCU=; b=HtDxjw656/vfqw
	2Lyad4hegdFNBtxJlPFn2ifjDm+NF+XPDvvoYwEREikOR3UVu6ImK44rhe7+cvmawsiVqImXFessu
	907Rjc9sHoOMZiV0f9g/1N6j72L85VQkqHpnbkE90Un3t9tSNTZBL03mxHoKPsDmemmTbgd8NLPpa
	Ui29rO5JLWn+Kt6lnJ08Sw/9tz+hMfsd3Ja1d8pmLMbtrhwX0jhq1stz1H+YU1vXvUJIyPzmt9uXt
	cH4QLaZayi7Llu8Y2nEh3xAsRIzR8Yv5A+WxawVIM7dD30yrq4Kas73PbUCrcbwn9B2frRfmjeDCs
	zRqYVTXccl+vcsPPYc7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwEy0-0007JW-1Q; Tue, 19 Feb 2019 23:38:24 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwExx-0007IV-2i
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:38:22 +0000
Received: by mail-lf1-x142.google.com with SMTP id g2so16110932lfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zxFGa80PRFQNZ0iIIPGTuF/1GgUnWcFVVtlV5AVJGzY=;
 b=SWzMxd2s312nAdp04588KTgH4jh5miGItESLcy+KlwQ6BBIsp74P0x1nT4HFEqqasf
 8PyOPXfFCmnVz1F7xxwTFyoNLJZrv+rHme+9L+j+E2hFKyk5QRsuvKzXR8crLl1bH9tq
 y0hReo2aYyBvdeVzLwLwelVuWuDTjd46760jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zxFGa80PRFQNZ0iIIPGTuF/1GgUnWcFVVtlV5AVJGzY=;
 b=VStBcNWt/vXy5u6Jxqb7R/kEGKpNPq+FsCR48HA+H4VuE+ZOn8qviQLRfqpT3arA67
 QBeIjULsZOjoKCW7Hny1v0LzEAzV4/YBj+FpyGEtkrIXorrxyxQtkJ1z+3TJzgSkPT1B
 /9lN058hWDAf/7HUqZ4raSL+0qtfZquHp3S0jAPSckBAni2FuFMP2UvlYN/+ziODrBVB
 AAgivT2SDZX5YOAl9wNIPQWNR/A4aow2c7qYgpPPsIN3ViM1HANVWwe3YuGw0ZbRJde7
 VeZXwOl8YF6GvJ7bm5txG9HjIC7qa8CSPle39m4AFMnHnKoXHCi7x/BeT0NBZ9wxa0HS
 VtEA==
X-Gm-Message-State: AHQUAubDJvsd3DX/iouv4eEeGv2wWY6oJM6q8MCSVDNxBERrMDEP1J40
 WuzFLVHwGNnqEuuZcujJYiEA1zpXkpE=
X-Google-Smtp-Source: AHgI3IbCKUdwMDb50aFX3mFQfvVK/Jtmk6fTmeKFUaNxPIxxDCoO91niOvyfAoLjboTPgLyNkgstKg==
X-Received: by 2002:a19:6001:: with SMTP id u1mr19624915lfb.56.1550619499100; 
 Tue, 19 Feb 2019 15:38:19 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com.
 [209.85.208.175])
 by smtp.gmail.com with ESMTPSA id l11sm4002981lja.38.2019.02.19.15.38.18
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:38:19 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id l5so15745947lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:38:18 -0800 (PST)
X-Received: by 2002:a2e:3a10:: with SMTP id
 h16-v6mr913549lja.184.1550619160820; 
 Tue, 19 Feb 2019 15:32:40 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-18-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-18-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:32:04 -0800
X-Gmail-Original-Message-ID: <CAE=gft5uXTZJms62_M7=14E7sSNepyLt9CL1KbfD163DsxHHFA@mail.gmail.com>
Message-ID: <CAE=gft5uXTZJms62_M7=14E7sSNepyLt9CL1KbfD163DsxHHFA@mail.gmail.com>
Subject: Re: [PATCH v6 17/22] memory: mtk-smi: Get rid of need_larbid
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_153821_120662_D3B6AFFE 
X-CRM114-Status: GOOD (  14.36  )
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
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
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
> Correspondingly, the larb_nr in the "struct mtk_smi_iommu" could also
> be deleted.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Thanks for the cleanup.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
