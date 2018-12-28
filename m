Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343DFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:28:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A97217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LNnFauw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A97217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jW3+okii7atd5EfJznpTS/fBAkBgr/6/Snme4m2FquE=; b=LNnFauw7h/iNRZ
	1pYqVp+g2mHr38FCuWkZXFhpAlhGDIzzbvL/W+vb/myBIDu+XYoHezyE+o2G9JWUqvyo9nvodCwZJ
	6LWTzxndgIOuWRxhubEHRGInLgSEgwTQOMBerteXFNZtx9Z4t4BT7V3jJ3n45krSdqM4a4sN1PYdK
	ERK7ZC8sfC5l9JLacn8nJFp5kAX9XzN0SeiUadq+iJ/kyZn807hQI7EDIfFsEBaY3+oJPoe3oSm9o
	stuEcc68qVncfu7v6rchOEkNIFBoDCiCz/fuG8nHQCV5kUqEFB3v1eC8XsukFypfDgbNV0kewwmSL
	K2rq/z0g2XONCVDsVkrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd1YP-0007h5-8O; Fri, 28 Dec 2018 23:28:33 +0000
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd1YL-0007gL-8g
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 23:28:30 +0000
Received: by mail-it1-f193.google.com with SMTP id m62so30205454ith.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 15:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oTzKtituoF/RJR6ztq7GcsmSkMRstSVzrSjx5UVDVDM=;
 b=My5GkHHhGBmG/14DJiV7RYex7OhfRefD9L92jCOyWtiNLuq4urLdqULOnaVmt54uSX
 XrNXtuyPFWIut84aSrspvwgPvra6CT7OmJIxSb1qNOjFHKAoGzGGT3bwBpaAkkuvIBNK
 8cvD6Pjf7Oo1MqHSEYuq1icaxg8UwxXxkyOD8ceIEo98uMOYQaUlYKWMmdBKtvjTUAJ4
 Jyasch/Ka5iDlfnWt7n5ETA2IfcDlx8oR6iwuMZ/9ZkrKcq/T5jEZ+nzFW2IgssuLXpP
 h2cPHgqvTEZT3QgOnEQUQ2XyI02ozZ5TcSYAd+YHqWtwFioi+ApGvA2lqnJWWE3rb0S5
 /PxQ==
X-Gm-Message-State: AA+aEWabc6BWyf6kTv9JkafXy+HFHuz5HXEGl9qsns62dx77riMnyakS
 ifMxV9INqByXgLO/o2iWJQ==
X-Google-Smtp-Source: AFSGD/Ux534FJyMlTSR4TJ+WtTyLnoJe7e9G/jtVodRduHxKgDBQc0FQnk42i3EbcmW1RYfTIsrqnA==
X-Received: by 2002:a02:77c1:: with SMTP id
 g184mr17838053jac.140.1546039697929; 
 Fri, 28 Dec 2018 15:28:17 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id w16sm17482516ita.38.2018.12.28.15.28.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 15:28:17 -0800 (PST)
Date: Fri, 28 Dec 2018 17:28:16 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible
 string for  power domain
Message-ID: <20181228232816.GA10708@bogus>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_152829_305732_4A373295 
X-CRM114-Status: GOOD (  13.49  )
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

On Tue, 18 Dec 2018 16:01:20 +0000, Aisheng Dong wrote:
> SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
> Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs
> to reuse the common part.
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
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
