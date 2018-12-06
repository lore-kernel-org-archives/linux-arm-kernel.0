Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85913C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:18:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BAF20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MZyFBLwU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QUnwcXTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BAF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ynjn4JfIexItOLfzfPCM+P4h7OvGjjet+ntL6TRDGrc=; b=MZyFBLwUafYa4g
	mttJjDEJsndyKN1226HiHi9MsCxlgxssO8Z2kRanlRxrjmBHnGnUhnQjThVVD1lvxsOf176r5SCvq
	rwAGv7OBX94gzJZ/TbvFB6UTBYvwXCSsPvWW9MZxOLArDxPKfT1QFREbt/yKqqomzXSZy+KuQEld5
	YcCss3TIL/BskmJ+NXp21/9mcD1FdsquPXWk75dqvMluni1LlQCZajPf9T6bqxhFzae+Z02/6rSvs
	cnYG5shUVG+OeVPq484uGZQVikYLt3eTFeibOHrpu2fxCjHIWQSxC1SHPWx7dkUQvO8PCrpI6usCl
	tSwP4dLsJKOGCMaur53A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtXk-0008Lb-Of; Thu, 06 Dec 2018 13:18:16 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtXg-0008Jl-1m
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:18:14 +0000
Received: by mail-wm1-x342.google.com with SMTP id c126so1008626wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=qvEUEkowZ7enJSmEeeMeIbccja2GjdxdsJU2woW3q7U=;
 b=QUnwcXTgUhGV2ArEcQHYNo7HKr6H76HhLrMpn8o/MTUJ3n6LCIyK5YQGHNXqxX+0bc
 e2Lw50PgVr9h9tGwuTytLdcwoQG0b6Qc7nNAgpiOWecp5SGQNBZiridLZI7Tui2epq2Y
 cpw9caY6cNIb8ZZxRrXoXKzX/lRoQ6bJLkHveudja3g7NDwMq/zmv2R2K6ZFPH7Hk3He
 A0BBBvAPb7Fqu2bx2gaqrJ1saNo0P9xeA0eeTLwXyo7cvHLi99kgBkJY69JPBQYdMqwn
 w9AHk8Wtnto0FaGmRIi2loPGQMTH78ArcXr4rh/jzPMaTCD6uUShM5133GfqVD/lXo1l
 FOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=qvEUEkowZ7enJSmEeeMeIbccja2GjdxdsJU2woW3q7U=;
 b=T8ZClkXVebPJP5J6BeFMR0YAGmwYFSZmFiLaIy+KxjcXd/1EQmSAh81FfMRqMKTs5z
 i1oANa4fVGBM+PsIi8mDamOWOcmmAF5sFqwIw0XghADDBbI8VIWn60ayDrqc0SBAOPqb
 f4X7mzfJxZMV09WxI8x7xh/7hWsrKyfx06KUW0iN7gZ3zmX0MHlPgzVKbvUDYrfCnsWh
 Tf8Ws8QwEM0fcKWlaPE/CNvOGzyfkV8s0Me+FGHUa44iqbOIM3mse64M5vA8Fn5WTQXY
 n1p4SfXcyqSK6Xbh4kVaiJLHrWKxCxo5BNPDI1PS2MG9xJPu+SOIVJ5xUVCsPXDFuUGO
 LEbg==
X-Gm-Message-State: AA+aEWYAT/m2Hg/0gWmPtBAdDzUgjHJsQoLxXMnM0uHyE5J1+VIpLTin
 bwO94bYBY36wLHVMkUD19JME3g==
X-Google-Smtp-Source: AFSGD/VfIyWBgGsM8W0ulM6xNNrLipvBwrUyM7DMWugKLNZU1kvndDLYXN2ddHn+pGDEsyO6KQ7YKw==
X-Received: by 2002:a1c:a58a:: with SMTP id o132mr6879397wme.6.1544102280438; 
 Thu, 06 Dec 2018 05:18:00 -0800 (PST)
Received: from broadband.bt.com ([2a00:23c4:f7a1:ce00:74d1:58cb:8b3c:fa0])
 by smtp.gmail.com with ESMTPSA id h13sm433797wrp.61.2018.12.06.05.17.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:17:59 -0800 (PST)
Message-ID: <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
From: Carlo Caione <ccaione@baylibre.com>
To: Emiliano Ingrassia <ingrassia@epigenesys.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Date: Thu, 06 Dec 2018 13:17:58 +0000
In-Reply-To: <20181206124347.GA10676@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_051812_144105_185F9B32 
X-CRM114-Status: GOOD (  17.78  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2018-12-06 at 13:43 +0100, Emiliano Ingrassia wrote:
> Hi all,

Hi Emiliano,

> thank you for involving me.
> 
> I applied Carlo's patches[0] on a kernel vanilla 4.19.6
> and tested it with kernel packet generator, monitoring
> bandwidth usage with "nload".
> 
> All tests were conducted on an Odroid-C1+ Rev. 0.4-20150930 board
> with a short ethernet cable directly attached to a laptop with
> 1G ethernet interface, with "nload" running on the board.
> 
> The tests I performed are composed by the following steps:
> 
> 1) Start packet generator with "rate 1000M" on laptop;
> 
> 2) Keep packet generator active on the laptop and
>    start the packet generator on the board with "rate 1000M";
> 
> 3) Stop both packet generators;
> 
> 4) Start packet generator on the board;
> 
> 5) Keep packet generator active on the board and
>    start the packet generator on the laptop.

out of curiosity: why do you expect to see something different from
point (2)?

> Test results without Carlo's patches applied:
> 
> 1) "nload" shows an incoming traffic of ~950Mbps;
> 
> 2) "nload" shows an incoming traffic of ~400Mbps
>    and an outgoing traffic of ~250Mbps;
> 
> 3) "nload" shows 0Mbps both for incoming and outgoing traffic;
> 
> 4) "nload" shows an outgoing traffic of ~950Mbps from the board;
> 
> 5) "nload" shows incoming traffic of 0Mbps
>    and an outgoing traffic of ~950Mbps.
> 
> Applying only the first patch (change mac IRQ type) I got the same
> results.

This is expected. The change in the IRQ type is solving an issue that
you can see if the run a stress test involving multiple components for
several hours.

> Applying only the second patch (drop eee-broken-1000t) I got the same
> results!

I am a bit confused here. Wasn't the eee-broken-1000t added to fix a
problem with the ethernet? Are you suggesting that for some reason you
cannot reproduce anymore the problem for which the quirk was
introduced?

> With both patches applied I got the same results but with an incoming
> traffic
> of ~3Mbps on the board.

On all the tests and immediately from the start of the tests?

When you hit the problem con you check in /proc/interrupts if you see
the IRQ counter for the eth0 incrementing or not?

Cheers,

--
Carlo Caione



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
