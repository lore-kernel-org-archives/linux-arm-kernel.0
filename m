Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4518C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8422C208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dVlL9Fw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8422C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tY1isOwr1xvq5c460wtCz+8KRQgdW45ZbLe6+yzS/1Q=; b=dVlL9Fw1+LX34G
	ajR3oytGtTCaetq4wUK3pd75NQzVOfhbpH5DGEWtjc5zZuqbqZI6LCdzCYNDUU1zAcRJkMDGHshLJ
	4AHhJHPfeqH2E0txKyrm80dtfN4NhKj7yK6obd9nkrPf+eKt/dnBuzf+zIr+lD6+vhUr03i7uHsKw
	6HACNb1GKfZc2BUjhNCCXYOvQRscfLl/aLwdQf2vF4WjPS5CHL9PRDyXAlCch4gz7/IGtuc6qF8Nq
	xlnmO5kro6+L6vKgSt0Nx1lG81CeIL/9Tc/+DflM1Ocl9ZkfesaUkOhO1XMQOhRQeHWmSdNA2HOln
	O1YfEPlKDSlunkgdhBkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfCJH-0000Rh-Hc; Thu, 03 Jan 2019 23:21:55 +0000
Received: from mail-io1-f66.google.com ([209.85.166.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfCJE-0000GJ-EA
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 23:21:53 +0000
Received: by mail-io1-f66.google.com with SMTP id t24so28315671ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 15:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=t0GSUHJkdf7A98ACvSRb5N0KlJsjQDdljT+v5mzWcng=;
 b=NNcigZ3CPdpAsYyGK70aCbppQBjR87yz8Vm4Z1KF0vZEDczpyv2emU6hS8MOo3MygZ
 kTGbGCaM21VhHC7BPOHWEbPyS0i66K6VII4Ox11Bh6/B5OtnQc6bAbRak50K5oi+hB0h
 MM//fFdWwH0Bjexx1TcJNOMw584aiBFfEKQDi0jFMZ70J5hkR3aEXYrT5ybPe0gzqCwO
 S6qA4g95UcD9/87CH1ee3e0AlrbhUaty7ALmkAhMNTFfDsHrpsvIROCuoeDofCl3gV+t
 wXzenSWdg2QY32bEuwC5JUIKKXemTDvQAaKxkpNRZsEsos7VDobmA0SYKUHnNJYeIC9t
 EnVQ==
X-Gm-Message-State: AJcUukde3AmhkR53qneivHiQqqVmA6jmJWuoO8nZ+gGyRpU0qwyrPUkx
 TKWYkcbhvGvPFdysnGKFKQ==
X-Google-Smtp-Source: ALg8bN7nGzB2+t8W/4kEM9c+6HojlLRCiPxYeSafGIb7MY6yUqAZBvlpojBV+l7ABQlR/Ae+nmWsGA==
X-Received: by 2002:a6b:5a14:: with SMTP id o20mr32580034iob.206.1546557710707; 
 Thu, 03 Jan 2019 15:21:50 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id e141sm24917821itc.40.2019.01.03.15.21.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 15:21:50 -0800 (PST)
Date: Thu, 3 Jan 2019 17:21:44 -0600
From: Rob Herring <robh@kernel.org>
To: h00249924 <hutenghui@huawei.com>
Subject: Re: [PATCH 2/3] dmaengine: Extend the k3dma driver binding
Message-ID: <20190103232144.GA17431@bogus>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
 <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_152152_481255_3676473A 
X-CRM114-Status: GOOD (  18.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Youlin Wang <wwx575822@notesmail.huawei.com>, hanxiaolong3@hisilicon.com,
 suzhuangluan@hisilicon.com, hantanglei@huawei.com,
 linux-kernel@vger.kernel.org, kongfei@hisilicon.com, ninggaoyu@hisilicon.com,
 Vinod Koul <vkoul@kernel.org>, liyuequan@hisilicon.com,
 dmaengine@vger.kernel.org, huangli295@hisilicon.com, wangyoulin1@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, cash.qianli@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 02:36:22PM +0800, h00249924 wrote:
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
> +-		"hisilicon,k3-dma-1.0"
> +-		"hisilicon,hisi-pcm-asp-dma-1.0"
>  - reg: Should contain DMA registers location and length.
>  - interrupts: Should contain one interrupt shared by all channel
>  - #dma-cells: see dma.txt, should be 1, para number
> @@ -43,3 +45,32 @@ For example, i2c0 read channel request line is 18, while write channel use 19
>  			dma-names = "rx", "tx";
>  		};
>  
> +
> +
> +
> +Controller:

Why is a new example needed just for a new compatible string?

> +		asp_dmac: asp_dmac@E804B000 {
> +			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +			reg = <0x0 0xe804b000 0x0 0x1000>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +			dma-requests = <32>;
> +			dma-min-chan = <0>;
> +			dma-used-chans = <0xFFFE>;
> +			dma-share;
> +			interrupts = <0 216 4>;
> +			interrupt-names = "asp_dma_irq";
> +			status = "ok";
> +		};
> +
> +Client:
> +		i2s2: hisi_i2s {
> +			compatible = "hisilicon,hisi-i2s";
> +			reg = <0x0 0xe804f800 0x0 0x400>,
> +				<0x0 0xe804e000 0x0 0x400>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
> +			dmas = <&asp_dmac 18 &asp_dmac 19>;
> +			dma-names = "rx", "tx";
> +			#sound-dai-cells = <0>;
> +		};
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
