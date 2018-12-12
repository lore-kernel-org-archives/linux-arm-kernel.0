Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73861C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:15:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409FC2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uG+R0tv/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Rqg8lbYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409FC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DU5ZwrriFVzYnTAxhtWznUEDTGaqZzuseXDf4dSVwQs=; b=uG+R0tv/gNKvul
	M09Gi8VTqDdmVhlo6tBHjdmHLjLRtx8ojk7u9fRQsfD5fW18Vv0XdAZqnsBwTlWDvy5yzytnD1rDO
	kEIGckbd6EbWM4k+f0KydCpxie2Mc2Ak8hPP/SMxG/5CNCuPnNDeROgGCBgqDPoQebnDvI1w6TbWW
	1F8BzYJwCaKWaXj5DZlSXWjdEPG+9VvMpddVtt08ySCXsx0d7q9Cy4zKi0EI44be1BT4tGsGF/iOI
	o/soxzfupkQSJB4i0QIC7ljPOJe1nj/jgAHzdBIoKD3sJuDd7eMkBG0BnemyUxrk+XA7+ZkXAIK5T
	lqFP2JIKl61FayneEsYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCn5-00063Q-7D; Wed, 12 Dec 2018 22:15:39 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCn1-00062s-Jg
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:15:37 +0000
Received: by mail-lf1-x142.google.com with SMTP id v5so14786709lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ShgF1jW2ISD3Iv+kX1HpN7vxPFupdN2YlFASJspgMjo=;
 b=Rqg8lbYGAwR9vSGcvASiliXLw2a4T8WYD9I/6zkTFgTAwELlL5WDCUx1sM154yrsaB
 KTNempBa81hw+T3I90kR7PbaumKWuXdZ6ZcY8CH6yI3EqPs+Z/vCFqd3Iw8uCpvuoiGz
 Px9TcE0YCmr77dwNt+EDKHKXXzkmwDggkHbwuMn+CxRcz8ywtzmHeYLzfN24fusGr+l5
 6Xph0oHhiScfXVLzYmA9tks0x0rUxeov9AlObcq+k3pcs59noUczvDaoLvQAfNZJc9ZE
 GZwG2hBVz8z4x0V6syTeXsJQXcVyO1eJe9I8kaq9ChuiUrBbbtqtzjYU0owU5m6Q2nDV
 FNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ShgF1jW2ISD3Iv+kX1HpN7vxPFupdN2YlFASJspgMjo=;
 b=OOafspQ8jEf33PS6T5b4urznBjx+t+cf/lLMMvfcC8Gd+KLHqkgFEV31+0v+PVqBQU
 uW4dRUq71UHC6y3mR9QqB4GtdhOmedE/Y7/vqj6tckxG8EIwvbjgWEFdxk6SD0nh1AjI
 uGTRcnzl7GARZlRMHVJz1haW/H+PqiFdF9QYL9sPA80nulC1xaT5dzloJmvsaCspJEbl
 zbTo/PfkuOSUQw5OfujIxYxPNnd1quP8E16S+fUPDPydkzNLz7JEE8b3N0f7sTwEOIM8
 4jtztKQQYyDsosA3uv+Juoaw3TgdVer1BKKO4eCac0Oi5LFYGuefMb55JS3wednt167E
 HXdw==
X-Gm-Message-State: AA+aEWaeEkcdCixtyvg791UJRS0zx/FuSUhep5I2pY5wb5dy512gbSUL
 F9S5dHqZqvKM4tvKE9wwFAqDKg==
X-Google-Smtp-Source: AFSGD/XaGAG9tVOoXKqxzt4H9m6gfOGHUJIMDKqbWnyxsJiturwb1luJw3GCgYSt6da4F9VRc+m5Qg==
X-Received: by 2002:a19:aace:: with SMTP id t197mr12518127lfe.7.1544652923516; 
 Wed, 12 Dec 2018 14:15:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id f11sm4735lfi.12.2018.12.12.14.15.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:15:21 -0800 (PST)
Date: Wed, 12 Dec 2018 13:27:15 -0800
From: Olof Johansson <olof@lixom.net>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [GIT PULL] pxa for v4.21
Message-ID: <20181212212715.o7tgvo5n7wgdtxvx@localhost>
References: <87muplu3uh.fsf@belgarion.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87muplu3uh.fsf@belgarion.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141535_737927_AB21F063 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: arm@kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 08:51:34AM +0100, Robert Jarzmik wrote:
> Hi Arnd, Kevin, and Olof,
> 
> This is the pxa pull request for 4.21, a simple single patch one.
> 
> Can you please consider pulling ?
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-for-4.21
> 
> for you to fetch changes up to c2a70a319afb9e3dee16567cec4d9bf8dd358b59:
> 
>   dmaengine: pxa: make the filter function internal (2018-12-03 22:41:07 +0100)
> 
> ----------------------------------------------------------------
> This pxa update brings only a single patch, finishing the
> dmaengine conversion.

Merged into next/drivers now. Thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
