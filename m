Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC520C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E52D2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+HxWX5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E52D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FsdH3KcRkav7+lNpSQSxym3Dy1tA0HiD0iB3FesnCRo=; b=Z+HxWX5Q7Dq3Ai
	WdrPr3gxP4Qi33oW3DViZhvgHssaqB0vM1MkFx2ytEWLeIPOpa48UivHWxa+D62g35/3zm4vucarF
	w7uLBQep+YbDvpf9QKF6nDoKWuZ/TyVXbcVr+Gj1o0sniET6YwFy0Dks4lLqERVsKMni1ThaOrpvR
	QOdeY2rKSsIaLUlV8f60u1xFN11ZsxqjB+Q6YmmAGoHXCGzj1iq19ocie9Wp5XCuN1RfMiyRIk7TM
	P4wpEVmjwU8+Xg5jrogh+8kh080Am5Grd1ixBDlpGACde+BJps1F07i8e+Idxij1dIXsPxHEBleD0
	XlRsbWcXBNmupDSHhrMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkCb-0005wl-PQ; Mon, 18 Feb 2019 14:47:25 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkCY-0005wI-Pr; Mon, 18 Feb 2019 14:47:24 +0000
Received: by mail-ot1-f66.google.com with SMTP id 98so28730576oty.1;
 Mon, 18 Feb 2019 06:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mi5KJ4XJl6hs8QPqo8n1vqN9I3V/5JezP3CF56Gj/Fk=;
 b=S+Z8H5wlSNOsuaN0yCm8k4KyiFuKyTjV2d11I7VfwhRe5EfNgrDF+cGTYx8EqqI6Sl
 QhsaGbDOUpum1iipVa4uA9Bn9Y/ueHInCUUwN1UvxymqP957lqfRYOZ4ZpT2h9Lbv/pA
 +Ca/7oanKuQrbxtHFXBMb8p+hven6lbiGp/PAqL7vkYiwwWYU/IvRN1vdoaFpr6xk+UM
 bFN26U0d+61Opm1lHDxDVu2EjLpWTfE0yqUUKKhfMKQxu9Smd3glq9NptgLcgBYi+X6J
 NHyBR+TY+IBH6ipQ6CsJ4uvtvy8IeCbwdRWpB8lUPp4ZjPBCEbdK5ecl4SkAePLnKWTl
 Fw1w==
X-Gm-Message-State: AHQUAubxWy2AzGPXhRCt8ZKx+HgXFEesi1X+b5rZkRN9HgTNSgrs4pP6
 5ozYnIceqSyrsRwS1Ulu3A==
X-Google-Smtp-Source: AHgI3IaZRnuTuypXOjt44Iu8Lq0xprBFB2vawC7NKIt9SaAgWtVubytjH3+d+2llkk5lb/NnVi1cLg==
X-Received: by 2002:a9d:7417:: with SMTP id n23mr13908923otk.63.1550501241034; 
 Mon, 18 Feb 2019 06:47:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 88sm2285575otx.57.2019.02.18.06.47.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 06:47:20 -0800 (PST)
Date: Mon, 18 Feb 2019 08:47:19 -0600
From: Rob Herring <robh@kernel.org>
To: shun-chih.yu@mediatek.com
Subject: Re: [PATCH 1/1] dt-bindings: dmaengine: Add MediaTek Command-Queue
 DMA controller bindings
Message-ID: <20190218144719.GA28079@bogus>
References: <1550130058-16566-1-git-send-email-shun-chih.yu@mediatek.com>
 <1550130058-16566-2-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550130058-16566-2-git-send-email-shun-chih.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_064722_839659_D5C09C59 
X-CRM114-Status: GOOD (  17.50  )
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
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 03:40:58PM +0800, shun-chih.yu@mediatek.com wrote:
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> 
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6765 SoC or other similar Mediatek SoCs.
> 
> Change-Id: I9736c8cac9be160358feeab935fabaffc5730519

Drop this.

> Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
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
> +- compatible:	Must be "mediatek,mt6765-cqdma" for MT6765.
> +- reg:		Should contain the base address and length for each channel.
> +- interrupts:	Should contain references to the interrupts for each channel.
> +- clocks:	Should be the clock specifiers corresponding to the entry in
> +		clock-names property.
> +- clock-names:	Should contain "cqdma" entries.
> +- dma-channels: The number of DMA channels supported by the controller.

What's the range of valid values?

> +- dma-requests: The number of DMA request supported by the controller.

What's the range of valid values?

> +- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
> +		in dmas property of a client device represents the channel
> +		number.
> +Example:
> +
> +        cqdma: dma-controller@10212000 {
> +		compatible = "mediatek,mt6765-cqdma";
> +		reg = <0 0x10212000 0 0x1000>;

Should be 2 entries here since there are 2 channels? Or the description 
above is wrong.

> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
> +			<GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_IFR_CQ_DMA>;
> +		clock-names = "cqdma";
> +		dma-channels = <2>;
> +		dma-requests = <32>;
> +		#dma-cells = <1>;
> +	};
> +
> +DMA clients must use the format described in dma/dma.txt file.
> -- 
> 1.7.9.5
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
