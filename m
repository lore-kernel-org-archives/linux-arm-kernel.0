Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA1C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:18:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3F720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aYvTUzM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3F720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3ZU1Uf5sCUuMO93UVhtyllbWuM4Ob9VrtfCa88iucjM=; b=aYvTUzM+oOXRep
	MOAaww4ajoHgPdahKF77QVe1q+SQzRouEyArhS+rN6q6BkCjhxQoRRt5dgHH914+GC7D9XKx2lEtQ
	oBXUbbaGNzu+/j4SqqKAZaV8Mp9hJojc6MxRatam4ySPhL2CgoH9XQQXwG12GgKgxl8wRjzPTJMFZ
	GGtlePnXRmQ+gfIwNqqimI1LZi0Ngr83qoqdFgYXn6mWfJGHwpyoPrDgPD/odvF74keS6VqvjUDjE
	3DYI3YHfxkbTVBMxCUTQr3o7oCOaZuR2c2OFdZUO88BY85DHqXf+t6eTqxsMkxh2Gkilr/yCQD9B0
	lDU9Y9G/iyKWyhqRzaeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKKc-0007ie-9h; Thu, 13 Dec 2018 06:18:46 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKKX-0007h0-Dc; Thu, 13 Dec 2018 06:18:43 +0000
X-UUID: d1fdeb27563348d39f8cfa10bac8a64a-20181213
X-UUID: d1fdeb27563348d39f8cfa10bac8a64a-20181213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yingjoe.chen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 661874654; Thu, 13 Dec 2018 14:18:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 14:18:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 14:18:07 +0800
Message-ID: <1544681887.32198.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 2/2] arm: dts: mt2712: add uart APDMA to device tree
From: Yingjoe Chen <yingjoe.chen@mediatek.com>
To: Long Cheng <long.cheng@mediatek.com>
Date: Thu, 13 Dec 2018 14:18:07 +0800
In-Reply-To: <1544506645-27979-3-git-send-email-long.cheng@mediatek.com>
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
 <1544506645-27979-3-git-send-email-long.cheng@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_221841_584977_F1E90CBB 
X-CRM114-Status: GOOD (  12.75  )
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
 Ryder Lee <ryder.lee@mediatek.com>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 Sean Wang <sean.wang@kernel.org>, YT Shen <yt.shen@mediatek.com>,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-11 at 13:37 +0800, Long Cheng wrote:
> 1. add uart APDMA controller device node
> 2. add uart 0/1/2/3/4/5 DMA function
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   50 +++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index 976d92a..a59728b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -300,6 +300,9 @@
>  		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&baud_clk>, <&sys_clk>;
>  		clock-names = "baud", "bus";
> +		dmas = <&apdma 10
> +			&apdma 11>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
>  
> @@ -378,6 +381,38 @@
>  		status = "disabled";
>  	};
>  
> +	apdma: dma-controller@11000400 {
> +		compatible = "mediatek,mt2712-uart-dma",
> +			     "mediatek,mt6577-uart-dma";

Sorting, please make sure this is before 

        auxadc: adc@11001000 {


> +		reg = <0 0x11000400 0 0x80>,
> +		      <0 0x11000480 0 0x80>,
> +		      <0 0x11000500 0 0x80>,
> +		      <0 0x11000580 0 0x80>,
> +		      <0 0x11000600 0 0x80>,
> +		      <0 0x11000680 0 0x80>,
> +		      <0 0x11000700 0 0x80>,
> +		      <0 0x11000780 0 0x80>,
> +		      <0 0x11000800 0 0x80>,
> +		      <0 0x11000880 0 0x80>,
> +		      <0 0x11000900 0 0x80>,
> +		      <0 0x11000980 0 0x80>;
> +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "apdma";
> +		#dma-cells = <1>;
> +	};
> +
>  	uart0: serial@11002000 {
>  		compatible = "mediatek,mt2712-uart",
>  			     "mediatek,mt6577-uart";
> @@ -385,6 +420,9 @@


...deleted


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
