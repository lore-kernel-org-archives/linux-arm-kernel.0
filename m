Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00C52086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mAydebFG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwjJnC/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00C52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cychPRLALjVK19itRZ4gVl/jdxkQF2hhRlV+I+Zbnu4=; b=mAydebFGaxAU1g
	d+x3qKA2bYf9WswBmJdbjtH4seAY2+0gTp7is3noNeHLyfIKX2xu0l8J4pcZzB0JUHMeKBFej5FO8
	AJsckt4Y2TxmBjZrruK+cQ5R5fN+yVWpDZtQbnTynr85yJ2LxBTAv339e/1uWb3dUuQeTbndXR19R
	FvvarateKmF+MisTG5dCLBFA5zn2Up5/YedafbRkdFh2tvJzj639J6aQwdVdH8pz6TEcgVCQ7emse
	9qNhv9yJ9nTyCtr3k2th6KrTXkZD275HOIKmwstsv4PDZN3H0X8IOlb6qMA3ehwGOdmF1Fl31jmOH
	eYgc8FQLyreE/DZtB5hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk188-0005qC-Cv; Thu, 17 Jan 2019 06:26:20 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk184-0005pN-R7
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:26:18 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so3966230pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=b6oO4hJkrokTcoyK5DzVWM2dwkV29FZtWLlVvwJwlU0=;
 b=WwjJnC/VD2ffmy1KuOcgUPjpS1m4sX2+Oe0ygvF+4Exsd86SYih8UqvNisckxbtqdX
 NuLgMv4GAZgL8Eoqtejn0cs3dggqLfLVfcx2q/C97QFua1OfNZF5rtHdwm+3lp/pLjHP
 f0AAydrkxqcVnVoqHNpOAgcSm4ErWbDD5kbj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=b6oO4hJkrokTcoyK5DzVWM2dwkV29FZtWLlVvwJwlU0=;
 b=ersasssbe7XN8rAlGnffdf/KsHZRbpmeDaiT33sLPYnsfFgnkFU3+qzJFoZVDN4ADo
 YweUUSj46ZVLDdWgUqnC2P8Bi2MezJrduoYwxAtgunf3BzhHKPCrKPitoaHhYOySKONX
 pKnvu8EnoufJRBr7/ZW74F4zoyALTqL+NewL0NkbTZbQ9YuKGqrANBGVRQTGfwP58/9E
 /so9WAipxDXKO5xDCwt8AkW6tKZnyePL0DkvLxn30vp2n+uylfInide4RLsc2/xbjkYP
 lqYurhMLJdRwGvCM/LNHVDkv5t5rNAB/GgfWUhZ7XVQ79BJANKjQKa/9NjoT1eEWMHvl
 TzDg==
X-Gm-Message-State: AJcUukfvfE0whmL55I1/y/mPLfnLymwoWPBiuVEMVs6WYjNznUjmKOXw
 Opw8LvB5faoQJIIS0YrvmJgDog==
X-Google-Smtp-Source: ALg8bN4o6v2C4wRkw9EJ8UWK1ReUBkRAibfXPLX+4mL7IPo64cLU1BMxGKk/QVkH+yqrBe6pkNbWCQ==
X-Received: by 2002:a63:7306:: with SMTP id o6mr12096593pgc.343.1547706372118; 
 Wed, 16 Jan 2019 22:26:12 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id d69sm1178833pfg.168.2019.01.16.22.26.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:26:11 -0800 (PST)
Date: Wed, 16 Jan 2019 22:25:31 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 02/13] mbox: qcom: add APCS child device for QCS404
Message-ID: <20190117062531.GA25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_222616_918749_905A38BC 
X-CRM114-Status: GOOD (  15.51  )
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

> There is clock controller functionality in the APCS hardware block of
> qcs404 devices similar to msm8916.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index aed23ac..dc8fdab1 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -97,16 +97,21 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
> -		apcs->clk = platform_device_register_data(&pdev->dev,
> -							  "qcom-apcs-msm8916-clk",
> -							  -1, NULL, 0);
> -		if (IS_ERR(apcs->clk))
> -			dev_err(&pdev->dev, "failed to register APCS clk\n");
> -	}
> -
>  	platform_set_drvdata(pdev, apcs);
>  
> +	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") ||
> +	    of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global"))
> +		goto register_clk;
> +
> +	return 0;
> +
> +register_clk:
> +	apcs->clk = platform_device_register_data(&pdev->dev,
> +						  "qcom-apcs-msm8916-clk",
> +						  -1, NULL, 0);
> +	if (IS_ERR(apcs->clk))
> +		dev_err(&pdev->dev, "failed to register APCS clk\n");
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
