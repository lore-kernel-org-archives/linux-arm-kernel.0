Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE5FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1826220868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RaE7njOs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sm7t9lIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1826220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9bCF9OIWZlQ6sNtPSGSvGi7QDAt9M7vxYyZTmNP6gEI=; b=RaE7njOs+3SAKw
	WM+os61jwdcFzKIjBG7Fp0Y8j617eV8mi/yDIkyjjRqlHQBTEKvpQpvrV3z3njn7nUbdb4SRqJdvw
	2fl8tUA+HP6nKy6jRRlWYRdiHwcKaWuwCVmy52+akt5k3ZvbkDxb0S255wTkOP2RyOTeuBc3HLd12
	HZ7lMks6PE+ZR+E6LYWU0PnT5LmwaFWrrihxelm1p+zp3pgw1zu/fyJawVWhbX0XkyR4Rh7ZSIMBa
	snG0+3ddnT6FxW9I1caXTMe/zzwgr/yZrjmciVmV9eqlVUiR8Y1zkcbLWYb5Q/htC0ARmRfzi34yc
	TCznwDxp6NFsnaOCBn3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEFV-0005em-NM; Thu, 17 Jan 2019 20:26:49 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEFQ-0005dj-VO
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:26:46 +0000
Received: by mail-pf1-x444.google.com with SMTP id c123so5389711pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 12:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=dgb4VW0Ul58s8MyWXSs249GWJprD5ro58w3NPDfmjNA=;
 b=sm7t9lILpfHGDoH6FZ2FqKJl9AdXh4ZBUSdy7Fwy1mxxNiavjjCHYWh+qWqX0Ey3W7
 NLVKquGLdKK4dQT2hYfXGnbTAFnSyfDf2pEQn/QXycZctLSGgyUFoKYpr17Ie8u0ZvCr
 E7l3Yxpyt87S4G0stRdo5UvnGc1s4nKCRmnpgwLakOPwglggcoDnfBr/FgjGIY37RfDy
 QloJSqibqyANUTxcpMVDzLv4hnZ+7GVh4WcJIWIWrKwxs9a1fdw6hWwR0ieUny+vnCNc
 sL+KGGnAkmZ1OPGPOd3L6hACPSjFKfP45F8oC64vPNWOYPuaSlJnz1VswxcrwRQdMiOQ
 9YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=dgb4VW0Ul58s8MyWXSs249GWJprD5ro58w3NPDfmjNA=;
 b=dV9jQjjiLuac8xXbNC5Or5BTi5OjNOtvNMYeXbkTS5I3lS3ZZpQTDlsj/Iq6uifD7w
 6GApxnoB5eZS7suNOsgRr5NdF2s3lVRMYmrxr1NH++Ta+xrVLBF4RQ+SSRAWVutwJRVk
 ID13lZvsNw5ikyG0+zzYAqigHvwW9SyitVur6PJPCijKn/c1r8rbcFNOChqwAA3yAuh6
 X6SyO6lPOuHI0NlhrHah9G8a3Z3PMEIEza5WREe/qHuQqo/PJW8gXglPQlJOo7ibP9Xe
 7m5vbiiZBqUCrlSDj1nD8fG0stwYFmGPFySl8wmO46jqTC7shuvcL6YT7arysxWnAtWd
 Cc/w==
X-Gm-Message-State: AJcUukf87UUjM08hBhILnArpO1VowZ0btpJfG2Ua2tnQ29fee3DJXSLX
 kths1n/+74HivbPVePv60vbDbw==
X-Google-Smtp-Source: ALg8bN5QBAp8fzkqP7nx/W+gJh9cftmm+X6nLFux9XqY5hQMkkxaQTnlWDTIckHKheSNgVZEq7WZwA==
X-Received: by 2002:a65:4049:: with SMTP id h9mr14588858pgp.304.1547756803526; 
 Thu, 17 Jan 2019 12:26:43 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
 by smtp.googlemail.com with ESMTPSA id k191sm3128446pgd.9.2019.01.17.12.26.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 12:26:42 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/6] ARM: dts: meson: chip temperature (hwmon) support
In-Reply-To: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
References: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
Date: Thu, 17 Jan 2019 12:26:42 -0800
Message-ID: <7hk1j3av3x.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_122645_020034_BF415C42 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Now that the Meson SAR ADC driver can get the chip temperature on
> Meson8, Meson8b and Meson8m2 (see [0]) we can add the missing bits to
> the .dts{,i} and enable iio-hwmon for all boards where this could be
> tested successfully.
>
> This was successfully tested on multiple boards:
> - Meson8b Odroid-C1 (me)
> - Meson8b EC-100 (me)
> - Meson8m2 M8S (not upstream yet, me)
> - Meson8m2 MXIII-Plus (an earlier version of this series, Oleg Ivanov)
>
> compile-time dependencies:
> - none

This seems to depend on your HHI series, which I held off on last cycle
and you said you were planning to resend.  

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
