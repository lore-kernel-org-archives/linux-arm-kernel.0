Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CE1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:53:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4816B21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="azVURE6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4816B21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yTnB7vyDsdMld5p5h2D28ig9n0OHgJ3tckctcyxJo84=; b=azVURE6dJ/lvgy
	Jamklhby0QPMn16wxqVe6YJGi8xIy92KHgHLb2I1B4R/MKKzph6vsXlMXwTGqRCNX94Xp0cprt+xx
	9XjJ4itSW2OTOOVIWjZRx+opplXaOKXfzP97y/2o7XxdBuj0atUHMQsbHS4S42OHKb0XXgrBfDogc
	0iz/1QMdl7JEnO7tWmYVl6FXQ/1FBerpWdRz63nvE6HXVNfxY+TaAWTQyPAOw0mqtcNkS+MosGlyM
	6FBFxh1Ia1gUeZrxlsFojhWG7oQsyTKX5Cn9yGIIO0QyIVR8m5+Uw0KlJw/EQ74b0fSvSal0b2ht5
	vdEEc4XYCBgbml72uFUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFoD-0007At-Qo; Tue, 18 Dec 2018 13:53:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFo8-00079u-Va; Tue, 18 Dec 2018 13:53:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7489980D;
 Tue, 18 Dec 2018 05:52:59 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A9FD3F575;
 Tue, 18 Dec 2018 05:52:57 -0800 (PST)
Date: Tue, 18 Dec 2018 13:52:51 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH 0/4] Cleanup un-used variant and un-used property for
 MediaTek PCIe
Message-ID: <20181218135251.GA3560@e107981-ln.cambridge.arm.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_055313_017542_868AC759 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: youlin.pei@mediatek.com, robh@kernel.org, ryder.lee@mediatek.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 matthias.bgg@gmail.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 09:25:38AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The "num-lanes" property in MediaTek's PCIe device node is not used by
> its driver or anyone else, cleanup those related code.
> 
> Honghui Zhang (4):
>   PCI: mediatek: Remove un-used variant in struct mtk_pcie_port
>   dt-bindings: PCI: MediaTek: Remove un-used property
>   arm: dts: mt7623: Remove un-used property for PCIe
>   arm64: dts: mt7622: Remove un-used property for PCIe
> 
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 8 --------
>  arch/arm/boot/dts/mt7623.dtsi                           | 3 ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi                | 2 --
>  drivers/pci/controller/pcie-mediatek.c                  | 8 --------
>  4 files changed, 21 deletions(-)

Applied to pci/mediatek for v4.21, thanks.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
