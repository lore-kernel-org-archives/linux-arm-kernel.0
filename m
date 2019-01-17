Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A43C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8936C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xumy4HXn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpiYtpdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8936C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WaZYZsKhyEdiiucNPDphmeUfYd6KxHdF93onBmjeCso=; b=Xumy4HXn7xEd7c
	DYPU2cqZ1MwMItMKcF1bmNocekPOmzJOZQcyTpi1ktTwhgLrD5vl/McQV2GcgQpLKsiEdmY9EUpwJ
	VrrJr/BkLKKtPTf6SISYEZxFIv+N349mDzNugDxY9HCtdOJ7G2J/fYei0b7/z+F3GYIHkdaDiBBQL
	Qv2jimyksfeIkBOI/r7lpXxBaiQEerSoCMwWKquGifU004Cf3HXdghVFG/QzrbyEIU3Wqfg2JQQTA
	0brk4l7cxivzCOyXP1VnuFTKYqkOp+4sZlTgs0re1VzKXnbQocS04ewOc8v21F+FiSNi5hfssaMQ3
	1CByRgdHmEVgp7b6tv2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1HU-0002jy-EY; Thu, 17 Jan 2019 06:36:00 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1HR-0002jP-M2
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:35:58 +0000
Received: by mail-pg1-x542.google.com with SMTP id t13so3970571pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wbs8Sn8ytExy9GcJegv8BXzSqkcBBzLjSZ6gYSVwpUY=;
 b=GpiYtpdw2EhW3ny+UT8QysvfalFO5c+qiXX01XqVzDVv7Su3Q5sT+iSz4K0tykHmmW
 ymliFJJwtvGJpi7e7gwCJsJTF31chLgglDVvh4Pm1LEOKK5ZqD8XGHnrU4AOwd54uMlv
 ZopfU/eU6Q2nN8xfqRLZi6yg2hfXngJwHmbFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wbs8Sn8ytExy9GcJegv8BXzSqkcBBzLjSZ6gYSVwpUY=;
 b=uBBQb3p/kX/LMfIm2BFpjftQ7WlwtTT6208NcHwKIuMGAjtv0x3Zco9fUBTgAH6zzW
 DsTWt2OCphg9aAEexZr1bbJ8Z+lTK5yFKHv9Ruh7V+WjWMBlzxuI+r+0uM0Ep6QFl2ww
 SB7NcNZgm5CB6WkITtLVrOyzR0fKR5dC1lx5IBAf+H7c+wWwcc/PSiFggdKJ+k6mRVec
 0QZYmgTEbGEHuVAfU8RISsp5CVWpCtzUqGLqDEcv7abshJe5K6hcoO4XlkY1d6ANwHja
 vYDmNpIgv2Uk1sNQXciNZyNBwWfvaapJoOMtlCVUgi1oxNakHGBEPzat4XiH4gV8fsgI
 Cd0Q==
X-Gm-Message-State: AJcUukd+gDraRWHBjjh5qHAdjIaRtCrWpHoHHhDXKrEmOvigVH5kkdMH
 9B/nmd6oJjmhzv72YcqS5JI+OA==
X-Google-Smtp-Source: ALg8bN4J88WRw8ANAUjBM0r36g2M8yjSyWL3CjQpu/yKdg3fmjDuFqLtrgOeULRNPMxI2UUdxtCAiQ==
X-Received: by 2002:aa7:8758:: with SMTP id g24mr13494963pfo.250.1547706956811; 
 Wed, 16 Jan 2019 22:35:56 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id z62sm1058305pfl.33.2019.01.16.22.35.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:35:56 -0800 (PST)
Date: Wed, 16 Jan 2019 22:35:16 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 09/13] arm64: dts: qcom: qcs404: Add OPP table
Message-ID: <20190117063516.GF25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-10-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-10-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_223557_736518_501E835D 
X-CRM114-Status: GOOD (  13.05  )
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

> Add a CPU OPP table to qcs404
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 9b5c165..4594fea7 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -62,6 +62,21 @@
>  		};
>  	};
>  
> +	cpu_opp_table: cpu_opp_table {

Please don't use _ in the node name. (cpu_opp_table: cpu-opp-table)

Apart from that, this looks good

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-1094400000 {
> +			opp-hz = /bits/ 64 <1094400000>;
> +		};
> +		opp-1248000000 {
> +			opp-hz = /bits/ 64 <1248000000>;
> +		};
> +		opp-1401600000 {
> +			opp-hz = /bits/ 64 <1401600000>;
> +		};
> +	};
> +
>  	firmware {
>  		scm: scm {
>  			compatible = "qcom,scm-qcs404", "qcom,scm";
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
