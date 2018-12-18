Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A31EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAEE21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HXvC5x09";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCH4B9Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAEE21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BzMn/guOshbUCkm2wIOA85HT9fhnrQ0ZINnBWIpTSPo=; b=HXvC5x09jPCiKT
	139LJhFg9K73K+f9iTZQKulZCZGOgeGexF9S89o8J5pVuBOBZO+sJifhxgJvzKQ+bJFMf+Pp++YnD
	9cJeCTyRCaNPz6s//BYmY3dEC/aasVxLwOlAveS7Q2bJ10hsMBTtHOKtGsWeaR7DHNC1uc5VuuVuT
	O63vxypVskdyI/EjGJJ0/SMEsKZ9xEtAdHkyUFS3nNseLHsmPDgDVKftTJbx/5wGyT6Hv/Z5/96K7
	dRLVLZP4sXW3BcMSUYAaMYHl+v9W4hVe6o1fWcoGTTXQvfNyESHcOv5KMRBMMGG8V0p9ieW8o2Edb
	HxgrqR9pnvzL0JATfY3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGSy-0003ao-3Q; Tue, 18 Dec 2018 14:35:24 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGSt-000346-Mo
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:35:21 +0000
Received: by mail-lf1-x143.google.com with SMTP id p86so12452212lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wjtDy5LCCPCxU08g/WY8ZETjRs/RcgYVHI8wzk4RLPc=;
 b=TCH4B9Sx8zA8ePT/xOySX0oG4gKueOSsJuNwS/1mw/4VdhisSdI7+EgmovbgAGqYZ/
 q8dsA+lbLP7/HlZa/EKut+PzX7YfV1le+RiJ/GGv2Oyo1h68cLYsYp7sZMFqeQnKLd2S
 lyxy+S6RAjO6kZiVH6Y9xuRkzg8zL4xRUt/8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wjtDy5LCCPCxU08g/WY8ZETjRs/RcgYVHI8wzk4RLPc=;
 b=lEwwtelPmWeLIO604R/TpUu9139SRbt49P7+UVCIYR3GfLuMDeWJ///t5TOFHXwgFb
 F7yIsUbVP+uupR+e5gRbmfAy1yrAwstvsXPBkeLP/T+Ul+VoXaT23ITVyz2e5STsd1hE
 U4mL1ZnEmViCsnq5yPnDAaw3LIjdeibjUS971ASqACjFLIgwB1xSDkx4cVV2X1VQ3Tu2
 dFWQSIVG2IwCGuWP7lpiVV+g8GqhnL4Y43yjjd/JX/d4VJD46quHpWYXh9/HhooF7Qw1
 Lw9iwM7UGV07UsTgRJuWWrs8O2tfRvbg3jAZ5K564j5A8dO52mmb/QTj+Pjr1uxsE9+r
 tdtA==
X-Gm-Message-State: AA+aEWY6IG4t3XcJZLtRjaAVrHj3fAlIVObcbWp+LweTluQqV7peCMmt
 ZWX+uDXXjrfU8D8kB0we7vsWSQ==
X-Google-Smtp-Source: AFSGD/U20A6CEFVSajvQAN+pviytKaYVlOmZX9yKcEB9j6OzbKJBo8x4a2G9O1BD33zRmMyUtSOS1A==
X-Received: by 2002:a19:9904:: with SMTP id b4mr9734560lfe.95.1545143706995;
 Tue, 18 Dec 2018 06:35:06 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id a62sm3284092lfa.37.2018.12.18.06.35.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 06:35:06 -0800 (PST)
Date: Tue, 18 Dec 2018 15:35:03 +0100
From: Niklas Cassel <niklas.cassel@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
Message-ID: <20181218143503.GA32562@centauri.ideon.se>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_063519_758912_450709D8 
X-CRM114-Status: GOOD (  13.67  )
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
 will.deacon@arm.com, bjorn.andersson@linaro.org, david.brown@linaro.org,
 linux-clk@vger.kernel.org, jassisinghbrar@gmail.com, sibis@codeaurora.org,
 andy.gross@linaro.org, jagan@amarulasolutions.com, devicetree@vger.kernel.org,
 arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, vkoul@kernel.org, enric.balletbo@collabora.com,
 jorge.ramirez-ortiz@linaro.org, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
> > Allow accessing the parent clock names required for the driver
> > operation by using the device tree node.
> > 
> > This permits extending the driver to other platforms without having to
> > modify its source code.
> > 
> > For backwards compatibility leave previous values as default.
> 
> Why do we need to maintain backwards compatibility? Isn't is required
> that the nodes have clocks properties?
> 

Hello Stephen,


This is the existing DT nodes for msm8916:

               a53pll: clock@b016000 {
                        compatible = "qcom,msm8916-a53pll";
                        reg = <0xb016000 0x40>;
                        #clock-cells = <0>;
                };

                apcs: mailbox@b011000 {
                        compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
                        reg = <0xb011000 0x1000>;
                        #mbox-cells = <1>;
                        clocks = <&a53pll>;
                        #clock-cells = <0>;
                };


This is the (suggested) DT nodes for qcs404:

                apcs_hfpll: clock-controller@0b016000 {
                        compatible = "qcom,hfpll";
                        reg = <0x0b016000 0x30>;
                        #clock-cells = <0>;
                        clock-output-names = "apcs_hfpll";
                        clocks = <&xo_board>;
                        clock-names = "xo";
                };

                apcs_glb: mailbox@b011000 {
                        compatible = "qcom,qcs404-apcs-apps-global", "syscon";
                        reg = <0x0b011000 0x1000>;
                        #mbox-cells = <1>;
                        clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
                        clock-names = "aux", "pll";
                        #clock-cells = <0>;
                };

qcs404 specifies two clocks, with an accompanied clock-name for each clock.

msm8916 specifies a single clock, without an accompanied clock-name.

It is possible to append clock-names = "pll" for the existing clock,
as well as to define the aux clock in the apcs node in the msm8916 DT:
clocks = <&gcc GPLL0_VOTE>;
clock-names = "aux";

However, since the DT is treated as an ABI, the existing DT for msm8916 must
still work, so I don't think that it is possible to ignore having backwards
compability in the apcs clock driver.


Kind regards,
Niklas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
