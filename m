Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1CEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:47:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AFA20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PCrsAs8G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJVCvp1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AFA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ygLfweq5FPGmP9gaPpt7+aQ1uuA3K1YGn1ssKdbWmmk=; b=PCrsAs8GtiAZJW
	qGJSqH1qAg+BKElTvJzw1y/hGOTxj9jQqSWFwSofXP2f68zRwZWYBM0CbkP3eD4sz73qUPN3E9yK9
	kr4XHdsGfwaFPAuOwW1UI/K1SxNxZELGxWP2x6SMNLH+4NuS/C1SneKzPOJucGIXKcAPTcCvSwNZj
	4bxPhcbipwMfGAuPoiP3l6o7BYFVf9AJIY/9BtpmS8idDsNBezN6+dMESufU7SMPjpvolevr5mXNN
	YVaYsjIvMlv3+kOaMnpHh8bV0K3Yq+ku8qHzvDm2PJpSI+VKhIgjB443mp05LzNZ84+yKkapoGAEp
	4d2ZRDpxfm0zDxl/BQ+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTXiJ-0004Z5-Vo; Sun, 02 Dec 2018 19:47:35 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTXiG-0004Xu-1M; Sun, 02 Dec 2018 19:47:34 +0000
Received: by mail-ed1-x541.google.com with SMTP id f23so8960621edb.3;
 Sun, 02 Dec 2018 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vla8uBSZUkPFDG7ZJBxr9yKrfY2d7vmchRDMnstFLbs=;
 b=HJVCvp1Z0oliL+jbdmMfe5ndEiQo5Buo5WmcutrIeEIg/WpRcQsRooRJERc4kcNWPu
 ZCoDchTxncIegohV6e9ySMx6HSis9bmexKw4CCAp/exyKWIkNqZSMEB19CTMmUXHN3nW
 w00BfRSOnsp7lWbfCQRN4R40nHp8a0J1UHQfo5IO78P2dzYmiohG29xxk77avobw0kYm
 +kM5TCUJZnYgrEyCcktUB4CDaBPu1/8hxMrCc1PZGHYdL9CQRos+qCIcqYxPg9wlrIZP
 0CNQRMWmdzRXeXDfWjdepJS3wqttBzXcL8h5Q0l1nqL+NRRLrbmuEWv524gcThpUDNO2
 P7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Vla8uBSZUkPFDG7ZJBxr9yKrfY2d7vmchRDMnstFLbs=;
 b=XkCzuIsGaK2jmqaTS8H6HpO9of8xUQR0w+RkXz3o9QtDZa13YXPvd5BubdV+HsdZsz
 a+qt2PD1yOBHyLVUYyku2anldN2RiWejwU9CDQftJaBxfBermvtXo4LoUYJgWMJDUl41
 2OLXJihbp1Ht+xHheBqmgrKSHEj8JavoVwDEEi/t3e6Qda4n7bBhD5bMKVNo4C5I9rv3
 FImpQoO9SoKaok7AJejY2eYUu1ihAOnaOGzXVXOyV1M977H4QB2OiNuenPghADEYLczX
 9eUeMmLZFk95+GQ6Y5Rz7iMWpQdk+paCU4cNx/zjUxTNLnQZHzSV49pcpXnhEvsi94aX
 E69g==
X-Gm-Message-State: AA+aEWZENDTJZ6+GwZS5Wu9V4XtTaOvey3HPV830kS9Qi92xPe5DkVh9
 zez9iYBY44/wtogy+KHTiAo=
X-Google-Smtp-Source: AFSGD/UJiSiNz8s66R+psmIB0tIhaGwrIJfbopQ9KAf5JJver8lbEaqjIudrOKPnRzVvqdu4jZ8p9w==
X-Received: by 2002:a50:a246:: with SMTP id 64mr12516862edl.43.1543780040689; 
 Sun, 02 Dec 2018 11:47:20 -0800 (PST)
Received: from ziggy.stardust ([93.176.147.153])
 by smtp.gmail.com with ESMTPSA id n16-v6sm1828026eja.6.2018.12.02.11.47.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 11:47:20 -0800 (PST)
Subject: Re: [PATCH v27 1/2] arm64: dts: mt8173: Add GCE node
To: Houlong Wei <houlong.wei@mediatek.com>
References: <1543462629-32746-1-git-send-email-houlong.wei@mediatek.com>
 <1543462629-32746-2-git-send-email-houlong.wei@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <99c858af-f9dd-0fa6-6554-a624d71a1967@gmail.com>
Date: Sun, 2 Dec 2018 20:47:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1543462629-32746-2-git-send-email-houlong.wei@mediatek.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_114732_078098_0A1AC9B8 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: Daniel Kurtz <djkurtz@chromium.org>, Monica Wang <monica.wang@mediatek.com>,
 enzhu.wang@mediatek.com, Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 HS Liao <hs.liao@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 YT Shen <yt.shen@mediatek.com>, devicetree@vger.kernel.org,
 kendrick.hsu@mediatek.com, Sascha Hauer <kernel@pengutronix.de>,
 Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, CK HU <ck.hu@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
 ginny.chen@mediatek.com, Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 29/11/2018 04:37, Houlong Wei wrote:
> This patch adds the device node of the GCE hardware for CMDQ module.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index abd2f15..412ffd4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi

Applied to v4.20-next/dts64

Thanks a lot, it was a long journey :)

> @@ -18,6 +18,7 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mt8173-power.h>
>  #include <dt-bindings/reset/mt8173-resets.h>
> +#include <dt-bindings/gce/mt8173-gce.h>
>  #include "mt8173-pinfunc.h"
>  
>  / {
> @@ -521,6 +522,15 @@
>  			status = "disabled";
>  		};
>  
> +		gce: mailbox@10212000 {
> +			compatible = "mediatek,mt8173-gce";
> +			reg = <0 0x10212000 0 0x1000>;
> +			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_GCE>;
> +			clock-names = "gce";
> +			#mbox-cells = <3>;
> +		};
> +
>  		mipi_tx0: mipi-dphy@10215000 {
>  			compatible = "mediatek,mt8173-mipi-tx";
>  			reg = <0 0x10215000 0 0x1000>;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
