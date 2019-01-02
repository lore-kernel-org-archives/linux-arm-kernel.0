Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1BCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:14:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643B5214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jh5TfDyi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDFqY4As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643B5214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=A87SIWseoGep36G3v+M2TOEl6KG1aZAyQ80A2EWnjg4=; b=jh5TfDyiNkoVE4
	EFETQIk8BWyYKTQz7WhywGBVhPkRmzW5rrHQgsIWPKtErG6kn06R7gX/zcBoSpwGeEPDUzzEyqkFB
	gDNw17BzDb1+JskJ4k7EgsWxNfUtcP4JWt4Hh1/cR/QbV0NbdzXKb5bZ1LqpwuyMcgMnOnauFXifW
	ByzJj4MHZxR2HHImpdC28oTu+i/DjMOmqTQyC+lltbrkA0gqD4HMpw3LaPkZUlfAiLzl/tmskPS8n
	fAWfsqmgicc1HBq3c23du8456mZN9OdOnAQtA21oaJZU062trHNf+wAV8eG/ATGnypcvZwkW701nh
	nUsAo1FDyNTeMWV72ErA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geomo-0002uu-PN; Wed, 02 Jan 2019 22:14:50 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geoml-0002uQ-Oy
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 22:14:49 +0000
Received: by mail-ed1-x541.google.com with SMTP id h15so27438092edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 14:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=9RY6fdJuJxTIuPFCRUs33W8BiOrFpwhleLKM2RAt214=;
 b=dDFqY4AsbggW3GGQOPFa5DTMTKsLNA1iemACBKW/z9F0vOOibkKIZiewwmkgegtxsg
 tFbtzxzBCNhTZaf+yBhJyoRabQGSbNoWwcaHx4rk0K3Jc0Bm3sPgCJQsJ0aOcrs2tGN4
 L/kVmGECcT8sgh1gt3zCk5j9zYYev+7P6zbUUE8mOA3pFdBfZKb1WUqNz+5Micn9GtjB
 a5FOV1KWvn7tJ+KdWW26DLGJFUlX2qFkjC+hjDzl66nnc2XGX3JOCe/Q7h9IJYxehqAv
 /d7om8Asei2cRU9k34yfP4jMZnaBkAX8tovfHpRousDXIyn/twyFsOngbg/G2iD32cyU
 VwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9RY6fdJuJxTIuPFCRUs33W8BiOrFpwhleLKM2RAt214=;
 b=QICf14c52YcZIq/FCzCUejdcSqk1f3FXVZx/1i7xC3tcIuLvsnjBKvlrjvzBM+LI8H
 Rkd/o+ENHnK4lVWgHMBnpe0qwD7UmHFp1jm1nH9eksAQZWSBzJpwujM76aqALLJdk3Js
 2Y3fNMiJ8RP1pstdhjEOdDKcuyZnoOBGOuNp5IgvRkxJJxFwPR8+Hyj8bOe3q0rUg2nb
 WBPql5xuvMqJxPexTAl8Wl2EuYJkDWKLc3Dx9cr81n5CwjkCO5TPQVku2b4uo2pkuvPk
 fWJeCdh6JvuWbsHMCe8QN8Zciz/1B58jjpKHaIKoN+lLtXI+pjnchfc3Onc1PIXVV85T
 qtWQ==
X-Gm-Message-State: AA+aEWYGRykXW7CujgRomysBAN8PViOmp8RN5qgh5nJYgOlT5Ncj9p6Y
 /ZrrWYRyMfZgU1y8/lm9Awd+1mY5EMU=
X-Google-Smtp-Source: AFSGD/X3tiXO3EJR+mX8emK1LckeIvAgyuZQVF4vjqwls95zfjdqL475c8Ta1GOpMD+Mcerkxk54BA==
X-Received: by 2002:a50:b559:: with SMTP id z25mr39874020edd.239.1546467282961; 
 Wed, 02 Jan 2019 14:14:42 -0800 (PST)
Received: from localhost (ip1f11350a.dynamic.kabel-deutschland.de.
 [31.17.53.10])
 by smtp.gmail.com with ESMTPSA id q13-v6sm12521079eja.8.2019.01.02.14.14.41
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Wed, 02 Jan 2019 14:14:41 -0800 (PST)
Date: Wed, 2 Jan 2019 23:14:41 +0100
From: Oliver Graute <oliver.graute@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: Re: [PATCH 1/3] ARM: dts: Add support for Variscite DART-6UL board
Message-ID: <20190102221441.GA22974@ripley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5CF5uYDm_XM8m-+9ARQPsxVqNqUJuuHwEF-CRu2DNDOdQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_141447_838701_E5803AE9 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: s.hauer@pengutronix.de, Oliver Graute <oliver.graute@gmail.com>,
 linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

>> +&lcdif {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_lcdif_dat
>> +                    &pinctrl_lcdif_ctrl>;
>> +       display = <&display0>;
>> +       status = "okay";
>> +
>> +       display0: display {
>> +               bits-per-pixel = <16>;
>> +               bus-width = <24>;
>> +
>> +               display-timings {
>> +                       native-mode = <&timing0>;
>> +                       timing0: timing0 {
>> +                               clock-frequency =<35000000>;
>> +                               hactive = <800>;
>> +                               vactive = <480>;
>> +                               hfront-porch = <40>;
>> +                               hback-porch = <40>;
>> +                               hsync-len = <48>;
>> +                               vback-porch = <29>;
>> +                               vfront-porch = <13>;
>> +                               vsync-len = <3>;
>> +                               hsync-active = <0>;
>> +                               vsync-active = <0>;
>> +                               de-active = <1>;
>> +                               pixelclk-active = <0>;

> Don't add timing parameters in the device tree. Add the panel support
> in the simple panel driver and use the drm mxsfb bindings.

can you point me to an example? I don't have any clue how to do this.
which panel driver code do you mean?

>> +                               MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT
>> 0x03029

>Is this for Wifi? If so you could add a pwrseq entry that could take
>care of it.

yes this PAD is for wifi. Do you have an pwrseq example?

Best Regards,

Oliver

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
