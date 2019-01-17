Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:38:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A8320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N55/1UcR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvdeQ58/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A8320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Kl9dvIeyYhnG34v7A4/b61QlqHYbHH+Kfq6FlCO4Mc=; b=N55/1UcRWMQ41G
	i1sNFASnPpTDNTHfzjdBgFBMcPkUdzzIY6IePTvzQoRHHBY8FBlkvAVtmfZyOLwmV64uHrYbBTBxL
	E5vPZrlMRaL6A6dSgrhTH+xl3Y9CBYsbHryn8g1Z7s4YMM2Yrpqvh33iKb+49BLNj5vr1N0wE8V/6
	mgmSDgAdtTnZoF++lupi5ReBoVL7/0cpEAloXxFCNQJSrd++hxqTbCPzz8+QpaasXwULxzLHP63zx
	TANlQwzFxrxwQ+2z87WDB0L/P4zhQfMybvvSwiwr2Or1v0ENsawN1XRmPzqndrLbq8tSWP1PlSVgC
	NB6dUfJzGeHOnDkvwB5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1KD-0003ua-Hw; Thu, 17 Jan 2019 06:38:49 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1KA-0003uG-Pw
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:38:48 +0000
Received: by mail-pl1-x643.google.com with SMTP id a14so4240381plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oifDLbXUZtnlnTlJhsIk8JZcFU1wGPND6UNf41reewM=;
 b=HvdeQ58/uJZBFpTG8gcQ3Ah18ThBTDw9fD+nNFT5E4ZOveL3M2428f/vyJBejnwuUL
 OHaivXbZdqMbzcxDOHfu8xBEwZTJ/+FlpSSwpKqNeZmOLxHdNS0U4Jz9wF+QYoUpPKKO
 o25dokBerX2RCWJyhEZAkiz4DsvIXa5URZTyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oifDLbXUZtnlnTlJhsIk8JZcFU1wGPND6UNf41reewM=;
 b=iHmH9jsf1EoN3PwtpqTvNIjVdvDIjwBIo5cKZGFGa0fDBQ7U1R9Ykkdmg1v8Eoz9wr
 u6Oeg+NS8EBFsyV4ht1ZIC69DKnUiMshPVyrZWxYgqpY9GOFMgAong7zRJpLnEcsAzyV
 rFS3m0344fLK+v1Wi0MAYKsdt/mL6DHDdwu7/unxXNpft2oc/zCi3fNTxb9MAMMaIO0a
 Xa9t20qp8aWmF7N+L+57YV/M0QHVzRoQEmHASX10hKv+tdlzezu71eEMKyBJwgNS+WrK
 D53f6Gpvz1DXFQsT3f5vreAlOc5ILKcwEvMakyVGm21dMWQIEEK5X96ouFPVDUVzJ6Tb
 upZQ==
X-Gm-Message-State: AJcUukeEHNVcU4NSIxLS3rfmYoq9VL/wOzjvROGFufDCmCI+LDkQQuXe
 1JmQiLQ56m1a+ZuJNTS1AKavfg==
X-Google-Smtp-Source: ALg8bN6KbkCqFrUoDklnyIHTgV8oZJz2xoLXS8H6iLgrPp+fr6e2Yl+Te7RqWdLT+6GGpVqltgNZtw==
X-Received: by 2002:a17:902:74cc:: with SMTP id
 f12mr13810855plt.134.1547707125704; 
 Wed, 16 Jan 2019 22:38:45 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 7sm1070676pfm.8.2019.01.16.22.38.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:38:45 -0800 (PST)
Date: Wed, 16 Jan 2019 22:38:04 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
Message-ID: <20190117063804.GJ25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_223846_837359_3B972D0E 
X-CRM114-Status: GOOD (  13.94  )
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
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com, heiko@sntech.de,
 mturquette@baylibre.com, will.deacon@arm.com, david.brown@linaro.org,
 linux-clk@vger.kernel.org, olof@lixom.net, jagan@amarulasolutions.com,
 andy.gross@linaro.org, sibis@codeaurora.org, devicetree@vger.kernel.org,
 arnd@arndb.de, niklas.cassel@linaro.org, robh+dt@kernel.org,
 horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, jorge.ramirez-ortiz@linaro.org,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 17 Dec 11:39 PST 2018, Stephen Boyd wrote:

> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:27)
> > The high frequency pll functionality is required to enable CPU
> > frequency scaling operation.
> > 
> > Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index 4594fea7..ec3f6c7 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -375,6 +375,15 @@
> >                         #mbox-cells = <1>;
> >                 };
> >  
> > +               apcs_hfpll: clock-controller@0b016000 {
> 
> Drop leading 0 on unit address please.
> 
> > +                       compatible = "qcom,hfpll";
> > +                       reg = <0x0b016000 0x30>;
> 
> Wow that is small!
> 

I double checked and it's actually 0x34, but the last register is
protected.

Regards,
Bjorn

> > +                       #clock-cells = <0>;
> > +                       clock-output-names = "apcs_hfpll";
> > +                       clocks = <&xo_board>;
> > +                       clock-names = "xo";
> > +               };
> > +

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
