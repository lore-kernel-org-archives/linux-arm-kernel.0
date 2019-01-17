Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1337AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11BF20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OxCDyBXu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+9D966g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11BF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DaugU+1zJtJPXgLkFFwGX4+HHa6R2f+hTvchf0X09AA=; b=OxCDyBXuEC8qrj
	fNu+/iD1nW8+4BLKWEoRxmy1lfhfAWReGOmFG4XyelSDtgTxhIG36//gYCnk4jAs1cX2yhHA3Uv5m
	aK1hd4PfnFf4LUN3z0AxBVnIefmzzPw31LHvJMW+qTvnDd7dmhezeQDCttqjmoOorPZcvJYI0n+5n
	1Sa+ays69MKGqDI+5W+Vf95tFSNxNPnCSSIjDqPjoVgcu9dQbBHR4ticc7Ya7hl73kQlJcoVNL4ye
	Qn1Gwl9KWCX+OvmMdYyRro4nBFEy+almypRhxUYDXmMwEF/MdkhIUVyWZR5Rmlh8eTQqlTzVSuvB+
	JAnoJmkmXAo81MCSTx0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1Hu-00035C-Le; Thu, 17 Jan 2019 06:36:26 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1Hp-000339-0G
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:36:23 +0000
Received: by mail-pl1-x641.google.com with SMTP id 101so4252011pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yAWRTL93sTtOSi98RyIBxtIVWCPcSUjGWoSe6meVdDI=;
 b=T+9D966gZpfgzNwQNyqSaCvw01s/kVIXKpNUzfNHfR8qSJIzS91Hy9MvkuJsnF18ue
 r1Q5Pzp1vqu9izPX2H2tDX8uJfGP/zBFbfA/zhxBvkmBp1AzGFXXvqsvlgo/ZKsc/+Zq
 /KlWzwuEgg/Ch8HKonld7Fw8M9nka9zQAVcRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yAWRTL93sTtOSi98RyIBxtIVWCPcSUjGWoSe6meVdDI=;
 b=PEGCscQpJNEGgiAdhwyyiA98AzpXmvCROV/fxw7hxwnVjHKdxUak6kIHB8jnNJkXRS
 T7sC/DHvb9YLxkw+lzj5cCLfdnRWngdIDyFurcJys1X51UbcJmE9Po+iPZ4raJbflAtH
 WoAwbXJejQR3QkzBLOXev/ecF6vFVb5tvHXZBYUvwCjJcRPcNhUBx56hevP/CG9iTds6
 tm2vAj/LUY/Edgle6PpRNUqvjygg97X5XhK731GzB6PGpR0oGT05BEd0DOWU8P9C1rOz
 dUqdcZ6jCd6Z6m/3jiaM5NPSS1in+pN+GYNkojVAdrUE77vxgr0vkDHrZFRqWsK9kgyZ
 JCZA==
X-Gm-Message-State: AJcUukdFTxFNwjZAXpFvGlTh/Zg6fPlcG4SdGWzD+V+P+PpSGHbEBjyI
 JbkCzbg4mBBuJOdlpx7ZiQRPUg==
X-Google-Smtp-Source: ALg8bN5fwty0cHZKQCSE+Eb39PJyhTu5iku1Ogv+ANeAJr0F3suynCKts6levZ96WHZ+Q82nucT0nw==
X-Received: by 2002:a17:902:468:: with SMTP id 95mr13619788ple.3.1547706980368; 
 Wed, 16 Jan 2019 22:36:20 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id r130sm1637143pfr.48.2019.01.16.22.36.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:36:19 -0800 (PST)
Date: Wed, 16 Jan 2019 22:35:39 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 11/13] arm64: dts: qcom: qcs404: Add the clocks for APCS
 mux/divider
Message-ID: <20190117063539.GG25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_223621_193764_573C85AD 
X-CRM114-Status: GOOD (  14.30  )
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

> Specify the clocks that feed the APCS mux/divider instead of using
> default hardcoded values in the source code.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index ec3f6c7..2d9e70e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -373,6 +373,9 @@
>  			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>  			reg = <0x0b011000 0x1000>;
>  			#mbox-cells = <1>;
> +			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
> +			clock-names = "aux", "pll";
> +			#clock-cells = <0>;
>  		};
>  
>  		apcs_hfpll: clock-controller@0b016000 {
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
