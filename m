Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C30C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:53:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDD320663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tmrZ6rtW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFW7WsSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDD320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JW5axpT0Qh6RZHoHDYMIx1FElJQW9U3YfSk3yDoEQ9M=; b=tmrZ6rtWIyIihD
	lCg6dKfMdHRCVic80LyR4Ky+uq4Jd8ioUmmoGs4v52NxGvHrNne4Ccppl+tnl1EIiMf5rWypcPRS0
	hrVvXejGLyOKu8Bm0jbonWc8ZKm0jI110PRG3aJ35bHYoB3BhTDBIWOxtyVcbjjlWLvTXjElnmTXw
	YqgVeF4seaMXhLibgNvRe/XEC4znX9DT0WUMJ9TCjEocczLIQyOVK6DSfp81A1M1BFO6D9TnEX6Fn
	4WKjMP14jGTkCNlV8kIlBQ9mkP0rKVM+TdMkpUze9eUUxe5X7u5HGMlunTUHTRv0HfSbwMuplr1Bq
	6j2NK8j/kGPotyLmjvPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giw7g-00040m-7q; Mon, 14 Jan 2019 06:53:24 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giw7c-00040N-Fm; Mon, 14 Jan 2019 06:53:22 +0000
Received: by mail-pl1-x644.google.com with SMTP id b5so9702917plr.4;
 Sun, 13 Jan 2019 22:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OFNsRig2am7lFZljbzB4OQRSTLw+lwJncAXZ7wH2QME=;
 b=tFW7WsSbMHkBDVg72BG6cbW3JaSbKdbqd2KC5qlF4AlcoR3v9A14ANxwI/H8IAOzrs
 bFeqqwWOdMh9cjQIhePgxQsFisZhSQ9+UKhwQa/mzyqQZNeWa54hJYjQ3ppgXkdSh0eg
 E3x4e+MjSEe/GuY4if4zWzRED/eam+xLW/Cknnl/9mZA/xRGJ6AtY/cJYPp6OyF6ZrhR
 Db3bSlQ3tPnHi1a/cbwboshv8otGk6In9wo2KzqHnEk9hYAsTFFHn/+tu8QfJwXxxLR5
 LVIzF0a8eWvEpnQMMwiiLmnLjJapiUwmiCx0TMmJyrp/5KYLfIVRiw+4xuIQdx63WNrF
 m/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OFNsRig2am7lFZljbzB4OQRSTLw+lwJncAXZ7wH2QME=;
 b=ZGrwvvX+kENiSqevSZjzJTootYgWARVH+7kQFge4re3bsE4DwpWbJws6TG6EQXu+Lx
 PgYNsUiCZBXHwsfXkz/KKnJs3IK2r8R3rcMIwFZ35hTVFMjSycL1JENAqqFuoZCAViDL
 3ILtQFx/Bn1to8155H6kQhTD4x9eEvs+Tg6TNFEV2Zeqx4CfBQvqsDSLlEVHBKSqYbLs
 I7GO4ZnxFyxCmD4qV94f7gnuYNisQtFuTUVmos1GJmrkoPWTMxUqcgyWboEcIs64i9Q4
 u/VCFj57ZLf4Pu+eR1qs2j9VujMcr7xtuk+vvI2G4FfLgD8uAMt9iAD+4tgWG3SBqDOB
 BG9w==
X-Gm-Message-State: AJcUukdlyb5PvAUbOfXWWfaGcyhw7YIXoWXCEvK4fkzo2AUOQwojHgvQ
 l9kQ3h1r/dfSVJbWne61cukhEeyI
X-Google-Smtp-Source: ALg8bN4RDS/NrOJq5YBQRDT2XscM21PAxKDZH2/Uq6bQ9Jg1G/7X2OigZgDU/M2nbVc2Z1tRsVxP4Q==
X-Received: by 2002:a17:902:9045:: with SMTP id
 w5mr23213733plz.32.1547448798667; 
 Sun, 13 Jan 2019 22:53:18 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id 202sm154626308pfy.87.2019.01.13.22.53.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Jan 2019 22:53:17 -0800 (PST)
Date: Sun, 13 Jan 2019 22:53:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: Re: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
Message-ID: <20190114065316.GC217283@dtor-ws>
References: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_225320_542250_A078A02C 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, jrdr.linux@gmail.com,
 linux-input@vger.kernel.org, matthias.bgg@gmail.com, chen.zhong@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 05, 2019 at 10:39:07AM +0530, Brajeswar Ghosh wrote:
> Remove linux/kernel.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1749fc..5027ebb7b4e8 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -19,7 +19,6 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> -- 
> 2.17.1
> 

-- 
Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
