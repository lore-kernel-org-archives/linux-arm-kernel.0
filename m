Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA81AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FE2217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sMEPYsw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FE2217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ast7BO9Z5mbASsvgglhHYUUSIqqCWtw7l3Np5cABaQ4=; b=sMEPYsw+MnK5/7
	vmiHxQgoAM3LjSxlPY61JTIJS/pHgHQ18yGDrieMZvXpbps58MLSTrIN3SGpa9er9JSUhluc49PRn
	5Fb+yPTOUY426uFYxw2udxPeX0snX773KTGmJBeXOqaCUhQCZ7kTKwVT4UgQTf4Lu91Tq1PWsyJU6
	KSFs73x0fFEgCRD5OaF8rqv18v9KYFgyZtvkgMRKSQ9uRRKC4DUAfSaK1hzjB3eCq5b6/K1Jqfycv
	Mohq1sWFhDxum3G11B3Yu65X5JNgAI3YruS61R12cV7L1hsEhAuuQinFmWStz0pzJocrJQL4sH4rz
	BW8JwN1HFctAa81Of4Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyPjn-0001kn-Om; Mon, 25 Feb 2019 23:32:43 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyPjl-0001kM-5C
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 23:32:42 +0000
Received: by mail-ot1-f68.google.com with SMTP id b3so9508927otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oY6TrrTiKp6RYwVvzAvUnV95A9z/ydNlba15u/xoTh4=;
 b=r6zH4poA/NnlcyWcrpiv5+qGKYcrM9TiY9VDWqGA0FVrhCGBKQkq8iqK4MvErNePhg
 lFJsvTV9EyfMGvOl8QhYCuZ3ARJZmnALO4sGfsBnWO+dECxQWRT80TnMt1aqploV5vRZ
 1g8YbbozZZCVjCOF45Zh7nQnWKtEqys4M6yVQ7tb7cPPDox9vpSce4LVxEWcRoTOlYHH
 fqhv85g2VAunv+fDMnur6CQBdkujRSWnmr0URgKybzIoabbl7Y06hGYpggr8WaWPbv1x
 1DfND/GrwCr5ELRAqp+NVDOgGXZ9typJx+WlX4txez9UeO0REISLcuSyud+4atNVQiMi
 OJTQ==
X-Gm-Message-State: AHQUAuYx03dkcyRHBah/q5QzMPpQvbkjrM5gYKtU8Eddq7RaFoa0Djxw
 9Efwn5yOTVyflw3lxFsneA==
X-Google-Smtp-Source: AHgI3IYjUYBUyr0/go/WiaF9ID0SKURF7G0NxoXKDPoa8sje5RQdzHwO0j3CziMzTHEWDRBmrIpgVA==
X-Received: by 2002:a05:6830:140e:: with SMTP id
 v14mr13873159otp.39.1551137558316; 
 Mon, 25 Feb 2019 15:32:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c24sm4582225otl.67.2019.02.25.15.32.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 15:32:37 -0800 (PST)
Date: Mon, 25 Feb 2019 17:32:36 -0600
From: Rob Herring <robh@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: lpc32xx-adc: Document
 vref-supply
Message-ID: <20190225233236.GA25036@bogus>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190208160944.13281-3-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_153241_193824_879A0420 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri,  8 Feb 2019 17:09:41 +0100, Gregory CLEMENT wrote:
> As most of the other ADC the lpc32xx one use a vref-supply property:
> document it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
