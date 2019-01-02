Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BCCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:07:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD3E218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U2f1BUdK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Tm+Ixs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD3E218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wsE3/VJZ6TVjPO9/Qrb8Kx2EzVFUZ5TMuRh/71oGa1k=; b=U2f1BUdK711UvJ
	lutCZMM3bqE4kXhip0M+JSu0K5n96gHnbXkSqtuXPwuJf/vJ269ddTEutRWpt0ImTMYdR7IsSmX2o
	4diccb+miM8WCCAV+nTfGTaVBYLg03U0zDBTxbZrl1GqLA13EXkBwfItKFv3aPqiSu+SdQqmuPvRx
	gqvegureUVjoxWNsRZXBGe14tkaqpys8WDEtEPA25gy+o8VV/nDe46bkAOvyDTm4C0KcM4VLRZxnk
	xRLYF5hMOEXbjvGXFTThA6XW9OwVZZye+5DNzzSlRULnsH/P1FV+J61atz4oPkWCfPlBNvCm8v8SR
	RKtvmfmbz5HODmTnHmeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gehBJ-0003b8-JE; Wed, 02 Jan 2019 14:07:37 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gehBG-0003aP-PD
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 14:07:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=gc/jZHhyDYB/hI3+9G3Ok70gehPngsvl+bpmNJ+U9kQ=; 
 b=4Tm+Ixs1Mlat+iyNPp1e2TTEZOkdUYxkYe8Gjb3IEpmRBHBKT5iatRCfDcL3UIFJiF7E1OBQGKVThuv+c4lvMEgQTDEGXdY/y2jFtdM6O8haOZmK9BfAvK8hqE8Q5Az/e1r9hY7XOWc5GZkHRsU4fNj9yfokBV++YHKE9vgj0gw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gehBD-0008Ut-SH; Wed, 02 Jan 2019 15:07:31 +0100
Date: Wed, 2 Jan 2019 15:07:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: net: Add Qualcomm ethqos binding
Message-ID: <20190102140731.GI22737@lunn.ch>
References: <20190102091729.18582-1-vkoul@kernel.org>
 <20190102091729.18582-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190102091729.18582-2-vkoul@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_060734_971628_DB356D6D 
X-CRM114-Status: UNSURE (   7.01  )
X-CRM114-Notice: Please train this message.
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
 netdev@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +	mdio {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy1: phy@1 {

phy@4 since reg = 0x4

> +			device_type = "ethernet-phy";
> +			reg = <0x4>;

Thanks,
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
