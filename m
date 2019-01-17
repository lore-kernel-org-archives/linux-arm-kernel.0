Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC33C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E41020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P963o67E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFx/29Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E41020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Kt2EAQ/afynNoRHTMqH0ZISjDru6kBuVf5AtOo87zI=; b=P963o67EsWcBRs
	8jJDzPpaPc8qLMY5kQXacZC46Ln3i1q68BsSno13vul222NjKI09cZjZQ5eQ7tsYPha2oTrHJ3Ti+
	iU9BMCP/6OiQW6oK5wrsOPTGrnySXlRwvbLPT+X2TJxWDjAdl4zW2EYiwBwbLA+APX+oMGruKFJQi
	zKVUMZ+rZWNB2R+/kGaWoEfJ3Bn8d8rbXdJzLaOIq3Gi7L10SCQaeIGQfg+eynPKn7eWluZ/spH9p
	4dkTlM0s+R7SPQfO6gXQZ2GvMre//MWa67+C7GCRTvaghTDIw+TCRCXDaFVfHmnMedjgNqISnh5T6
	f6oIW2jtvcT1QmntqVzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1IF-0003LG-NH; Thu, 17 Jan 2019 06:36:47 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1IC-0003K3-B9
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:36:46 +0000
Received: by mail-pg1-x543.google.com with SMTP id t13so3971502pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vxQkdMjTikHdV+D01KGNE2ZNqnn8VM0XG4t7jDYHpmE=;
 b=TFx/29Ie+5knQFudhi+WqwXV24nkiYswHFAKpKYV0VkehePeXz/neJgm9QNjOu5P2V
 6oYDYjB9c0i9Hm5SDWyOCLBrMRSAm3on6eVIjfzXSButwLm8Fir/LrLsrhj4oUk5xBtQ
 jUN2L782MCldVNIBX0QZup13nN9maF33PeSyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vxQkdMjTikHdV+D01KGNE2ZNqnn8VM0XG4t7jDYHpmE=;
 b=fvy7WsTG9ejMMeKylSbsWz5+KVmUux21nc4Aj/unDn7yk/xxYbbmad9y5IJpG0lwTX
 GejiXKyNp7XXgxgvj8IaCTmMwm1hrMm5d+LFun5knVb2G1JcqgeGg9Wmu7+x+LOjiLCr
 W9pnPVPwsNGcxp8RUxiyfkL8CbLKS2NImI7JdqWMGyBbSvCKrsPttq+CWS2lqftdm7IF
 wOTAZTbJQUKQalhH/PusD9rh+rSkZSAJG9X5SBLaio8T5f1BP2HWWYtjzrWK1szRxUSk
 Jdvv3dCY3ceRhXPc4y6vl+KNfhtI3oa106X7OYKsPpMOx5+QMO48tbw0CEFYfFl8AFJ8
 RHvg==
X-Gm-Message-State: AJcUukdOKe9aDSzvFp2Ru2ENpt/XaZiKd92pzMC0frC8gujRYguk0dCY
 sws9J0tJSR3Np4kwUjB4ih3eOQ==
X-Google-Smtp-Source: ALg8bN7lRBsL54kfBxvrKwmQG6g1r5xezKcKdsu+5mmNQDe+0CGMtHhf2p3BAH6wcOHC19lpIIH8sw==
X-Received: by 2002:a62:1212:: with SMTP id a18mr14112211pfj.217.1547707003688; 
 Wed, 16 Jan 2019 22:36:43 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id d13sm1378590pfd.58.2019.01.16.22.36.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:36:43 -0800 (PST)
Date: Wed, 16 Jan 2019 22:36:03 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 12/13] arm64: dts: qcom: qcs404: Add cpufreq support
Message-ID: <20190117063603.GH25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-13-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-13-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_223644_383006_FE6C63A3 
X-CRM114-Status: GOOD (  12.67  )
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

> Support CPU frequency scaling on qcs404.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 2d9e70e..5a14887 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -30,6 +30,8 @@
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU1: cpu@101 {
> @@ -38,6 +40,8 @@
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU2: cpu@102 {
> @@ -46,6 +50,8 @@
>  			reg = <0x102>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU3: cpu@103 {
> @@ -54,6 +60,8 @@
>  			reg = <0x103>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		L2_0: l2-cache {
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
