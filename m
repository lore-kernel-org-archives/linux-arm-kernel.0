Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A790EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:15:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDF320861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ShKca5Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDF320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/3XDw7GpFT26LS5mSs6/6Gami525yYYUMCVc2kIYaAo=; b=ShKca5RaUAqvoh
	AsRrsCOpjssCUm23gDK+sJN01V/t/2HWt+0h77WquskFmzsHSLEsSBbQeGiDexTz0YdHOfFX49Pp4
	VOMyGScMWKrIqGHjXsB4A04J0htuRldZEnj4zH67LU63wDJSrpv7z8Tx7kwMfs2b0rdyrDvz1MxAM
	cnt5I65U78eqlisJej9WYr6r7FwWztBJGBV11Pafc8DwNE684U7mSCNzMKWZh1wyZng/GiS8Box3X
	P2lJcnj8dIbIb+z5OU0L/b0tukhAg8eTKssN/GVnNHpCqwCXyi/zHcRvzJPVhU4tMCRAyqqzJPvhP
	GNqjNXz7yYe99C2ex05w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0Pk-0003lm-Ji; Fri, 28 Dec 2018 22:15:32 +0000
Received: from mail-io1-f68.google.com ([209.85.166.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0Ph-0003l8-Jv
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 22:15:30 +0000
Received: by mail-io1-f68.google.com with SMTP id x6so17685894ioa.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 14:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uClxm7HCCBAAlYIlUSDBWojihLPRX+8fdAeGawrN7Sw=;
 b=i20LMjUyiZPBACRiJoCiQdLmUT7QqJ27l7wWreawKiaHQ6v93ge7lSxajefixMIazv
 uWc1JY78JOr2WUXj8qY/Vp6aiWo9oCk0cHvDM7s74XHin3BJctZcdUwjP2nO8gE46hA5
 2rHREb/0pkYOzUdX+c6Rqw/BRX6UkqFtxkS7lRq9f4MPtoQSvs/ik1s+sN35a20xSH5W
 DAPuIl/S9FdOK0zPiap4QnJfve7chN7lwCcOvohtOZTBdnXfVgXxP51mGtDhuK+cyqW6
 87Mhu0lgix0M37ybgC8gMsZLku5W6cXt8KlHGKUN2YRED70tJbnGYqCcNu88pl2ik6zF
 Gejg==
X-Gm-Message-State: AJcUukdUc3Hv/Gszu2rqPlTjqDH4Hzwqj6Qv0xGhBFA0Rs0qX2fUkraQ
 FWnXeMW2vQZJUbWZU0L3kA==
X-Google-Smtp-Source: ALg8bN4v5qW4Ox91XraBf23mmFhjvXiGJqHRXqlT6Te9qz/OKcndjA9vViaWnHHnubJdgLrJ2dLWMA==
X-Received: by 2002:a5d:9a84:: with SMTP id c4mr20858558iom.123.1546035317328; 
 Fri, 28 Dec 2018 14:15:17 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id c2sm18848621ioh.29.2018.12.28.14.15.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 14:15:16 -0800 (PST)
Date: Fri, 28 Dec 2018 16:15:15 -0600
From: Rob Herring <robh@kernel.org>
To: BOUGH CHEN <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
Message-ID: <20181228221515.GA19572@bogus>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_141529_656634_89253D74 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 28 Dec 2018 03:26:04 +0000, BOUGH CHEN wrote:
> Add imx6ull compatible string
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
