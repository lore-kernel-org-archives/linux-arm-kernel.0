Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:44:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF4F20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NSzqeypl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoLHtbyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF4F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I6Ii0d9+Bt0Rym4NYkasNOSiJI1b0rDCPA5Jo4stepA=; b=NSzqeypldun2HY
	CIjOYQIPt8FADWeQbe/vLHn4eLA3I6avbTd76H195Bc9IWHwmFkjPB0UOzw9y66vOWavCUXqeNQNP
	SzfpAzHhmPXNWrDQsUCNhqa4aJ/NJdu/RitZW0LBr+k8mnZkPTE3VaOW7oTPSKNJQixSbSQkyQNmY
	0+6dRMurLtO1DH4feqxdt4hkN5I3xmi1FfZRvq1wLbl1S5+7zYinBHaDGpUCUXfBQru7zDZD8V56k
	yWtypQnT8AIQBYrslJT0t26oeP4ljWbOzx1U3mYqR+I92qK9Nv8NSOipIzjRhYfOaYwNcRLmwUIum
	LzfqKSEQd04siH2VUGwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1Q9-00076p-61; Thu, 17 Jan 2019 06:44:57 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1Q5-00075l-Ka
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:44:55 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so3973583pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=atLgXCZJmtT0O+GD3SkLBWNlve906gHwrgA3+iQTNq8=;
 b=FoLHtbyD+T0hvK+Xsp8pX/kYm+I/+k4QezqwPy4hZEZOawY2bnAnmlg4Lqho8lfRFC
 Pe+kTdIIXJOQiqLOuMj2BNQwVtPcMeN9yRHNlK3tuyW9GRfX/qzmxsKxAR+caOljDVnx
 7oIH1rzzHgC/Mst7cn6AwQQOxI6ERIWzCV4G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=atLgXCZJmtT0O+GD3SkLBWNlve906gHwrgA3+iQTNq8=;
 b=Uk4QnMYcbDvsvykwnRULBXuQ25KTi3WE2xYQZjkq8zp0Ux7IHFUfAFvr7mUX0H2urD
 Q8gZr8B/kXjCg0NfJ+Judkkimk/1lD+YECsLrFBloCguhL2SgxvFW7gfoi6e1ezXJ4dV
 SkfO2YEy4J7Pfq+GuLv9lnezK9jfaDMqgstMbYk7kQEOXwD+Y3EzTcO2ZvIMnjOA7bNh
 V8Kfmkw+MpTqnXdRGdst502w6KVSiDMSS/TqwHs+xZTu5g8N+YbDuSpe88bxEsNmiV50
 nFL5T/TtMFoe2jUi/PngxCfg7u1T5/lo00+Dr4WimAjOctKv4gosPvRaNBoBohbYMt09
 G7GQ==
X-Gm-Message-State: AJcUukcSgl5ujTGsxVzPkjgMEGaYzaoKEp+uHS0NLhhoDk2G+AvHcwB0
 PvPKGbxFxZ7a/A15K8s2auc1nQ==
X-Google-Smtp-Source: ALg8bN62G0/QBaoJRR1ApqR8rAiY5+uOY2xmB/Wpjp2VNGDP8FZVdyPWnrnDVFMusI5C+iaXRq/f4Q==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr13782534pfv.82.1547707492463; 
 Wed, 16 Jan 2019 22:44:52 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id v190sm977708pfv.26.2019.01.16.22.44.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:44:51 -0800 (PST)
Date: Wed, 16 Jan 2019 22:44:11 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 04/13] dt-bindings: mailbox: qcom: Add clock-name
 optional property
Message-ID: <20190117064411.GK25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_224453_687103_E3A283BA 
X-CRM114-Status: GOOD (  20.40  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, david.brown@linaro.org, linux-clk@vger.kernel.org,
 jassisinghbrar@gmail.com, jagan@amarulasolutions.com, andy.gross@linaro.org,
 sibis@codeaurora.org, devicetree@vger.kernel.org, arnd@arndb.de,
 niklas.cassel@linaro.org, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> When the APCS clock is registered (platform dependent), it retrieves
> its parent names from hardcoded values in the driver.
> 
> The following commit allows the DT node to provide such clock names to
> the platform data based clock driver therefore avoiding having to
> explicitly embed those names in the clock driver source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/mailbox/qcom,apcs-kpss-global.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> index 1232fc9..f252439 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> @@ -23,6 +23,10 @@ platforms.
>  	Value type: <phandle>
>  	Definition: phandle to the input PLL, which feeds the APCS mux/divider
>  
> +       Usage: required if #clock-names property is present
> +       Value type: <phandle array>
> +	Definition: phandles to the two parent clocks of the clock driver.

I presume you meant to replace the existing definition of "clocks"?

I think the purpose of "required if #clock-cells" comes from that
meaning that it represents a clock-controller if #clock-cells is
specified, in which case it requires the upstream clock(s).

Regards,
Bjorn

> +
>  - #mbox-cells:
>  	Usage: required
>  	Value type: <u32>
> @@ -33,6 +37,12 @@ platforms.
>  	Value type: <u32>
>  	Definition: as described in clock.txt, must be 0
>  
> +- clock-names:
> +	Usage: required if the platform data based clock driver needs to
> +	retrieve the parent clock names from device tree.
> +	This will requires two mandatory clocks to be defined.
> +	Value type: <string-array>
> +	Definition: must be "aux" and "pll"
>  
>  = EXAMPLE
>  The following example describes the APCS HMSS found in MSM8996 and part of the
> @@ -65,3 +75,14 @@ Below is another example of the APCS binding on MSM8916 platforms:
>  		clocks = <&a53pll>;
>  		#clock-cells = <0>;
>  	};
> +
> +Below is another example of the APCS binding on QCS404 platforms:
> +
> +	apcs_glb: mailbox@b011000 {
> +		compatible = "qcom,qcs404-apcs-apps-global", "syscon";
> +		reg = <0x0b011000 0x1000>;
> +		#mbox-cells = <1>;
> +		clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
> +		clock-names = "aux", "pll";
> +		#clock-cells = <0>;
> +	};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
