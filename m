Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D470FC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A298E20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NCmuRPHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A298E20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KOf3TRe/01AQAqoi93D+DLIRUjyuRKkZAlIRPjb7WSA=; b=NCmuRPHLnnlZZ0
	XEukQ2WFk5Vnc40mtbUDtOkYElCJ78xGr1OcmDzTDQNo2xX4tjCRzog6x75x4WLvG4w9EoCa3FBmZ
	3kkj5h79I/77Mai7lE0cvB+q8hNZdTGDiMyHQmuJyyMKxnTTSYLc6wundIVFBRQH/YCDfmZgGhl02
	FTpR2HyETVOucPb4es5YlGAeDCzGFzn4kH/nBHHSjwiqaocUuAV7nIuqRbLLt5NqjQCmzmUo8Utiq
	Ro5KR9brUtcSOMgFjzc7hk9O94nVwxqJTXSWqNXR00eBo44jQrc6bPf5HIn77gzEzM4U/g3lqkvNC
	yD04IkoXaIADEiKt9+lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTsw-0007fE-2R; Mon, 10 Dec 2018 22:18:42 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTss-0007dH-Ga
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:18:40 +0000
Received: by mail-oi1-f194.google.com with SMTP id w13so10368891oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZVmaNxU28RZRbtYzOac5EiHZYnbg7QMeLMNiI/ZFWhU=;
 b=s9Syw/jJdWg5Z+AF7c2jL9C34/XkOqZOzUg2pYy40xUezKAnBbYrpRW2RHrK0sJMae
 ut/ewtVBSp4D8amP5CnUe3RsuhFRvAlC4TvazRj0LlLz7ZlII9PNaUfA7p+wHcrvttdU
 bCuzaNloGjnjm+6aUwbJN22mfq0wGM1e+OUoFvRaOfbCV7QqdK1UR8Nbeg5T3BNOIadY
 HD6gcb+AAI/MTkhzAEwW91WWj+c/hXxMrFpAV4PBBoDRpQfE4TP3O+zo/+6CYP9wUIot
 LRDvx4vxPz01TyCWO9SZwxAdDpxGP9tJoL5wnv+gkSQb1yCL6p2Yvu7z8EH72xlRicwV
 2Uyw==
X-Gm-Message-State: AA+aEWbA/CVI/GFYNnP9k82fYUGIUP6Hhg+pTd9P+DzyjI4CKxnGA949
 zByrIdRthkS0R+27B5biKpsS0P8=
X-Google-Smtp-Source: AFSGD/UlgDCJ1x2oIz2waE1mkWw0r1GD/2yoS1FQ2EhKNF3Naxg8stJ+LTjZKvREb+zqWxDIx/Tv7Q==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr8911536oia.86.1544480307362; 
 Mon, 10 Dec 2018 14:18:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r17sm5887977otn.0.2018.12.10.14.18.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:18:26 -0800 (PST)
Date: Mon, 10 Dec 2018 16:18:26 -0600
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v5 2/6] arm64: add basic DTS for i.MX8MQ
Message-ID: <20181210221826.GA21311@bogus>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
 <1544365552-30270-3-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544365552-30270-3-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_141838_552945_134AA6D8 
X-CRM114-Status: GOOD (  16.10  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 9 Dec 2018 14:26:07 +0000, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the basic DTS for the i.MX8MQ.
> For now only the following peripherals are supported:
> - IOMUXC (pin controller)
> - CCM (clock controller)
> - GPIO
> - UART
> - uSDHC (SD/eMMC controller)
> - FEC (ethernet controller)
> - i2c
> 
> This is enough to get a very basic board support up and running.
> 
> One known limitation is that the driver for the GPC interrupt
> controller is still missing, rendering the CPU sleep states unusable
> as there is nothing waking them up anymore.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt  |   4 +
>  arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 392 ++++++++++++++++
>  3 files changed, 1019 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
