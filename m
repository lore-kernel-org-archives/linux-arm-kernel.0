Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3958C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10C220856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gFqDgkPJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnHy+TY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10C220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5O/aOzikrMb8CPcC+8PHF5ES5uPI8sIu+5HEeszyOjs=; b=gFqDgkPJVRF7JV
	9eyt9/wXM1VVVNjTDgOVA5pbhEsn/9mFOyP9XhRfTi5oFIFPBpQ3VNsSM2o5Kzw3MCPH+KMRsqdyw
	oF0FKcmHgm27QNq32LqLHY707mL+nAB95xJDXVOoL+RUsKcac35sXqZa/KTQeTzlwEurIyoC7duA9
	elIARWe+JJxeuNzFpfTmFWmVQF8bu+dz4viYXYfzmbIXIvlJuxMfzAFDeYq5N7mn4mJqJdrSHC/a3
	L2r1bbDfAtKHBz/LDgrHaZXuGcVOeNB3nrSnLzNlppAINTvmWTqegcebZFLc2nzIbDQAiyVhkmfRk
	PYJsl9L8vSFuBvWbHXgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk18L-00063D-Op; Thu, 17 Jan 2019 06:26:33 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk18F-0005xK-Ax
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:26:30 +0000
Received: by mail-pf1-x444.google.com with SMTP id g62so4296810pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZcjbTI5xOS96dovzHOGssmsgn7mTRNgCB4K7GgUyByY=;
 b=MnHy+TY/VmeF9spGWlNq55ho73HCUz2OKKcfxan9stjPxB2sYV+SJipJqa1nfdO3hP
 CVbBNP7ePOats3cAlA1Cm24oHcC7huN6JKq14mnl4naZw6jWb3Qbj7pj7kMaEqztxpIX
 frYQJ6J4csGmo8UGWPzxu2eVnGJ9oKr/UrRlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZcjbTI5xOS96dovzHOGssmsgn7mTRNgCB4K7GgUyByY=;
 b=O0i3L+eMOoAO2P+o9ovafWEcv1cc8xm/Pxvie8emsH1ZXQLt/f5A1+SCeBxnq021eJ
 AG/ZXshECgyjUTZesbIlzQ8WuRvr/JjZRPManOQAHhT+ZvppFwCCuZ0LOzTsm+esP08K
 oqjzRdnr5DfJCUUJgHiQsWS0SGk7EimUgTYwStGUx/rtNcdaKR/ZXKngsIS0Pzz2eCkC
 FO5PLsX94Ao05AxsPbsZg43amzFh1jQulNKFR3seJMxv7/cfYuvuOQXA6+3Jd73061dk
 ukBLNUkJB+pyEtb/aympojl1w6jvmPexiXK2n6HhKRVrZQAi7nZ5YUJl5YQEtt8lbLqu
 VQsQ==
X-Gm-Message-State: AJcUukcc354iVcC75wB9x7Duc39mX9c7CLrUsN+sSAEBbYSz07nMq/IA
 0a3v2yCkECqCy8hmVYY/XwaQmA==
X-Google-Smtp-Source: ALg8bN5mrh3N/A4MxMIkKcRkj6aiVYA7i4NhIOmAk1S90S0Fhgs+/TbzRCntsH+zpd1QaOoSq9Q3eQ==
X-Received: by 2002:a63:d904:: with SMTP id r4mr12362368pgg.207.1547706386482; 
 Wed, 16 Jan 2019 22:26:26 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id i5sm997815pfg.34.2019.01.16.22.26.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:26:25 -0800 (PST)
Date: Wed, 16 Jan 2019 22:25:45 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 03/13] mbox: qcom: replace integer with valid macro
Message-ID: <20190117062545.GB25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_222628_086941_901722B9 
X-CRM114-Status: GOOD (  14.03  )
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

> Use the correct macro when registering the platform device.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index dc8fdab1..b782173 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -108,7 +108,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  register_clk:
>  	apcs->clk = platform_device_register_data(&pdev->dev,
>  						  "qcom-apcs-msm8916-clk",
> -						  -1, NULL, 0);
> +						  PLATFORM_DEVID_NONE, NULL, 0);
>  	if (IS_ERR(apcs->clk))
>  		dev_err(&pdev->dev, "failed to register APCS clk\n");
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
