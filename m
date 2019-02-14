Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D3C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:44:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B952222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oZmHDTe9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="19NrYpPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B952222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ixwXQ7s1+z0/3Kj0QSUwYk3kwqJjbzhYJWy57GDK2f8=; b=oZmHDTe9/l5/oV
	PmgFlxqYPWvdDjFurnaXkgKZ1W3Xj+BT5roDsl/tnvLS1Fg/DRIdPkvsYUaMuejRVNrV2LaMZiOAa
	npJ+P2CNpSABxNfc+CImMb9zOY/9FJmUxoVXJ30FaVhoSCrXA+cDM7LiSMVZXXa5gdjDZ3FebtFVp
	wsAc/THPxEJOKZBv8OoOE/lP41GuRguSJ24rtxnplBE8WugFEedqqRZqccGRa+2zpxhygCeQuhrYM
	WGzOtGtlMyGcSbvR6/2n/PSIzRDWXBgjF+Sb+Kg9fjEsxiByTPe64764fRuKLdFeGXfF9+QaUGvL2
	hnVit5Z9cW6p/nGnQtFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guHJR-0001Na-QB; Thu, 14 Feb 2019 13:44:25 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guHJO-0001N9-WA
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p9+woFNKw9bBFLpBGKvJoKFn8DVfH2uNVw+3EK0qntE=; b=19NrYpPIpGgruXTtMEGbzKWgwO
 fgVVtEmWbnxwiE1vRUdTp7GIK/JfL8Pmspx1PI6ti9gZ3Gbl/fmFztgfWs68LX5iP+o9vdgv0nDaq
 yUEABdCanoH57MeWmdk/Ec0hF0X9wLH35AYPRMjqQLVVwzxQXY/1pLFIl7l/k/wQxg7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1guHJG-0001k4-Hy; Thu, 14 Feb 2019 14:44:14 +0100
Date: Thu, 14 Feb 2019 14:44:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Roullier <christophe.roullier@st.com>
Subject: Re: [PATCH  7/8] ARM: dts: stm32: Add Ethernet support on stm32h7
 SOC and activate it for eval and disco boards
Message-ID: <20190214134414.GB5699@lunn.ch>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-8-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550126763-22669-8-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_054423_182656_D3D5BAB7 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: mark.rutland@arm.com, robh@kernel.org, alexandre.torgue@st.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, peppe.cavallaro@st.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 07:46:02AM +0100, Christophe Roullier wrote:
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy1: ethernet-phy@1 {
> +			reg = <0>;
> +		};

The reg value should be the same as ethernet-phy@X.

    Andrew
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy1: ethernet-phy@1 {
> +			reg = <0>;
> +		};

Here as well.

     Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
