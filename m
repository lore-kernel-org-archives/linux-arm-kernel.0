Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D598C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:52:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B0B218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HwObnEd3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb1CXkOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B0B218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=22eAqn/GlwpTNtsTlYA2E1pElaEtQmeD8xYLGvCQMh8=; b=HwObnEd33/X1SY
	9Dg+gpyWTGT0S/6Byml32AGjJyOVOEi93CxPjUUqulo4VRgioBrpohXOpPXreQw4kNhmE5YV4pBEW
	ztVfh94b+HIJEjco657uqAdXev1wjNzmxbxpGJ3wJcq4dWTqdQvHBhufuX7JVo4SjoQdK6cgr9aLI
	6jJtIj+XVmayqZZEfKBMZeEKIQj5eYb/yuUqYUsTooQzQ7kMICt4CpWJJSY5dJiVATsTaefk57JZ+
	NDhhRRP3Sr+xsvlc5iCUQC6qFcHBk2Mpf7FlpmXzHhiFFjGMeXvrz3OGmBiwnJCUXoObOO1Kmni8Z
	ZDf1QvBmrstyCntgrIPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmsXm-000330-P7; Fri, 25 Jan 2019 03:52:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmsXj-00032X-IW; Fri, 25 Jan 2019 03:52:37 +0000
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 96306218E2;
 Fri, 25 Jan 2019 03:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548388354;
 bh=QjJfJAWb0FZ5pqq41y0/x0xjclMd9L8cJJNHUvy33U4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gb1CXkOycEV5lU97KyTzF1Fn8MVf0CwXq/0vWC5zlyx97oMpW9OCads+gBzFqCQs5
 P5mu0iMPQv94pABP91vGkYLQQniMqqkY2I7NY7IWx8h7XTH6R94yMK9E9xRGwO6vS5
 EhXJ0i9glgU7mKDCDYD+yVnMQa4jVZ4xXT6epW8s=
Received: by mail-wr1-f45.google.com with SMTP id t6so8728772wrr.12;
 Thu, 24 Jan 2019 19:52:34 -0800 (PST)
X-Gm-Message-State: AJcUukcCrBynha9bb1juxa7QMSACWpO+PaAdv0oFLtbUZZdYFD5WWxCd
 Lw7nl+Z/Xf4PkS4CAT2cfJl0pt6QX57sRqSbQME=
X-Google-Smtp-Source: ALg8bN5yvgt59covVG6lIFn3cW7Zt6kKnn0KEC8w6n6KayED8ss+qwnOw9vxugt3wTC3U75xUMkQtbxwtm+rsoQbPpk=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr9370428wru.291.1548388353048; 
 Thu, 24 Jan 2019 19:52:33 -0800 (PST)
MIME-Version: 1.0
References: <1548326680-16454-1-git-send-email-shun-chih.yu@mediatek.com>
 <1548326680-16454-2-git-send-email-shun-chih.yu@mediatek.com>
In-Reply-To: <1548326680-16454-2-git-send-email-shun-chih.yu@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 24 Jan 2019 19:52:21 -0800
X-Gmail-Original-Message-ID: <CAGp9LzofToojhoXL9DpbrF-GKcxnGX7VBKrTq27SF8uGYnQOMg@mail.gmail.com>
Message-ID: <CAGp9LzofToojhoXL9DpbrF-GKcxnGX7VBKrTq27SF8uGYnQOMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add MediaTek Command-Queue
 DMA controller bindings
To: shun-chih.yu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_195235_649074_CF7AC8C5 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, srv_wsdupstream@mediatek.com,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

You dropped the version tag that doesn't reflect that is a newer one
and that would be easily ignored by other people

On Thu, Jan 24, 2019 at 2:46 AM <shun-chih.yu@mediatek.com> wrote:
>
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
>
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6765 SoC or other similar Mediatek SoCs.
>
> Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

otherwise, Acked-by: Sean Wang <sean.wang@kernel.org>

> ---
>  .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
>
> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.txt b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> new file mode 100644
> index 0000000..fb12927
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> @@ -0,0 +1,31 @@
> +MediaTek Command-Queue DMA Controller
> +==================================
> +
> +Required properties:
> +
> +- compatible:  Must be "mediatek,mt6765-cqdma" for MT6765.
> +- reg:         Should contain the base address and length for each channel.
> +- interrupts:  Should contain references to the interrupts for each channel.
> +- clocks:      Should be the clock specifiers corresponding to the entry in
> +               clock-names property.
> +- clock-names: Should contain "cqdma" entries.
> +- dma-channels: The number of DMA channels supported by the controller.
> +- dma-requests: The number of DMA request supported by the controller.
> +- #dma-cells:  The length of the DMA specifier, must be <1>. This one cell
> +               in dmas property of a client device represents the channel
> +               number.
> +Example:
> +
> +        cqdma: dma-controller@10212000 {
> +               compatible = "mediatek,mt6765-cqdma";
> +               reg = <0 0x10212000 0 0x1000>;
> +               interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
> +                       <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&infracfg CLK_IFR_CQ_DMA>;
> +               clock-names = "cqdma";
> +               dma-channels = <2>;
> +               dma-requests = <32>;
> +               #dma-cells = <1>;
> +       };
> +
> +DMA clients must use the format described in dma/dma.txt file.
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
