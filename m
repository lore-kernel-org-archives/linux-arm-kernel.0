Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A7C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5932146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CiY7/YYu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QQOoYRO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5932146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V9wmr6A+AbbIIu87ty8kuT04FKsSjuJFfFX2GRQaDXA=; b=CiY7/YYuIgaN4Y
	W/Yc3gviIDyKXPAY1fY3SujLNCKQqKJo4kKc89RXW493hqCP9zv5PEFgvRFVSKVjWqKgZsaTZadMp
	QfwQraWoaL5bI8vcBmIPlt1dI2Npz57ZAzJGnLmIpm9xSTIFnYZWMzLR+HBan92+dMXI/f/kckzbP
	LRezrTzrNDI3VR5ZKTsbxX0bBsReM9yj6HFqGmX97OenIFnFy1mgLsApPhxnVcA+d86WhdzF2VxPV
	7wXCY4JXgt6E2wiEXQ4HYJHhAenXvZeaH0jRqbPQUBv60Ci4xFZlYl2LwuHtDYIo+h8W4yHDLtQp+
	CFZ3DdOMRfnS16qfnqBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA2h-0005FH-Ur; Fri, 08 Feb 2019 17:34:23 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA2e-0005Ed-9Y
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:34:22 +0000
Received: by mail-pg1-x541.google.com with SMTP id s198so1874929pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=qwxoUJaBAFteLzh6RJykpa7n9xuqchy/NUCDSUPEHd0=;
 b=QQOoYRO0gh/Za0bheg3uhgOx4qR0rqrkotYKU4qd009x+6hoZQnkywwwBggLmR2iSC
 skKmhAyJXEQbyeNMJHBKi9Ev4yUx6XCOSjk4dDHjAHVAwzOoVZtDURHwTMyr6FI02/5s
 HWIVoboziAbWqP/SkTdU+sx+6A0w+5uI82xg09NYeFEapnCh/fXJwC6D0QDn7HFhnM77
 Q4+05DWzAtWEazFQujJxQSRfay84jyp91cElONh2EOpiYaSmMs3imMCuoOqHxrXNOXXO
 Zu04oXBi+dASgwkxB79YGHv4dP1r2+SDuL08Y9mpuih2BiFtvhTK9J2/+ioBufJFD3MC
 uE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=qwxoUJaBAFteLzh6RJykpa7n9xuqchy/NUCDSUPEHd0=;
 b=aALk02ehmQfYImq4l3y/QWO5bLINQg1CMtuFxli64PbmZHPFF0Y5eQmKWsUeOvBCY/
 GhyR8vDiouT8SOA6embheXkIwS9VhEypUaEX2sS9mpi3Kk4JWRmJu0qeowsoQ6ZAHKeL
 fsi74VvIJZyjd9deP5eXeH7QY3uMowp3RxtzdwVhxE5fptBkytBtp881UgqQ/hL3oICE
 2UxzjXVjBdPTQxVRsGxW6H62BeKMoq1ktMQGzuOcwo6Pou63aIB5CXGpyiaNtQAoTh9n
 8039LEYXf4VZwYgitpX6PzqwtLqfe8E98qkL7RGtk0+Ygf/YjZy03M8p6VBuJM5FKspB
 bD3w==
X-Gm-Message-State: AHQUAubrD+Yae1jKOTvibBaRSP5kEq9lnzncbdtGWI6tkBu5tSGAFGOC
 9ePWvTtxN7A6Nk2hPwZrVu72zQ==
X-Google-Smtp-Source: AHgI3Ia+KJHRxHxAnitQc3735U9pQFBYqA33C04w+iRKO2nIjSJJOll1GjeJEp82TRDujMt58JZfWA==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr23146437pfn.153.1549647258994; 
 Fri, 08 Feb 2019 09:34:18 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:551b:c3ab:6b62:8b9f])
 by smtp.googlemail.com with ESMTPSA id p2sm3311074pgc.94.2019.02.08.09.34.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 09:34:18 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 1/2] arm64: meson: enable g12a clock controller
In-Reply-To: <20190208101405.25699-2-jbrunet@baylibre.com>
References: <20190208101405.25699-1-jbrunet@baylibre.com>
 <20190208101405.25699-2-jbrunet@baylibre.com>
Date: Fri, 08 Feb 2019 09:34:17 -0800
Message-ID: <7hlg2qfali.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093420_389169_BF763816 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Enable the g12a clock controller for ARCH_MESON
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/Kconfig.platforms | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 819e74ae9224..d0e0bd4af05d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -114,9 +114,11 @@ config ARCH_MESON
>  	select PINCTRL_MESON
>  	select COMMON_CLK_GXBB
>  	select COMMON_CLK_AXG
> +	select COMMON_CLK_G12A
>  	select MESON_IRQ_GPIO
>  	help
> -	  This enables support for the Amlogic S905 SoCs.
> +	  This enables support for the arm64 based Amlogic SoCs
> +	  such as the s905, S905X/D, S912, A113X/D or S905X/D2

Queued for v5.1.

nit: s/s905/S905/ to match the others.  I'll fix that up when applying
to my v5.1/soc branch.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
