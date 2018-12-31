Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:37:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F215205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fa4+jXMz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="CoRVFkuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F215205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QCmzsd1VKUjNP+9WHiS2x1kFZ2kgHATntRjzQy7HMrA=; b=fa4+jXMzAFZNLG
	NKxotSIbGJQFnclVOTA2K1B+bAExVbhNcAKEqdB7vpiZcaG3WwgtP5mJO/ASEH0TRo+xaO0tQ72Xh
	/Z0HKSIbyJwBH/cod6p+8f7dCmvbLni4fNA8fOtM7yqSf2WLK43Wqj2VhqCsOIwl6j9LGDqRQa7eL
	UKHPc5RXAJfHebKCCopB/vG2tlS3+ZQytk/KaHY4laoRgNyrnVIxSR+dp4gePLcumah1N9CiCXkL8
	bnkETTmvPATddxijfY3/SBwv03WVJShdxhVMpd7uOXED4NmMql3WTLX+fi/EwqgcfkoKImlNJoc0T
	1GywSpWJ/RcC/3zq095A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5FX-0000Ih-UA; Mon, 31 Dec 2018 21:37:27 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5D9-0005s7-Fa
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:35:07 +0000
Received: by mail-lj1-x242.google.com with SMTP id v15-v6so24294037ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RitWBMSWBPvI6qEt0eDigOTixt2IEvWYEed38jkqDQk=;
 b=CoRVFkuMrh7r4TC8SdgTireVJvCyjWDQnxdLiGaQnkDPB0zHY5xbqKVfSnJXhcB7dD
 Hh8zE0FEUxDIVy3/YOB75qSfbRUO3URS8RFs+azfXvXfnMi69AFqnMWn3S21c7yNQDIf
 BdphqNXVcnlgFTqBK1YFdn02glAxCpZxg+Rc4axPLluTVJoVDNXvXcDLZWXBeuXh2NcV
 S+D3oE/rAWvplYaY4bdr1SgBbATws4+iMU65GS1Ra19LMpcmQniwGfHzwW1EtmHbU3Hf
 MJSTIsi0sgfDAK1vmNQEBmt6Hq9iyGzFxWZzyrANoiONaeL5ijvIn3hapRK2zCuuttju
 Urgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RitWBMSWBPvI6qEt0eDigOTixt2IEvWYEed38jkqDQk=;
 b=czHXT/V/MFZJcccj6F/+SQJQWbVVwSOYqxMlMQKIkDy7mmuGE0aqQmG1JhxBNmNoFM
 Od01mzSOwYLxpD5fddYiapnEYzZbUnyxvKDoqePnzyFFKx4ur6FahgD+DbZSiiV8oW2t
 WSVryl8vAeYgGhYQzO63yJ4H4kMzyBn/7VnW7rXVLo/XOuM0agUxytaQW6Ph073d4O+M
 /++DdfIK2c20OnLOnzBAj6ZNBnjSSXe1ZUTquP5qBxZzcP8z7BhfAWBW8NihsBTJZtqb
 +66hzu47SaQ8EyKxmChW9vx/L3dTye8L3tyR5MoXk688bG4lphGfVoCPPZau1rAVqUb3
 PbQQ==
X-Gm-Message-State: AJcUukc/26aPqAKRLoOnj0xKLUCIDwlQdyMUGzrpVUYGWppaSctAEWEp
 gWUzHTiVsZAqZ8+ZjitJ9oeCVg==
X-Google-Smtp-Source: ALg8bN5/wXpXHBmjpa6uaVJbNlvOaXi13sZXsS1I4jwvWAmfVak2Kj5qidNIb+OdDhaNktPzKTgSvw==
X-Received: by 2002:a2e:3803:: with SMTP id
 f3-v6mr21893622lja.169.1546292097503; 
 Mon, 31 Dec 2018 13:34:57 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id j18-v6sm10295353ljc.52.2018.12.31.13.34.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:56 -0800 (PST)
Date: Mon, 31 Dec 2018 13:16:52 -0800
From: Olof Johansson <olof@lixom.net>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] arm64: defconfig: Re-enable bcm2835-thermal driver
Message-ID: <20181231211652.bcosbp5awullhucw@localhost>
References: <1546016003-7572-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546016003-7572-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133500_219803_84E3B1BE 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 05:53:23PM +0100, Stefan Wahren wrote:
> The bcm2835-thermal driver was added with commit ac178e4280e6
> ("ARM64: bcm2835: add thermal driver to default config"). Unfortunately
> this was accidentally dropped by commit eb1e6716cc9c
> ("arm64: defconfig: sync with savedefconfig"). So enable the driver again.
> 
> Fixes: eb1e6716cc9c ("arm64: defconfig: sync with savedefconfig")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied to next/late. Thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
