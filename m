Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BCFC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:37:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2927A20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M8YgZ9uA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XV5xvWcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2927A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1BtSKPX1azqfcm8L82io4LNFBB6lwzFcN3TRQk8k8CU=; b=M8YgZ9uASInWtK
	2aZzT52wzgq7m6R38iCTN8Qa0q6pedU3PJ8fyPWXAvEmERrHhvCLQSqhR1mv5nFzOnRjubxVgR0+q
	nZoG2PR4WbZPgZ5A3aIwoev5wM3rR4Wp9bVtfOnR72gE7GITQyxLOZakUaixhX57C5d427ZZEhIkP
	yrjMczXFHQH2x4PJsSRMXRwWjsRUgWgouBQFEdk7skdYr//xGbuWnL2tm+oVQUlvLtIPNun6kFq9k
	jcTvURCdF8i7jC8sImRsihcWr26TTz/fsUQAocXc2JuVp8+/0cF8cqC08C64J9UH8BfCLA/DsEUY8
	IlI9ZbmFbsX3oRr7xRJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1Io-0003cS-Iv; Thu, 17 Jan 2019 06:37:22 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1Il-0003bz-MS
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:37:20 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so3997344pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BRoWq6QA3qXs2sGySJTI8itioTQ0G12j79FEeArL7fQ=;
 b=XV5xvWcGUIX8XKEYjooW+BSHWzyZuau3H+TQByT5K3DnTUPMysFCzWcM9RL+OJUr8o
 0NlUm8C1TxouVDx52aKJu2u1W2dz8en6QFJp6hhXtydYiZxMLgMyr+uE4GCSaiI8Dlgu
 ovGyvY6g7B9csf+ZFIoL4fpAMpot6JqZVBaVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BRoWq6QA3qXs2sGySJTI8itioTQ0G12j79FEeArL7fQ=;
 b=Eabg7v9dt2erOpJ4XgUFgFaWK0HRlXDbD2h1YVZCXWZmGdMfJoz6L2xXrDwAUE33Ge
 4AMnPqinbx9of6YPNwsgsJIkcyWJVhpGCosdsjY0UWVj5qi62DGdNrvMBUsf51dEUCuG
 njWCiYqBMloNKsLIuIZ4bJNVJGSd8EKpmOHq7a/2R7NRHBKBHmdTsF822/JPF1HcO7Wm
 8EhSyRzDSD9NU2DxNZda6Mr69OTzs2GCVqls2y+oYG5tDn1uOhXVQNdDWElzxMHcxcbp
 WfTu5wm5SCKdVOMcbTBhnlCpYMe/6QBKdO9V+nfnp6UJ3iaes5nnxbAGECmHs7VOXhSV
 iAlA==
X-Gm-Message-State: AJcUukdt4UQRqUK2GtEfuTe6lV1ssTYgjkIEta6KrNOwdzKArGSvhWCA
 pZfq59oC6v2rUnr48bOyfPz+IQ==
X-Google-Smtp-Source: ALg8bN6YmqkH+B0NgtT3Hu83Xh8ALxL68xcPoX2x8QAgbHE6sowX540mNSC2NGyLDFrV7gI/0eZdkw==
X-Received: by 2002:a62:6143:: with SMTP id v64mr13729570pfb.142.1547707039115; 
 Wed, 16 Jan 2019 22:37:19 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id n21sm1072121pfg.84.2019.01.16.22.37.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:37:18 -0800 (PST)
Date: Wed, 16 Jan 2019 22:36:38 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 13/13] arm64: defconfig: Enable HFPLL
Message-ID: <20190117063638.GI25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_223719_732713_F842E4D4 
X-CRM114-Status: GOOD (  13.35  )
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

> The high frequency pll is required on compatible Qualcomm SoCs to
> support the CPU frequency scaling feature.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5c2b1f6..da390aa 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -615,6 +615,7 @@ CONFIG_MSM_MMCC_8996=y
>  CONFIG_MSM_GCC_8998=y
>  CONFIG_QCS_GCC_404=y
>  CONFIG_SDM_GCC_845=y
> +CONFIG_QCOM_HFPLL=y
>  CONFIG_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_QCOM=y
>  CONFIG_ARM_MHU=y
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
