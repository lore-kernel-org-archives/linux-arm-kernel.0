Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E9EC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:37:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38E220837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZ2DxBYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38E220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ggDvyhba+av9KDdqN0umqU3eeGcJ8nd22m0eCpAXTgU=; b=aZ2DxBYfVGSzCY
	3+CPJQGX5DSxAb7q6+Jd9ua0eVaQrLj6c71FWz8j+7Yn9PrntO/xoRYdgBCtYzokgLT8nG0SVstMH
	xL2PEsaeTey26EektjZbU2TAX2fm6xeG6wCnD7IcjnO6NjpWY96riChVSZAGw4r5i/n13BuDM/vBI
	Meeio4kzqfQ/E2Hl9SW8YUi8yBp2CanUhI5z0nEDU8Uv4f+SifRc8256USlhZ4LkNXWUXKHedMla0
	Qk7B0oX8rZI9356FTrZxqjCS21a3DA5L7D5mSIZ1z2zf4BoLKGT0JCJtCVxB26jkcZVgKikOGMNRe
	STMh6eq07y3ZCDd+iZqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPgq-0003QR-Pz; Fri, 07 Dec 2018 23:37:48 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPgo-0003Pc-5P
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:37:47 +0000
Received: by mail-oi1-f193.google.com with SMTP id i6so4757313oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Rrd7MDVTnaV4Z0GM+C9S5z4a3W+VtssK9ylligjK7Ck=;
 b=gpZM/njyLRgKhBbEdy5kZ3BMNdKOBkEOdvzQ/WmCUBdIaC96GB5HkTtizTnsj25xAq
 ZB6+/qHuEszcrbZiy7J0cC9yWHZejrWYw/P10cxHT3s5N1HBzUL19rdutAgua72TsODg
 wJpDMeuKkhLf18y/9tQTPko37/jydU2Hxa21wdmZV3bPicvHP33kPLa0ro6mje6+PaD9
 1079KoCabr2gStwjglK/m3NVdZkKijLXFwPzqsURXjaGYNWSJlLGaI1kozpb2olSZ7gW
 PmnL3FeTLuGncOpAjTopdl/4Hf6I5wvJ+cBlvAcCDi4yoDTiqLVlmFqPme5JZPj1Dk96
 06uQ==
X-Gm-Message-State: AA+aEWaK8VMoGME2ztnxQWoEjJO1qm3F8sBC0wCIfgR93uHpWKvQINds
 FGbBObanK/19FTzcimSt7Q==
X-Google-Smtp-Source: AFSGD/VxWSy0obDKSoJESNkwqfc0jgIAk85MGT+AMYk+elUSh1k4SvPZB5iLvA2t7xFW+8mMysEkpg==
X-Received: by 2002:aca:aa81:: with SMTP id t123mr2567075oie.218.1544225854073; 
 Fri, 07 Dec 2018 15:37:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t201sm2264800oie.37.2018.12.07.15.37.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:37:33 -0800 (PST)
Date: Fri, 7 Dec 2018 17:37:32 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 02/15] dt-bindings: arm: Document RDA8810PL and
 reference boards
Message-ID: <20181207233732.GA12638@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_153746_244204_806A1C42 
X-CRM114-Status: GOOD (  10.10  )
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, robh+dt@kernel.org, linux-serial@vger.kernel.org,
 jslaby@suse.com, olof@lixom.net, tglx@linutronix.de, overseas.sales@unisoc.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 28 Nov 2018 19:20:53 +0530, Manivannan Sadhasivam wrote:
> From: Andreas F=E4rber <afaerber@suse.de>
> =

> Add bindings for RDA Micro RDA8810PL SoC and below reference boards:
> =

> 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> =

> Cc: overseas.sales@unisoc.com
> Cc: zhao_steven@263.net
> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rda.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
> =


Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
