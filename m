Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBEC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:11:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340F92086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mLYg7P/v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="j/gmDPpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340F92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0v+2FYJXYB6Y1WHwm1UYZDrcULpcLJ+OQA1QaKQ5OS0=; b=mLYg7P/vvelT3P
	MT4S5O8H/RpvH2NI5qW8Zqd57lRpgRWIwBlp+HJZ2bYyXUXAX7t22hDZV36FpQ8udDlTi5y/JalpV
	p0pSR4vtjFw8azbhAdB004RkUvI4Lr6KYaFJZClUXowdFMmi35ONCq6Qzdq3983ZRDHoN2BiEAPJt
	Z50MSjQnt89FuCX9TjaZwgxhnRf0+wLywGk5vZraVrDmIb++MqX7zAaBbVRSzzfOu41HQTYeanVqT
	IZ11B85Dni6GchEDJuwao1uNTZ58C6MaCUnWdJxbqBCD+BZ6ARaSvOzdU6+GN025G4crGrzHctPWe
	d0I9lbUsOd5YLKhi6yvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giYzU-00046R-NM; Sun, 13 Jan 2019 06:11:24 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giYyx-0003Zg-Ro
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 06:10:57 +0000
Received: by mail-lf1-x142.google.com with SMTP id p6so13526043lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 22:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tkT4os5suOolX0+9adPZc8OhELYJ5AMG9HIWviL6xyU=;
 b=j/gmDPpLkaiwt6BWqVkEHMeXhWIWJvh/T/syCwOy06crZnOaAmhGKuhvw4f2xbfmLc
 nc60bYRpZQKBvpgcjeu9gtzd++rJShAXlAw8//t2/NvDBEFnEg/zspT33/mGlBnTKuqt
 MLA16Zb/dDHQC+p6e+XhKL/7lwq13WGb/7WoO4B4b6W0+dE9Fee4X4GX0QOUka0P/RSU
 oSIyN00otRbObA1U4CxVgRak6HU2yw3vf8VYt0Eejk475Wg3tKJ/Lg3eR62RNZ9Rua00
 JGRBiZ77JcZDxKHRew+h5oY1382lQgd5GCpMs6evDzd5zsFim4razntH49bZJ6JB0rHJ
 FAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tkT4os5suOolX0+9adPZc8OhELYJ5AMG9HIWviL6xyU=;
 b=IFmrB/eaIepE2BBINDXiWrrfxXUq22fTWHvhfXKbl1xqCU+XXNinx2UAz6sDSOXtpI
 GMCFHMr2IQR76eDlDPkX5hLR9ULJuEAqcwT47fe62FbuXCg9EREVghNHFqewOSe5laXQ
 w7X+XdXHWD70X4PDCzKI+yRHR4TW1HibphVoz0x7Sg472iwAT9vIPP1J3WW9zUJcVudF
 1G492EGf/xpDKxtipaTluntS3wfsPTfH7GizGeRjQ8smEm73JuiPpv3X9Ej7+neS4z8i
 fwFWPeZk8EpRXhRtaK/7KZ6EoaYuynfmk0FQ7AuULMDd2FXmZ29A+6IeAQJcAh5ijiQt
 Hsdw==
X-Gm-Message-State: AJcUukdUhsicUFrBOUJ7Wq0C5YEbrPRq3NSqa1JWxNjHERkmn7Pzb/P5
 W6n6f/iyKIARh/49YFeazgh3og==
X-Google-Smtp-Source: ALg8bN6JZENAqs0Smd3CAoDKyTZELCQMFw1njtRI0BUYIvRjE9K/DfEN84yGL9mLwduAjVP1cFISNg==
X-Received: by 2002:a19:cc46:: with SMTP id c67mr10737263lfg.145.1547359848738; 
 Sat, 12 Jan 2019 22:10:48 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r26-v6sm16982455lji.25.2019.01.12.22.10.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 22:10:47 -0800 (PST)
Date: Sat, 12 Jan 2019 22:02:45 -0800
From: Olof Johansson <olof@lixom.net>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] Amlogic fixes for v5.0-rc
Message-ID: <20190113060245.gxa7m5e2vzfplsa2@localhost>
References: <7hzhs8qcdq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7hzhs8qcdq.fsf@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_221052_185800_A693954C 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: linux-amlogic@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 04:14:09PM -0800, Kevin Hilman wrote:
> A single fix for the early -rc.
> 
> This is actually one that I missed including in the defconfig updtes for
> v5.0, and fixes the out-of-the box sound card support for the newly
> added s400 board.
> 
> Kevin
> 
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes
> 
> for you to fetch changes up to 19a220dd1e8a1b1d8e5e2f8f4a25313c4b02d527:
> 
>   arm64: defconfig: enable modules for amlogic s400 sound card (2019-01-08 15:27:50 -0800)
> 
> ----------------------------------------------------------------
> Amlogic DT fixes for v5.0-rc
> - arm64: defconfig: enable modules for amlogic s400 sound card

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
