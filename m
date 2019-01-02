Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BE8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527FD218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UFDQUojD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="12/BKbEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527FD218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qRiLDge4COjr7t4ec5H6ZPMcl5xqKXUSbX4wLyN8xiQ=; b=UFDQUojDfk4T+K
	ArwEkcT8bcwLBP6UbCTrxgttbr6iBx12at0/ZwogIB7ehqteq/k11M2PGRGArbuKR8WDMYE1IMsun
	hZzLxralyPnpYloZpqq0zqrNsRZgadMcEhFxa+esBiDAlQc4in/Lt+wxyWuJOQiT0ir6I/IgNLN8Q
	sfVvAtSmZS6HqJVR/JWi7mb7z65JXDcIgVIhGbn/NJIgwt6YWICJw+xFyalVearKmiY3CUj2hL9hV
	xMcu2wmjrYnj7jnIiY3MW8iYFj8MdzmfZhCVn54tCmoqHmqSiRtS53eXbG1H3+/cvuAPAonE4wHyv
	jVeUE78MPzzluG6l0eqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gehfO-0000uG-T6; Wed, 02 Jan 2019 14:38:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gehfM-0000tv-Lx
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 14:38:41 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6108218DE;
 Wed,  2 Jan 2019 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546439920;
 bh=KSxJC1Iky7N4uxNWfM9AN9FX7O6Wjxl8Eo5EFUphBj8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=12/BKbEWBka2G3PbESswW27O8koUSfQ9UpK89gs7RejeU2iQRZCVBKxQHbXXGFRor
 8SxeMdCt/2r7EFbb6DBK5tQ0BQ8pROdhkel5kMNhK+xPFpRmpeuxpoC4kOIdScER7B
 dcCz6V9Fpemxqn0D7FBVWi4wbJT2o8bki+cHLAk4=
Date: Wed, 2 Jan 2019 20:07:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/7] dt-bindings: net: Add Qualcomm ethqos binding
Message-ID: <20190102143707.GN7581@vkoul-mobl>
References: <20190102091729.18582-1-vkoul@kernel.org>
 <20190102091729.18582-2-vkoul@kernel.org>
 <20190102140731.GI22737@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190102140731.GI22737@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_063840_729143_AB55ACC9 
X-CRM114-Status: UNSURE (   7.73  )
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

On 02-01-19, 15:07, Andrew Lunn wrote:
> > +	mdio {
> > +		#address-cells = <0x1>;
> > +		#size-cells = <0x0>;
> > +		compatible = "snps,dwmac-mdio";
> > +		phy1: phy@1 {
> 
> phy@4 since reg = 0x4

Right, will fix this

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
