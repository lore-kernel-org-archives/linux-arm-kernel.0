Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B83218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gnovn/SI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBmpMe80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B83218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8qWHsRYME79P1vesVjhtmuHVt8rNt/y6Oe5VhRegCk4=; b=gnovn/SIHNPnDk
	HauutPx10+KdqPenkIynr0aoH8SmbCT4wmkHPy+z28Kl/yg8ahGbYJttUxhA68Snd5IIUPsT/EpMr
	SpjhF1cOmoHGtUpDhft0sz0XrElLalzjj4W9hJgtFOG+figh31YghevrqG/EL/6/qsNontO0PljAo
	pF7WH5dgd69EmBy734W4p+WCGxeiQfHPfRrcgg9QfhRrqkWCwJzBoyfVD7qe48uwwKgqrjIslviuW
	EtQF1KA3OC+DcuL14ARFUHBdDO5FZ2uVw2pWkb8YL8Sh31X7qgpJxQQAQ0GHxdXVm/S75JpWUgbtL
	VdOeTdsJ37Fhf+8kjTCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaGeM-0006Ks-6V; Fri, 21 Dec 2018 08:59:18 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaGdg-0005Vf-Tv
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 08:58:43 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so4021806ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 00:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NpCGsap+4OasCzXUyGm7/loSh1yI6KWWD28dFPZcU1Q=;
 b=LBmpMe80RCJiJJDepYii2pBc0VEzM6ng7JfMLmFU3TTBJaHPM5wMZ8kD0LHjUVmMol
 wT8K78U5Uh8/BXcAk39aqoPKPtoKIO0Gw/Vkyur6J3t+163dvth14GXdi8TxOqJk3zbA
 wjlePJ5ocZLPxHlleGwbXIxooa/lSlAFCAaXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NpCGsap+4OasCzXUyGm7/loSh1yI6KWWD28dFPZcU1Q=;
 b=ehTD993KTJ38KsQGJdWRMCr4iII6CNEOo8sZmbA/7KUNYtLyexotxc9UABPI6G5hj+
 bywMoHF+79epB1F136IVtwCl/JbhjtLhPq+WXKIV+xrXHf13XOOVbES0eE4nklP8oM8k
 Chd94qLfAflDREvWnCFMzR0OLjy0mBssvS2WJcQZht0fN2qk9WPjs/9On0xCtNPdVY54
 CZhyjX6C4OCEs17/eztCBQ7GUZc+TkXI1DqMu2nevsfNpaGMQMtEJOsdBno3+mMxefU+
 f8dMlfVMbSRGs/cXmxYpllzcCQEaeHWr6JTUFFJLzyajCwcQ9FG9Gxhitf0GA8GV/TJy
 mwnw==
X-Gm-Message-State: AJcUukd+fMgf+cpx10zWDQmmkRmQZjeSiAFl3DZ4eiT8b7Mps/O4sXnz
 290K+JZZZqRt3k/cHcTDO/IdDsZuH/yi4N4h8i3AUA==
X-Google-Smtp-Source: ALg8bN6eW/Hn2gIzMscu8uhKuxGFduqv3LK7G9172varKs1DhipCX/v6RKncqi+zuOdlqQZw/ZA9r/U0JjoRnCRnxlo=
X-Received: by 2002:a2e:449b:: with SMTP id b27-v6mr964640ljf.47.1545382704170; 
 Fri, 21 Dec 2018 00:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-7-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181219164827.20985-7-wsa+renesas@sang-engineering.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 21 Dec 2018 16:58:11 +0800
Message-ID: <CAMz4kuKSepzktF+ZUVsrxD-pAgRDiGUC_f0oLL2CTyBMz3tfoQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] i2c: sprd: don't use pdev as variable name for
 struct device *
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_005837_509673_7AE213A7 
X-CRM114-Status: GOOD (  14.84  )
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
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Chunyan Zhang <zhang.lyra@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-i2c@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

On Thu, 20 Dec 2018 at 00:48, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The pointer to a device is usually named 'dev'. These 'pdev' here look
> much like copy&paste errors. Fix them to avoid confusion.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for fixing the copy&paste errors.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/i2c/busses/i2c-sprd.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> index a94e724f51dc..e266d8a713d9 100644
> --- a/drivers/i2c/busses/i2c-sprd.c
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -586,40 +586,40 @@ static int sprd_i2c_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
> +static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>         i2c_dev->is_suspended = true;
>         i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>
> -       return pm_runtime_force_suspend(pdev);
> +       return pm_runtime_force_suspend(dev);
>  }
>
> -static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
> +static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>         i2c_dev->is_suspended = false;
>         i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>
> -       return pm_runtime_force_resume(pdev);
> +       return pm_runtime_force_resume(dev);
>  }
>
> -static int __maybe_unused sprd_i2c_runtime_suspend(struct device *pdev)
> +static int __maybe_unused sprd_i2c_runtime_suspend(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         clk_disable_unprepare(i2c_dev->clk);
>
>         return 0;
>  }
>
> -static int __maybe_unused sprd_i2c_runtime_resume(struct device *pdev)
> +static int __maybe_unused sprd_i2c_runtime_resume(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>         int ret;
>
>         ret = clk_prepare_enable(i2c_dev->clk);
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
