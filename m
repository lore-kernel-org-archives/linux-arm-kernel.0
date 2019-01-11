Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D2420874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fy5J7fU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D2420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pq20GG6eLCq9H5u36kTxQ///NqRU9KlvXikttFOuI5M=; b=Fy5J7fU23Av8oO
	B8swhHVjfAG6lXm0Ne0Mn9840TN4jnnMH3qiYCgtuR2O3qU69qzdtOyntV1iXgfoEr7MON8g0zayD
	Y8zTNQKANpo9pjzW26zev+6MDIUM5oE2dBB1nH5mKGJ19qxuau1xgcmPCzgRDEE/eqmBiwygf6/pa
	SXvLbOuuWLXpw6XgwT/4F7KrM+9b0ZQOzTD3WlkTuk0uryICszP0KefFXXpMszb8s+zn+YO2pPiVi
	I7dA4JONZY7657UCyOttWHu1ANtPhw+18CElhM6Clq+e7HRn/BJ5pN/injEphyamelyUR7ROoUUEw
	Mo3JQgTjUQvwtWnTJNgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyJ8-0005PF-BH; Fri, 11 Jan 2019 15:01:14 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyJ0-0005No-Ig
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:01:12 +0000
Received: by mail-ot1-f67.google.com with SMTP id s13so4836250otq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 07:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tvjsmNv2ozKilJqW/hbPznvH/zBjxGIJWFcCGyvEiTI=;
 b=royz4Od/NQos9NOEsfHNfqwz+VRBWqbYKSIUQBes3w9FBkCxQS5eNThnPAmjD+ijAz
 wenURBrwSdvnO2o3WeV/uUWIj3WYT3hYs5GEvIGYZ5slLTEiWfSaIeTa+/AqxvYZZXZy
 pNgFg6345drzDmTB70nIB+hMTp+Bp/JS0psp+YOk7/qRAASGmfEfowaY/37YuT5jzYQE
 H5rYsLHNBoJCDYN19eR76k7x4dqwviu14rJ1h3KhaJ2v2qqez8LtZtEkJpOhLAGtwNNB
 oR4VBCW5GvvuAyvqjORhZmVeQI5vKAtFDRd5/8FvEYL9SQWJzTvT9tM+VT4z6LbY9vpV
 utBQ==
X-Gm-Message-State: AJcUukclXYU3QWNOq383LOGG4ZQD4PEVAokUu0So0H/59IJk/F/P7KSv
 oy3C7dvdmSBpiymL8MrlZA==
X-Google-Smtp-Source: ALg8bN5VtP2ktnfaO6Bmh7ETkGMkiZGqpIfxtejBAyPXs/10dOlhE0BNN/lr+MQp4wPZ+NiR+N4jBg==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr10439136otg.74.1547218865738; 
 Fri, 11 Jan 2019 07:01:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u65sm31382796oib.5.2019.01.11.07.01.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 07:01:04 -0800 (PST)
Date: Fri, 11 Jan 2019 09:01:04 -0600
From: Rob Herring <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/7] dt-bindings: net: stmmac: Add the bindings
 documentation for delays
Message-ID: <20190111150104.GA1465@bogus>
References: <20190102091729.18582-1-vkoul@kernel.org>
 <20190102091729.18582-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190102091729.18582-4-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070106_615518_D4279C0F 
X-CRM114-Status: GOOD (  16.18  )
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
 Niklas Cassel <niklas.cassel@linaro.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 02:47:25PM +0530, Vinod Koul wrote:
> Some controllers require that phy delay should be disabled. So add

If the MAC requires it, then the compatible string should imply this. If 
it depends on the PHY, then okay.

> optional properties rx-disable-delay and tx-disable-delay for it.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/stmmac.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stmmac.txt b/Documentation/devicetree/bindings/net/stmmac.txt
> index cb694062afff..ec18897e22c8 100644
> --- a/Documentation/devicetree/bindings/net/stmmac.txt
> +++ b/Documentation/devicetree/bindings/net/stmmac.txt
> @@ -74,6 +74,8 @@ Optional properties:
>  	- snps,mb: mixed-burst
>  	- snps,rb: rebuild INCRx Burst
>  - mdio: with compatible = "snps,dwmac-mdio", create and register mdio bus.
> +- rx-delay-disable: bool, when present disable the rx delay
> +- tx-delay-disable: bool, when present disable the tx delay

Needs a vendor prefix.

>  - Multiple RX Queues parameters: below the list of all the parameters to
>  				 configure the multiple RX queues:
>  	- snps,rx-queues-to-use: number of RX queues to be used in the driver
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
