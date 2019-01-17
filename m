Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF60C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:37:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAFC20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IWuEqFlw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5hxFv/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAFC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:To:References:
	In-Reply-To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5R9piQKiQxlQh03le+v1AQrdvk6/tOPoiFFifk8z2gs=; b=IWuEqFlwIUwocX
	ULX8ksIoJ+/MSktkrg4LJ/sc9fkuFvMJZhFxQjcpmdajvLwuy4X6uqLYPPnAg5HWxxVclk3bVmTd5
	S7y0WIm0HP3Id8ptVXFhCSyjwOnR5IcD5AxopmgKtlpJJfDx0654PfUT6erRB6/ENG5H+7/HMCKaR
	yoztqZSifOGiozjhkr9xb6Hxa7CRkTq0lxIWlzDgIfLkyYqSk+PeJmFWta+U5oD1BZdX8wUEYpw/o
	M8/9wNd38QKTLCfX2Vo5srgrVed2QOFN5bInL7U3j83IjkhukEFR56U1nluq1pyV8tK0JKE8AwYgb
	+uoSzh0zanJdElFSsohw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkCXR-0000Dy-Nu; Thu, 17 Jan 2019 18:37:13 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkCXO-0000Dc-Na
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 18:37:12 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so4822904pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:user-agent
 :in-reply-to:references:cc:to:message-id:from:date;
 bh=Iwme1IJBrOll4LMdbMEnsclPpzmiRPiz5uaby3aLiM0=;
 b=I5hxFv/jkLE38D/g2QLZ2U+muN4vWmD65O93e7B78rbFQl9RZjo5zcVxyLkJ9aicqe
 IqZ1k58mIJoPc/vQxLdBkSWpp2DfX0BJ4APP109iP0s/uuVm+EE4kckJGeLAg70uJHE/
 I4UPlaWJgJKAakQpeb31R7DoiTa+NETXnsrf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :user-agent:in-reply-to:references:cc:to:message-id:from:date;
 bh=Iwme1IJBrOll4LMdbMEnsclPpzmiRPiz5uaby3aLiM0=;
 b=rjnUYWa4S3o2LMvT1LhbxAlapMwB8Sr3pr/gBwmmWaXaglyW3gqy654plTALz3SVME
 DzkboqUwUPr+om6lpAQLxjwOTFGkLQnBCSYrjNvENNqKfcfgkIvvr2OeZxipzN17dokn
 ocghjAemHjVuyzKpmXGfgQ0L0U0bMncUkJmunRd5i4/+/qJZM0o6BobjAT78HTqYtzvO
 CCx7JMfDiwfh6mQiJ3WiT3BgZ9PV/vaXa5sxw31veDSMdomYgm9zry9poHC9S6IBwxJA
 GwGHGfVO8APjeP4oo79VFdSx0WZvPXYZxq80y1PvH5DRejXiamsWAzkbn/u5fnoMMhWU
 vzAA==
X-Gm-Message-State: AJcUukdRDa5V69n0eS484FdjVqM3XLwjI3ox0iLyCZAvgW34gaJlG9OM
 asAKn5Jruayv+YiyswslLIjnBw==
X-Google-Smtp-Source: ALg8bN5c6ip8oeTRd7auagE/kbJfwwUkROGSHholusOTakST1qYPB5Y9k5w0+61mgYGzxW0TbVGwCQ==
X-Received: by 2002:a63:8742:: with SMTP id i63mr14326263pge.298.1547750229112; 
 Thu, 17 Jan 2019 10:37:09 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id b2sm3216692pgg.87.2019.01.17.10.37.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 10:37:08 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
User-Agent: alot/0.8
In-Reply-To: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
To: Guenter Roeck <groeck@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org
Message-ID: <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 17 Jan 2019 10:37:07 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_103710_796199_A0CB594B 
X-CRM114-Status: GOOD (  13.09  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Sai Prakash Ranjan (2019-01-17 07:19:42)
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 780971318810..5dfd604477a4 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>         return 0;
>  }
>  
> +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> +{
> +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&wdt->wdd))
> +               qcom_wdt_stop(&wdt->wdd);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> +{
> +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&wdt->wdd))
> +               qcom_wdt_start(&wdt->wdd);
> +
> +       return 0;
> +}

This looks fairly generic. For example, the Mediatek driver also stops
and starts (but also pings after starting). Grepping for 'active' in
drivers/watchdog/ finds more examples. Could there be some functions in
watchdog core that do the common things like watchdog_stop() and
watchdog_start() and watchdog_start_and_ping()? Or maybe a bit can be
set during registration so that the 'struct class watchdog_class' can
get PM ops to stop and start on suspend/resume of the watchdog character
device?

Nothing is wrong with the patch, I'm just bemoaning the amount of code
duplication here.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
