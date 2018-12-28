Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:27:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F31A206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dkARG2jp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIgcdk8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F31A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CHb1fmncp8ATMRCIy0OjlIrME3vUHze9fEDti20fAUc=; b=dkARG2jpuJ19h7
	k3grr4B2O2A62Bej/CnKn9HJ8YLvlCWui2ctFSQnmktHcj208bq/ShTF8UEZEBwb5Vep/TCDcejK+
	AhWI5OIMC6dRv9D2H0WOQXI1qOoqjIWf5bZ9Zox8C/T8jPV7ieK+rHNnmtzKiqh3xfKP/97WIlq1f
	WecweqwTbEaDWMDnY3JelbBjYD8DjiFnLayKioW0d8ByZrxqFON775P+HAjo3Kp5FY2dFVsbOh+gm
	bUDaabogLc9rVfq/HUS2kr0ETxfWz/SCfcyOUH4unElVdU7r5Ov97RRLuvmnUln/FbnXbPa2LJTB3
	bLvQY2c/4+W5Zm4rTXpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0bL-0006du-Nh; Fri, 28 Dec 2018 22:27:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0bI-0006d0-7g
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 22:27:29 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EC461206C0;
 Fri, 28 Dec 2018 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546036036;
 bh=dyNMuDweaydd0HjxdrP8GOFlbrOFXiI/i9SdCW3y25E=;
 h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
 b=tIgcdk8jTBzT0g2OHv6ArERZ/KlOGQy46nTmDRsE/h8aX4Y56mtyU74KZFP9UkmC8
 49QDqTYjM8lRcoSSMpCGHtI163apIhGsvDvfcZ4fbtogv1DDlG5fveWsf/ZHPPzzsu
 x9QafgQjJqw+wwl1BisYn1En0MXhlQ4YDI0zZiSI=
MIME-Version: 1.0
To: Niklas Cassel <niklas.cassel@linaro.org>
Message-ID: <154603603502.179992.17724806534594632860@swboyd.mtv.corp.google.com>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181218143503.GA32562@centauri.ideon.se>
Date: Fri, 28 Dec 2018 14:27:15 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_142728_310320_09E1B047 
X-CRM114-Status: UNSURE (   9.69  )
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

Quoting Niklas Cassel (2018-12-18 06:35:03)
> 
> This is the existing DT nodes for msm8916:
> 
>                a53pll: clock@b016000 {
>                         compatible = "qcom,msm8916-a53pll";
>                         reg = <0xb016000 0x40>;
>                         #clock-cells = <0>;
>                 };
> 
>                 apcs: mailbox@b011000 {
>                         compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                         reg = <0xb011000 0x1000>;
>                         #mbox-cells = <1>;
>                         clocks = <&a53pll>;
>                         #clock-cells = <0>;
>                 };
> 
> 
> This is the (suggested) DT nodes for qcs404:
> 
>                 apcs_hfpll: clock-controller@0b016000 {
>                         compatible = "qcom,hfpll";
>                         reg = <0x0b016000 0x30>;
>                         #clock-cells = <0>;
>                         clock-output-names = "apcs_hfpll";
>                         clocks = <&xo_board>;
>                         clock-names = "xo";
>                 };
> 
>                 apcs_glb: mailbox@b011000 {
>                         compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>                         reg = <0x0b011000 0x1000>;
>                         #mbox-cells = <1>;
>                         clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
>                         clock-names = "aux", "pll";
>                         #clock-cells = <0>;
>                 };
> 
> qcs404 specifies two clocks, with an accompanied clock-name for each clock.
> 
> msm8916 specifies a single clock, without an accompanied clock-name.
> 
> It is possible to append clock-names = "pll" for the existing clock,
> as well as to define the aux clock in the apcs node in the msm8916 DT:
> clocks = <&gcc GPLL0_VOTE>;
> clock-names = "aux";
> 
> However, since the DT is treated as an ABI, the existing DT for msm8916 must
> still work, so I don't think that it is possible to ignore having backwards
> compability in the apcs clock driver.
> 

We typically allow one clk to match the NULL connection name, so I think
things should work if you clk_get(dev, NULL) on 8916 and then try the
specific "aux" and "pll" strings strings after that for updated DT. Not
sure if that helps you here though.

And I would push to try and make all the clk connections between clk
controller nodes specified now. It will be useful to avoid global string
lookups in the future, so the sooner the better.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
