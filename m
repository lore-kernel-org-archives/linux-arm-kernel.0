Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3166CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:39:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4EB206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cBvoPYkH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y2tgScXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4EB206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Xz1VDZTNMKXQaknxPiy1C23WYyraLJqWcNpL/yiDGE=; b=cBvoPYkHiaNovT
	Iyg3TBbNq9aEerx6yzWpKRuJsUvc3Mok6LdhGgBSYADkNQ0V4x8vZOynjkg88RVllHcC5Csmp8aAo
	Xl0Wk2guBXZwZUMX3uHhUTiDwExyCTZxejr58MyAFehPgEas1p6WWHvFMPgdxUMWIahNeN9doNivA
	YrXr6f7zyRns1nJ8uNf2tnA2rzOeHdMrzeWOuAE4+OQSdEbO1CQnU4c1Nzr222DYsWltXMxdqs0KC
	lSG/6yEbETvmU6L4bv4KCDsLoQx9WLp9hqTv/AqP5Ju7Toy6L9sX+rgRxysGMby0HIv03tEmg4IEQ
	aMLUhFxqroVDogsUmgFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYyje-0006xw-4q; Mon, 17 Dec 2018 19:39:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYyjb-0006wu-AO
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 19:39:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53F2E206A2;
 Mon, 17 Dec 2018 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545075552;
 bh=A4k7LNbfEQH1Cid16589iwNCBJ8lF84JWvNasE0gFMQ=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=y2tgScXUkNoymC6vkN2czyHr9bhB/Fk3EYeFEmIpBxBR/SB4fHug95sBU0GA6b3E3
 cPPmZGWS874ZUat2AMr6jZJQ00zLw0C2wyLbZoQM+BBLrar9MEtmiI92O24gaYJw4u
 RNnnnX4Q2s+//7EA39dpVjsyVwqUlCt+d8OCL/eM=
MIME-Version: 1.0
In-Reply-To: <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
To: andy.gross@linaro.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
 jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Mon, 17 Dec 2018 11:39:11 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_113923_374678_FAE2D62F 
X-CRM114-Status: GOOD (  10.00  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:27)
> The high frequency pll functionality is required to enable CPU
> frequency scaling operation.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 4594fea7..ec3f6c7 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -375,6 +375,15 @@
>                         #mbox-cells = <1>;
>                 };
>  
> +               apcs_hfpll: clock-controller@0b016000 {

Drop leading 0 on unit address please.

> +                       compatible = "qcom,hfpll";
> +                       reg = <0x0b016000 0x30>;

Wow that is small!

> +                       #clock-cells = <0>;
> +                       clock-output-names = "apcs_hfpll";
> +                       clocks = <&xo_board>;
> +                       clock-names = "xo";
> +               };
> +

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
