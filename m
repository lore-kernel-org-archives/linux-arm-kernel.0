Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:09:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F61205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sI9AMszU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEocUHsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F61205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G9RciW1ZiQry+h7YrgcVSmOttMOrd7HMnZ1ZZvNUrfU=; b=sI9AMszUtjpy35
	tp+JBqmyZrtjccuFHTdsnvxNKw+vc6RlJQvlXT/Z/IHhlN1BwHDVKyNOyxFKbvDHHoMkgsniIw8tE
	BBu3zDd4n4UkfBfZUZMuJGaEotoGwKwhWdKeehDsUrsqQxSwhT3A4ucPI0JRRuvkVd/4zYrPxNalu
	nQ/FgHrCriQSTPQALw5jdQMM30bwJMTnXgVB3bUOBYYF5MP5+MOlDv68MUNlxi9ogjZUnO+QjO51l
	zN9rcPKlONcm2ZfhK4Gwm/r+KWC0Sey7SoOtzdPMkouR2G0frb3RcNO+LxhKtLROW8v21bJz5/dEZ
	DD7SqvHuYC+bqLjsq75g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFGD-0002ae-P7; Fri, 22 Feb 2019 18:09:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFGA-0002aI-Rs
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:09:20 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48D63205C9;
 Fri, 22 Feb 2019 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550858958;
 bh=UupqhbqdFjKgKSI02MJoN0XI6eO4sJ++1hYERxTqud0=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=rEocUHsffCvK3PcLGoZGGv2zw0rJyuIkofLLfTStqhWtSS09sJjA5Z3wYHoGwQQxF
 UouGjx9OCvjRhY3Ups6GbOiBJN8O5uBvzbgYTCZcFVXNRevEBwUY3GvkblRvdQSS0D
 FIYwknpf1TD1PWKyctCp9jyeycNtWF4qlYnzi8yw=
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/14] mbox: qcom: add APCS child device for QCS404
Message-ID: <155085895764.77512.15118138971189768976@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
 david.brown@linaro.org, enric.balletbo@collabora.com, heiko@sntech.de,
 horms+renesas@verge.net.au, jagan@amarulasolutions.com,
 jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
 mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
 sibis@codeaurora.org, will.deacon@arm.com
Date: Fri, 22 Feb 2019 10:09:17 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100918_920393_858C6EC2 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:49)
> There is clock controller functionality in the APCS hardware block of
> qcs404 devices similar to msm8916.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 3cf2937..0d64aa5 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -97,16 +97,21 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>  
> -       if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
> -               apcs->clk = platform_device_register_data(&pdev->dev,
> -                                                         "qcom-apcs-msm8916-clk",
> -                                                         -1, NULL, 0);
> -               if (IS_ERR(apcs->clk))
> -                       dev_err(&pdev->dev, "failed to register APCS clk\n");
> -       }
> -
>         platform_set_drvdata(pdev, apcs);
>  
> +       if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") ||
> +           of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global"))
> +               goto register_clk;

This goto is weird style, but I'm not the maintainer here. Maybe just do
an if condition with the body of the if inside like normally is done and
suffer the indenting pain?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
