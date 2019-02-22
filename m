Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94433C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:39:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE43206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HpjgjEf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE43206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+yyiTyRnXhfWR1d7ATB0HEg3WXINsYwJQH3b1Q6RZqY=; b=HpjgjEf9t+LVtd
	d04ezhSPaHZWlFGdn6eao3YmDOshD1BQsWalifK5P2Mw83SvITPIwxsORKmt3SG/BkuyD+Iv/u9h5
	PuWdTzc5d5TAQ8RORehTeYGhf2g5JnvJb/vCIdck5QF8EUoMBKEwK7+vXtiNGFj9iZoSkNh5PihL9
	IbBL4byR4SoCeI3PIhrqC5BWdIbXcdLPimWrspafkK+74HcDK3ZANJZ6PfMKNGajCynu3JcH5zLC1
	uDRSiVO3U0pdPoMTdtJel7BHGQnKF670jKS23f2j75GBfR43xfPE7Uq2NXhtLqDztV+xik3EIgpjX
	iLrl8fCauCDPylA0fXlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKPN-0003MC-4t; Fri, 22 Feb 2019 23:39:09 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKOU-0002GB-Eh
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:38:22 +0000
Received: by mail-ot1-f67.google.com with SMTP id b3so3351247otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 15:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1nizO+O3jOjh7hVKOxJ1C1X63izeUZlUr3vc7r47AOU=;
 b=RwF2qdKuemjFtn122V1RLG9Dtr3jA3Qz9bRHoiY0hIZnlw4nnX6E3UnUHBrc422GBY
 vuWrXHGq6/G4FwlqW3HmKt0tD57QzcNB8in5+IZk8ps5qtq0kqOCfZgOdchfSzZsnpOM
 hNQv+05R43/vjIBUmMitZxxnfE1KBVVdEsDUhvWZ7OJMYsOVAEGZFL8Xd7QDuzCPUJDg
 55XUd6wgZWCS9LoauRPzt2fn5qgsOKIdrGWLIFAwCzyT+U10TbLgkajW2k/Yt1AaSuWE
 vR2dA9jPgjtsQUYayOJbwt2iTDnbOeNzOSKrOAJlRU9AYl5wK/mEJUESTf6FMXY+cpWo
 Bsew==
X-Gm-Message-State: AHQUAuar0a3CCWT9GkwiB4IZzUuUBKZ9Yfipm4ufwIzx1lq/06AFI3kU
 xo1xUnNdVR4Y744GgQHBZw==
X-Google-Smtp-Source: AHgI3IYSWDh6XITjrw4BLHjg/JWbcAdoVAd5D822js5yCXLKaIB/MkUcTZcmIcg7wK+aj8k6joqkTw==
X-Received: by 2002:a9d:7404:: with SMTP id n4mr4449234otk.54.1550878693455;
 Fri, 22 Feb 2019 15:38:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id f25sm1048987otl.75.2019.02.22.15.38.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 15:38:12 -0800 (PST)
Date: Fri, 22 Feb 2019 17:38:12 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Message-ID: <20190222233812.GA13502@bogus>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
 <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_153814_921001_E029AC7B 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, sre@kernel.org, Ludovic.Desroches@microchip.com,
 robh+dt@kernel.org, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019 13:45:56 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add documentation for SAM9X60 shutdown controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
