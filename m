Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB40C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0EE20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pH6Y8OJr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIZMFkVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0EE20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7G2fq+Lr9q3uDCFMS71mFvWQ8vNwdmQEXVhYdC44hUg=; b=pH6Y8OJrX5Y7UC
	UlHEtXJNpZzIwwxkOBGWWGtlumsClQko4EE+A+Eldp+0pXJ1dKm+jT08G3RIF97eZawornEFUtkcv
	9MNNwKKauJuF/OayKpxBsNeIC+O5Nwds7rbcJF3O4EPn/Rsk/CKj9qySeeETYeoiY7BjsL2fqITQf
	n0pFwtcn15+9yY1q+cuLNVhJSQLThjhd7AvwlzjWz/C6anHK5S93LCyBtj6OtljWfKWJWLGZg/7vN
	XoVyadR/4OIaEUw6LuWXjl6C5gjcKTAMXlVrchLxmBCX5dccDvesG/4vn2qJB2wURq6QYGEFtq6rB
	pyBqcTrYjNyeq6Yosbkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkCD3-0003gF-Mr; Thu, 17 Jan 2019 18:16:09 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkCD1-0003ft-1I
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 18:16:08 +0000
Received: by mail-pl1-x642.google.com with SMTP id a14so5081092plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=C2Z4QWy5wNJw+5XfdnScGboqm8ucQNIbMLIloYyNmGs=;
 b=TIZMFkVVr50pLywqY+9ZmLTAPt1srFAEqLNU42/hQaulTSrqjj0pfJdkcXYADAlW4U
 VF1StksTRnrLRVvo27iasEhRcp+QRIoMn8KtgvYVTPCyI4xv+1R8h4C6Q6KDHOGofdou
 A/sNqGgs/oheekTNdaCg34W9CoAqOzGivZsZLbDflH8BI/8TYKXNvr4YVULYUOoANJBC
 F5lgTrJVlpQ4/mVAUhv8RYuf/e558bNZr3xDaH7zbGQZXm3vQfuzn8JOUbHJ1GfdCaLc
 1y/4qqMSvxbPxXiFGdJGV3aueip1Eg/TfgKuNnEi9eXbR34qPiO0dkHMkRJbEUJloAtT
 YvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=C2Z4QWy5wNJw+5XfdnScGboqm8ucQNIbMLIloYyNmGs=;
 b=mho4Iht8CDR7Xsaslcv8K1RgrdMo2M1p0AINFZ0aQrxeuyfreaQIzu7mbBS4VZ90S2
 uo+coZXv7ORyHJB8riTbTTNmYWZRQiEuscvRpyM/mOSkUlZMwhk/UR+/iuldQEMxvKjZ
 ZT998VNwHGeY5BqQjd5CKj26EdqY0y52WhIt1LZxOQDkXrN0URa4QUo9aAHVzEtrvgds
 LmYPnt+e8wz0412fRy+d9D/UHOmf6hGQ1zwRW/asdk//TaFvybx+GVxx+fxOlSpEKRTT
 16MkQg1avMUU8OZnFcAsuIG0wHs7P+s8um5B5sFZ7wcPouvr4jD4bjKBVYUxuCv1IqAE
 Z97g==
X-Gm-Message-State: AJcUukc1qaD9AJtXNnkfuHFIp+fVPcLuRBaPhEwuNuwzsUQGwSV4sWQ+
 ljpMVGgJICCfACl/3ObR8sQ=
X-Google-Smtp-Source: ALg8bN5rtvdvpSZL7vF3ibwgosO2reRsvgoAjNIN0+T/5vvJSnab7IbNYCwaxd0YjXte0uEmGBdhYQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id
 j37mr15399309plb.226.1547748966386; 
 Thu, 17 Jan 2019 10:16:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id s190sm3275776pfb.103.2019.01.17.10.16.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 10:16:05 -0800 (PST)
Date: Thu, 17 Jan 2019 10:16:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117181603.GA14800@roeck-us.net>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_101607_108317_6E3A59B3 
X-CRM114-Status: GOOD (  17.98  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Guenter Roeck <groeck@chromium.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 08:49:42PM +0530, Sai Prakash Ranjan wrote:
> This adds the support for qcom watchdog suspend and resume
> when entering and exiting deep sleep states. Otherwise
> having watchdog active after suspend would result in unwanted
> crashes/resets if resume happens after a long time.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> v2:
>  * Use __maybe_unused instead of #ifdef as suggested by
>    Brian and Guenter
> ---
>  drivers/watchdog/qcom-wdt.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 780971318810..5dfd604477a4 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(qcom_wdt_pm_ops, qcom_wdt_suspend, qcom_wdt_resume);
> +
>  static const struct of_device_id qcom_wdt_of_table[] = {
>  	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
>  	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
> @@ -259,6 +281,7 @@ static struct platform_driver qcom_watchdog_driver = {
>  	.driver	= {
>  		.name		= KBUILD_MODNAME,
>  		.of_match_table	= qcom_wdt_of_table,
> +		.pm		= &qcom_wdt_pm_ops,
>  	},
>  };
>  module_platform_driver(qcom_watchdog_driver);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
