Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24DCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C272A20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qt0chrfW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="HQxjZc3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C272A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bmallxYgWRJp1zqTQnP6rv1wB5S6KK/tajISSjiF9u0=; b=Qt0chrfWNq3uZX
	3a3DdImhxVZ0lToTlJd+bCt1ioHf776W7ejLG+uqX0OThQLMTOvG3zdw5kR14P9u/HAVf7XqRP3gl
	o1YTObHG4heuUMh2OzQdNMjreFSJwsftBfXUXtAJfX2bDqYGB+KF0khvGqpmDZ6oqCR4G22ACayUm
	t5dUlwet3Dg+TQ6xOz9bM10aOGDb++piemahD5EE7UNcD1BzO1MdryvfwjpHty5aT0JfpsObpgRAY
	+5nXCTAm3Kvcu1IsPBrNTjVq0deOqGMsBghSzjKDHghg5PM74rDFnK0j3ZQJyQvWBZjVLemesxmr3
	udp+v+D7+49uC2ap1Bgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSrjZ-0004v7-EB; Fri, 30 Nov 2018 22:58:05 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSriE-0003vv-SM
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:47 +0000
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so6374360ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Yf80AYAGbNF/VV8a+obR4j//I3S0TnIGRDbMxYtJRz4=;
 b=HQxjZc3/tv4b8LCmmzpi0IQwv1WRyXo1avsu+JtLOWPf5FjnJN9HHW2wT+nCA7Y6YJ
 yLHeN1lnpkgFELgZeczhYQReeJJZ/yqTymPJcbNEcrmxWZOYkoygahhejouUbkYXPLaI
 IWKRsN6FGRfLtIOV/NoLd0E+1+ZeqF8aOCDdt0H0/471pJC/D8Gysc4b+twSznvz8ljL
 TZLytoK7PbanbzhmW1krN0LTaqkAej6UmlDtzr0R/kIKJwMp/snnqwOQKbZBd7pR9jHH
 cDJAoUscS/LihyjKauQBdQv5bMbHGC83KDuSi2Ngii8qG9gEKWQ6nTysiFwO1eZKjwqY
 Mt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Yf80AYAGbNF/VV8a+obR4j//I3S0TnIGRDbMxYtJRz4=;
 b=WAg9QY6rWNxe1Htx1NgcKu74gIFm/QGuY20BM3ds4UGRNFylzBgoHX23siK+jpqIQs
 K7QhOT28U48GwBrFKms28FYdUpSF1J2LpTtJDZsXn1sYm84hCnuvugV+IbhgN9VZLwH6
 +h0Xk6NfvtvPw01zLieOIDtNnKQdiVBq2MjDzpa3EC4+wgtSOEzLcQO1qJoK+65hoeNl
 Oi67BC4VB5X1sko97BLTfKf1eYaZCoko5Oqpmp20IgN+MCr9U7esTzSjJlYB2lw79U+q
 Fw4pBoNPUtagULFnDMZiRx63nZzaPHyGC+qOElMy2egZGkpH1y9l3ekDENCz6e/ThgLv
 2ohw==
X-Gm-Message-State: AA+aEWZSs2gTUC4ewJ95gADsnYU7uSXqhZ/eUM/ZIwj8cGLFFyFD69Qb
 RSTLmafy0vUCx1cQGOObfIeg8g==
X-Google-Smtp-Source: AFSGD/Xv3BUCGI4h8AxPixseNigsssDYbBzdQkNA2ZOOKddbz+dH9LO7D9Rs7GVhOXNh9xRLdKfjRA==
X-Received: by 2002:a2e:8ec8:: with SMTP id
 e8-v6mr4976889ljl.162.1543618592778; 
 Fri, 30 Nov 2018 14:56:32 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id j126sm1045107lfe.10.2018.11.30.14.56.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:31 -0800 (PST)
Date: Fri, 30 Nov 2018 11:55:16 -0800
From: Olof Johansson <olof@lixom.net>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [GIT PULL] DaVinci fixes for v4.20
Message-ID: <20181130195516.t53j6ui7szcvq6uf@localhost>
References: <fc5a2899-f847-5193-2406-2672713aa400@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc5a2899-f847-5193-2406-2672713aa400@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145643_507055_066B1FC2 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 05:48:28PM +0530, Sekhar Nori wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.20
> 
> for you to fetch changes up to 27df7977099c2b8d32399cd1752f527c5a343dfa:
> 
>   ARM: davinci: dm644x: set the GPIO base to 0 (2018-11-27 13:43:27 +0530)
> 
> ----------------------------------------------------------------
> DaVinci: fix GPIO breakage after v4.19
> 
> This set of changes is needed to fix the broken GPIO support
> for DaVinci boards in legacy mode after certain changes made to the
> GPIO driver in 4.19, namely: commits 587f7a694f01 ("gpio: davinci: Use
> dev name for label and automatic base selection") and eb3744a2dd01
> ("gpio: davinci: Do not assume continuous IRQ numbering").

Hm. How long until we can remove the legacy boards and move them to DT? Is
anyone working on it?

Merged now.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
