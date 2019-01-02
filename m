Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B85C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:00:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5CC218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ia9khsfI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYMwdb6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5CC218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X/Q8NyIrPFrwJt0eoN9l5AkgYQ2rDE2PAoMxsb2QfL4=; b=Ia9khsfIHlbC/7
	tSjE/efzTx1dtvAy6TySRDtbdR8pjfpaye01KLVuiCYdVdmd/Ew2wq1+uTPW1IrqAQarpd7XJHXGH
	QvKkvMioEEcO4p9Cx9Y5qLFK+5PbB53A03DWmLnUHP7CTtJXe6NnpIbTK/q0NFr6Y9Jta9Ym8006h
	/kx2UpY11JUDA/wTyoCSs/8evlBRUqENNNrvw/Osb2d4BwHy7mHOOZw1FJVDiYcUKnkyMir8TLfRN
	KAqt+7f0FT0aP7I97r1ct0Nl+nDMYQaVqtz9A2NL3feCDXN+5OIlPDpzq+/Cmx2FSki5UpYpHss/f
	2IFwPSNINcSCh4UJptDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gekoj-0005Ti-Sx; Wed, 02 Jan 2019 18:00:33 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gekog-0005Sz-Bo
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 18:00:31 +0000
Received: by mail-wr1-x444.google.com with SMTP id 96so31349161wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 10:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=crmJ+Hige/rGqRrSYyXt9V+tTDSuqc5vu0JbeeQ95MI=;
 b=HYMwdb6REUv9VQ3hvyMZy0tsSLP6CdaJOuBwX++M85lGTQ2t3GkXHAIV5qLwDNo/jM
 2Tp6AmrO9AzF2yEhbTEHinlUMem78yJcQ1XmgtMLaDX3emfPsJkIIAkgEWBT5k5V1VMO
 SUdErX1uC3HkxLcFbsbWr3OXrBooMoz4dVjwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=crmJ+Hige/rGqRrSYyXt9V+tTDSuqc5vu0JbeeQ95MI=;
 b=jSIGhHdiMs6aULppU12fa6iMuMP9PFwOFLjH5fpjz9zAysUbY1Zpz1vScSbJeoP2wz
 lyJb0y+psRJPFimvnKVvVwoU6FCTCRv/FsNPiHTA8pvvJyveJZeNgH9SoNGuZNxKGaXp
 bpouhyvu83coI/wk5sMXg3KdECDiOwyLJa3qBjrOo3ETNcTtW/sN2saV5NvfA6tocb8R
 O+eDwPYgJ+ZvKw5YJadk479yjPIRI4oF2RADx8uO8HZhB+rNACmyc/Yrw9xi1aIJWiOi
 KhD8odCOQxR6aIecEklF9z2lZr0punEKLeA1H6Dg1EoTWHjzGZBmq33Caxu1ruWC8QEy
 qbww==
X-Gm-Message-State: AJcUukeeC9ZEBPXfOzEKdT1m+7Xh+wa6CRTJyIhi6xEL2+n4P6nyyIe2
 HaBjCYdYYX9LBqmox1RZR4mcE+y8/do1visKtuIeCg==
X-Google-Smtp-Source: ALg8bN7EppCifOtzPEcN8dpB/+i2dd9Gmj/20uw6E369/AIGGqNL9aUG0sPXilgQhF8JkwUf/7SV/AHrb7C4NJKsgJU=
X-Received: by 2002:a5d:6988:: with SMTP id g8mr37231230wru.33.1546452027972; 
 Wed, 02 Jan 2019 10:00:27 -0800 (PST)
MIME-Version: 1.0
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
 <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
In-Reply-To: <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 2 Jan 2019 10:00:15 -0800
Message-ID: <CALAqxLW_eGX25sZKVCpGwoq94QdYj9K2nJg6buh=FAZZt_Cuhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dmaengine: Extend the k3dma driver binding
To: h00249924 <hutenghui@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_100030_408175_3C5CAB56 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, wwx575822@notesmail.huawei.com,
 hanxiaolong3@hisilicon.com, Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Hantanglei <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Kongfei <kongfei@hisilicon.com>, ninggaoyu <ninggaoyu@hisilicon.com>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Liyuequan <liyuequan@hisilicon.com>, dmaengine@vger.kernel.org,
 "huangli \(I\)" <huangli295@hisilicon.com>,
 wangyoulin <wangyoulin1@hisilicon.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Qianli \(A\)" <cash.qianli@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 27, 2018 at 10:39 PM h00249924 <hutenghui@huawei.com> wrote:
>
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
>
> Extend the k3dma driver binding to support hisi-asp hardware variants.
>
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 33 ++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 4945aea..cd21b82 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -3,7 +3,9 @@
>  See dma.txt first
>
>  Required properties:
> -- compatible: Should be "hisilicon,k3-dma-1.0"
> +- compatible: Must be one of
> +-              "hisilicon,k3-dma-1.0"
> +-              "hisilicon,hisi-pcm-asp-dma-1.0"
>  - reg: Should contain DMA registers location and length.
>  - interrupts: Should contain one interrupt shared by all channel
>  - #dma-cells: see dma.txt, should be 1, para number
> @@ -43,3 +45,32 @@ For example, i2c0 read channel request line is 18, while write channel use 19
>                         dma-names = "rx", "tx";
>                 };
>
> +
> +
> +
> +Controller:
> +               asp_dmac: asp_dmac@E804B000 {
> +                       compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +                       reg = <0x0 0xe804b000 0x0 0x1000>;
> +                       #dma-cells = <1>;
> +                       dma-channels = <16>;
> +                       dma-requests = <32>;
> +                       dma-min-chan = <0>;
> +                       dma-used-chans = <0xFFFE>;
> +                       dma-share;

Thanks for sending this out!

So min-chan, used-chans and dma-share aren't in the existing binding
document. So they probably should be removed from this example, or the
binding document needs to be updated first.

thanks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
