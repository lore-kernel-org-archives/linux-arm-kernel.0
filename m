Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0D4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:29:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA47217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pX/CF6i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA47217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y3SvXYX8j3nDcz1t7504KfEmMTguxdoYMpLep/Tz7vI=; b=pX/CF6i+ae2akx
	Lqr8Uz2ntI3vVPh6X1HEvz3hitrWyd3KXBuBRfdUqv7Zd5kHLG3nJwbLaDbR1GnJ5ebKBgAUkuJd3
	1NcvNYdF8RsJO8dKUHxAPOP/66NTvOl/TrCr8orPlSofECrj++KoLZNt2wBbyr5ii0XWjTyum68EN
	YpZdvK98qUsZDQm3ufisqEUmLls72Acb32x8hcNQWkMf8eDl8Ju2qcewF83bnsnmM5s7YVqHpF6V4
	0HmP23MAKzXKI1JYIe59YhYq+2woEWQF0WHr+wLa5DqynStNXGrkYyywikEArRkgMfIqGVCDXH6E9
	F7XJAZ8wrTjzxah8ZcNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd1Yx-0008Cy-OF; Fri, 28 Dec 2018 23:29:07 +0000
Received: from mail-it1-f195.google.com ([209.85.166.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd1Ye-0007m2-Sb
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 23:28:53 +0000
Received: by mail-it1-f195.google.com with SMTP id a6so28631708itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 15:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=B+q5cBhenX/MUhmNbOXQRZZHpEhq7nKxlrbk+evkSeI=;
 b=leJGqPUy38gNFMxsMBW6xlWnc/cA8UISDMUzM373aWmkZE6LSS3v9ovSDq+Fair2YV
 VkpJLMVWIGpmcyDzdrOuC75+bGecenJlnODNb6pgbTvnSMw9R4X7RL4Wkmw6mjo3r/8w
 aANLQuhQNARYk0DNoha3ayXEqVm/lOYNt1UHAg+taPPOb3+W1ivfFNZnYYhyeFviprLd
 Rz+39zTMdIcIJpt9cD9hh00rvUCZbRPlms/y7FsIgtpl+A74SE6hXKNQQskKZBS+wcv6
 B44t55OPhxWt5N0Usr9yvTvRjmxKiJGBg3jmTzqjJZlhSpJfCUiZoFvduyS8LTDOJO66
 iW7w==
X-Gm-Message-State: AA+aEWYjKnp8ayqEPxu8jLh/vl0EAhw2grqmiJoTWK7Ix6u5rFfwwDwe
 DDQemzIpGrvq7rC+UmIppQ==
X-Google-Smtp-Source: AFSGD/XGtQWiAAyV68XZpx6CtfIiv2N/1y8yGxUgvNCvH4vqluDheYlfC5feJC9pmrsWRo8FCcG2Ag==
X-Received: by 2002:a24:28c:: with SMTP id 134mr16459476itu.133.1546039718010; 
 Fri, 28 Dec 2018 15:28:38 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id d192sm20101883iog.81.2018.12.28.15.28.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 15:28:37 -0800 (PST)
Date: Fri, 28 Dec 2018 17:28:36 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: fsl: scu: add imx8qm scu power domain
 support
Message-ID: <20181228232836.GA11339@bogus>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-3-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545148524-658-3-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_152848_928772_3FE206C0 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 16:01:25 +0000, Aisheng Dong wrote:
> Add imx8qm scu power domain support
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
