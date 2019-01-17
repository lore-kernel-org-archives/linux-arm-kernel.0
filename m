Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7498EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:31:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3191520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R4ka7IXs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="TITJ/CQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3191520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I/c+/vI6e5NOjl6790GfGuperms/j/2L9uba/vHn9uk=; b=R4ka7IXsjgR33y
	wIjc5TcuumCJ1ATIXEAyAx7PTL1ZFRJVqmO49vOm2XJBicZ4h9xzwoPCYAhXrh9sb+YPKvmMp1n50
	fxwYqF9nH1h0L6n3YztHygSSF+vd+6cne901RBM4PWcyNi6LAEnFbsq6ymAnthfkoVGLm8zdFhP9E
	PZ0za6v/tVhdgQE9J60/tC895JQXaQMZJkQmbTowDAttnlRyKRxK0qtkMhb0ZW7t83ZvHcB7X7kd5
	qiTuWzTo8akugnPRMx1Py9t/d4/BSj0RYIJSNst2B89GdSEDfVsEK0QDl2SR6JAm5VYh4DUaj95dH
	5RFtIF0L4wGTHsveU+yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk419-0001Iq-89; Thu, 17 Jan 2019 09:31:19 +0000
Received: from onstation.org ([52.200.56.107])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk416-0001IV-RX
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:31:18 +0000
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net
 [98.239.145.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: masneyb)
 by onstation.org (Postfix) with ESMTPSA id 323C017F;
 Thu, 17 Jan 2019 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
 s=default; t=1547717474;
 bh=/QsjZEGIpt5Da8VNhfyvB/zWQZrnsZNtz4RzdivxsE0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TITJ/CQ1Cm33wAial7ZB4vJoqhQQZeWMMajczPw67zquYBrovugGtbR3x4FP7kLP3
 cO+v7b2AzlQ7EbLUu9D/X+BYV8YU3r+TUONpM2wAET2rv68D2hf3Gh/emUWdNGj0YU
 CDQ1VF7e5OeR2W6NyD6PolT3HHmCaHMbg4ei08ho=
Date: Thu, 17 Jan 2019 04:31:13 -0500
From: Brian Masney <masneyb@onstation.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117093113.GA23389@basecamp>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_013116_953241_E731D000 
X-CRM114-Status: GOOD (  10.16  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 02:45:55PM +0530, Sai Prakash Ranjan wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static int qcom_wdt_suspend(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int qcom_wdt_resume(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */

You can use the __maybe_unused attribute to remove the #ifdef:

static int __maybe_unused qcom_wdt_suspend(struct device *dev)

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
