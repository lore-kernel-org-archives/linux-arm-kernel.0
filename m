Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF8C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:35:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A072133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IgrsIXzw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of3cEJez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A072133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E+Z3YG/7fNOjosGL0pgtRaCruzRX5MmKuE/xvRHGfiI=; b=IgrsIXzwU+L3MA
	rYmmlr7aNeEQPBE9UPn0MjHPv/4DcXdnxlwIBlCr/7SxOICite5cHI9JhhxKINqtpjpNygRNIZOH2
	0+r35mUNB+2PTMXa2jP/DuM6b5XVBRSiAPDIJiwrTmqCEDi3yPvcltQD2VFfAtF2Wrn+xxquj5Yc6
	sI1OrdI7w/laPXZxspQmB9Zjo1j80Yyk0It/qdZK+nsBaBOqv2isYBerS4EHnwkVDVueyAbOIzexk
	+Bv3Z9brXs5LpfHhQmrvE6+wHugwjf1v7iDJcngIiOkIWn5BXg63iYvS7xDD11tUsPCFhdHMWPlZj
	XTjZdgp07r0lPUY9UKHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gns5D-00088F-KD; Sun, 27 Jan 2019 21:35:15 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gns5A-00087p-Fs
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 21:35:13 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so6844631plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x71vU070+8Q/FGwQAA+Hc/w70hPL/YdMRsYZGsaVNpg=;
 b=Of3cEJezv1oMjW+SGANabx4RJfS9O1da6KRaV24Zb8r50rbfObqp5MgiM9U3mVEVRk
 vuwPzkV6scoUpJo+KUYZkU1Fr+gTJxOfyqTBvVxDRyC04w7pOtqT8guEOrinpzHtXdiD
 BhSF201racbC6U18vgd+P1zuVrb96HlgknuoQfCIgn4uSJr3YBFmKBaX7Qc2I/3OMZT1
 Jhn1xp1RlavyY8d6qeGFcSgqMx89mKwGPtmoyltVH9In3uGIWEHgKiTmhcOMIrgWL4kF
 q0URRl8IbTBBEdbJyH5+44ykfVKnk6uPYkYdmMnKfqmWH4XZcehgfDZyi2/AKliLpCuP
 jN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x71vU070+8Q/FGwQAA+Hc/w70hPL/YdMRsYZGsaVNpg=;
 b=nqzjtI1U7TGvdEbnSORi0TV6je8ggQZQuIIzeDsUVDu7+VkkNdQGNhXYZgmQRkhKFu
 MmONh80B8eTKTWd+7UZoWXZzTxpkf8dMMxz6ruAggzJGl9KQkGHAI8mPeBr2RlgIzySC
 OHLHUt3WF4jTyX0E/vgF4i3y9oyr/xONs3fp5l2Vkx1KXv8PGPMJImYtI4d0lR2Y5J/5
 zOEhvZ1uurUX2/OBDUJa/f/XIxARQ0U1+jAkCDUAuvPEWRRtOiNuy0uRSggL1wT906RO
 4ZaNhvXdA5LyNas5zIgljvFnhTkHZGZ6sUW4jNZrP1oDe/U4uSzO05uHfaIRHhPjURGW
 V9+A==
X-Gm-Message-State: AJcUukcf3ihvaYcINIwAygUW+jDGM7t4ixnI+dHk8C7aNWaaF7xJtgts
 XiDekKsHoTbUpnKbpC9UiDY=
X-Google-Smtp-Source: ALg8bN4OrBQBIKY+2iayh0nQ6AeXtWiO40mI0k2cEJrBwvJQWUl2dEDA4cTy7MZJbphwifo8bluMEg==
X-Received: by 2002:a17:902:292b:: with SMTP id
 g40mr19572641plb.82.1548624910197; 
 Sun, 27 Jan 2019 13:35:10 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id l70sm59290383pgd.20.2019.01.27.13.35.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 27 Jan 2019 13:35:09 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: festevam@gmail.com
Subject: Re: [PATCH] arm64: dts: imx8mq: Add ECSPI support
Date: Sun, 27 Jan 2019 13:34:38 -0800
Message-Id: <20190127213438.30424-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190126212824.15641-1-festevam@gmail.com>
References: <20190126212824.15641-1-festevam@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_133512_554029_59F88A76 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
 shawnguo@kernel.org, cphealy@gmail.com, linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Add support for the three ECSPI ports present on i.MX8MQ.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 39 +++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 892063a7c26c..45b9d4a8b0da 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -26,6 +26,9 @@
>  		serial1 = &uart2;
>  		serial2 = &uart3;
>  		serial3 = &uart4;
> +		spi0 = &ecspi1;
> +		spi1 = &ecspi2;
> +		spi2 = &ecspi3;
>  	};
>  
>  	ckil: clock-ckil {
> @@ -381,6 +384,42 @@
>  			#size-cells = <1>;
>  			ranges = <0x30800000 0x30800000 0x400000>;
>  
> +			ecspi1: spi@30820000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
> +				reg = <0x0 0x30820000 0x0 0x10000>;

AIPS3 in upstream tree uses #address-cells = <1> and size-cells = <1>,
so 'reg' property of this and other nodes needs to be adjusted for
that (vendor tree uses 2/2). With that small problem fixed:

Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
