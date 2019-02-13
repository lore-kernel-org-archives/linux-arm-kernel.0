Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3915C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:18:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4974222CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eie/ARKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4974222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kcgUL0CD5mVOZPRrd4Fl9/GmpCtnX3saKKxZYodrL2s=; b=Eie/ARKvQ5X6US
	tZ58pTo9c8K+GQAM2p8kWhEen55nt8w5ar6jwGpRJUzf4sqP4W4t257LHXtbaHGq/6gq/nDf6pMXm
	kxAXIqYpjpbDUMOPnhjmrJ0v3WKcIGr68bQFZb6UDrFoFana457IktiByrIvb1EGPL4hKB03KV5DE
	gBcpxItLaW0/m1xs+dhWKI5N51eCqVhpNDt5EKizxgZrANZ+TY0y3LJcPNLVSIdfzips8FRF8QaaR
	bWB6FCCKVyk4ICIJWGPEwaDCL3m4s3enQqTvrGlMjPknrDJSlqfJFDNTvGXoXWly6KFZAzjrqvawx
	6BN+CuWs8CwMNEk3I6Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2rI-0004fW-9X; Wed, 13 Feb 2019 22:18:24 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2rF-0004f8-59
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 22:18:22 +0000
Received: by mail-ot1-f67.google.com with SMTP id 98so7192521oty.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pd9o8ataUkpBXxoO7hMHfmRxCLrxCxgfeyQ1lASG11c=;
 b=KmaxjqdEydsZYrhl+cQbZDI2URRZmpyzWibD7USHiPV+zI6FqFXh0IKjYVUQ4P5cSl
 Fpdv0pRsJMOC59fpGfx3MVpoCm6oOLk8+bzamT/6CQOplZZRo2LrgR8pqh4HDaRWvGue
 g1gda7CIEGuEZBp/i1lbo+KRnuqxRJK0jwV+tTyKqe41FlK3HjkaUeyyE12Pjv4DUIuL
 84i1tqLHYz3X8xlhPmupXZ3ooX4Ii7IkDrGXH2d6MFlOeYQlG1uFnIl8L5xBEiHcelqx
 RdFcLyqmqD7AGhq2jW7H8Omf5MDxfCo4BywI3k9MuI5SlUMDWKk5mn/lT9zINkA4cqw5
 AYTA==
X-Gm-Message-State: AHQUAuZXQ0uYDsEX1iD0/2z0FnLjSsi+7Kdy01GN3BNxxX/8/sR/yl56
 LJ2gFtqU41MMbkicqMbXlQ==
X-Google-Smtp-Source: AHgI3IbGgFCrxxQFC0pRBvAkQXUFgoQdsgKV2NPuxrj/AybyL7pOIPot3sLKOaueYCNOwYRay/pIog==
X-Received: by 2002:aca:39d7:: with SMTP id g206mr298035oia.142.1550096299861; 
 Wed, 13 Feb 2019 14:18:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t12sm233214otk.61.2019.02.13.14.18.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 14:18:18 -0800 (PST)
Date: Wed, 13 Feb 2019 16:18:18 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V3 4/5] dt-bindings: imx8-clock: add a53 and a72 clock id
Message-ID: <20190213221818.GA13126@bogus>
References: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
 <1548335800-6438-5-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548335800-6438-5-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_141821_199341_E66B272F 
X-CRM114-Status: GOOD (  18.11  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 01:22:45PM +0000, Aisheng Dong wrote:
> Add a53 and a72 clock id, as there's still no users, we update
> IMX_LSIO_MEM_CLK base to start from 6 to allow a53 and a72 clock
> id to be continued with a35 clk.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v1->v2:
>  * change cpu clock to cpu cluster clock per Rob's suggestion
> ---
>  include/dt-bindings/clock/imx8-clock.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
> index b149e63..dcce744 100644
> --- a/include/dt-bindings/clock/imx8-clock.h
> +++ b/include/dt-bindings/clock/imx8-clock.h
> @@ -14,10 +14,12 @@
>  /* CPU */
>  #define IMX_A35_CLK					1
>  #define IMX_CPU_CLUSTER_A35_CLK				1
> +#define IMX_CPU_CLUSTER_A53_CLK				2
> +#define IMX_CPU_CLUSTER_A72_CLK				3

I still don't get this. How many clock outputs does the clock controller 
have for CPUs? If 3, then this is correct. If it's the same clock 
controller bits across different SoCs, then just name it something like 
IMX_CPU_CLUSTER_CLK and reuse the same ID.

>  /* LSIO SS */
> -#define IMX_LSIO_MEM_CLK				2
> -#define IMX_LSIO_BUS_CLK				3
> +#define IMX_LSIO_MEM_CLK				6
> +#define IMX_LSIO_BUS_CLK				7

Changing numbering is not good, but I guess it's early for imx8.

>  #define IMX_LSIO_PWM0_CLK				10
>  #define IMX_LSIO_PWM1_CLK				11
>  #define IMX_LSIO_PWM2_CLK				12
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
