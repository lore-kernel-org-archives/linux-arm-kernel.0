Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563BAC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253782084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KYuDsJwC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="T99FAEam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253782084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pEOtwa1OXktY4IiEGHGNEnWtQwEESI0Yb9DUzUMM5Ug=; b=KYuDsJwCdeHWWi
	9Xr12wPWbW6HXMvB1OQB94RD4oFZyKi1sXc9wwdpov2i3YDivEJ+xdMp/SmKaGpA7ddAUfp0cELCv
	1DqFQ6iq81WGtNXjHOSlo+rkWV/dGokx6J4Gh/L+orrMSIlBKadkZqk8PK3NPkF5SFkmnHoQVOwIF
	V7Kiwkc6oozZdbp6EUdcahTDf98m5iVbcWEqfScMqHb5ttQyAouN4i5xFpjQQF1AEsmi8EWG1tITr
	BPJrh6D9v6i+I6zJl9c7yTPpwdeSuCtczoFwtAFVtTWn51gMVBeFeO3rzslCA5AtatIKSeWELct6S
	4KEgGCNl2s42FToGrJYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCoz-0007xF-Lt; Wed, 12 Dec 2018 22:17:37 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCnY-0006SL-AG
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:41 +0000
Received: by mail-lf1-x143.google.com with SMTP id e26so16899lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pK5tgqfNqgPP5xIorS5Llvi/2pYzuE7zgs0rf8j2Xko=;
 b=T99FAEamdB3juIYYGkDmqmGXfvIZPgiXRucteCkiFNRV0EfQ7s6DYHhUetrOpaWppK
 ymuqNz24/brMR+PTQgvmvkJA+upxVKS1c8Yy4259ELoJa45hm4MZdXhIx1tJMKJJuCW4
 gRFR0EWexX0D5PPFH+3cQEEOyl7eOCyPsYodsg5rdiSR2tn0IDkinQ5dewqLN7Ouz/gI
 7wJstXOYZRw9xTgU3vHKyJ2j2QyT9L7KZxgv9DAd/7Cnl1XJT1Q8mC+6HOGODaHC9vt8
 /pPzLEC//Rsza2Qwbnb305gQYLZRIbuErWDFofJ+IvAYYhZfDc5B23cgfdBtMV7IhiZR
 YRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pK5tgqfNqgPP5xIorS5Llvi/2pYzuE7zgs0rf8j2Xko=;
 b=rnDFBRwKDTx2ZBA+pjai/Hq9KEzkcW4JUbqGy3anIPaqHPHDhuewWpMbYS8FxiGtCw
 CwJgRhLIydmxzK9YScZACZ1zwxVNSXSEStkD1lJgBmx6PDR2v8WCkRoyd19K+1ZYBHhZ
 spmIPkjAAbbqDtBe3KLgHmDDlSnJf/DDYTkpL82KcemYNip110Ms9SA9pKAfFBtwXz4k
 BVPweC5l2+vm+mDCg1KnRD93c9fm8jojkJ07CpUs6GQJ13lK2wvoMhAImUyBl6kjWfsD
 sUGC+/dRqOGPIXGqpA60NGyArw9KjRwnIRN4V8nwUdK8ZoR0ozMFG7lALYxSS/iqnDMI
 DAGQ==
X-Gm-Message-State: AA+aEWY2wflbBmn99FqK7IDse6/XFCsoPNPe0kmkV/2x609U/vh5VJax
 Q39EhJnK+I8B1Jbwn0eJj+1lYw==
X-Google-Smtp-Source: AFSGD/XkRIoqJLM4j+DRHg+aKbwceKEnANRJHmwtLeBZFE9hMhqCNgUexmh88Zfy5akDNcicI5preg==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr12181361lfc.47.1544652966552; 
 Wed, 12 Dec 2018 14:16:06 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 12-v6sm3482037ljf.96.2018.12.12.14.16.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:04 -0800 (PST)
Date: Wed, 12 Dec 2018 13:38:57 -0800
From: Olof Johansson <olof@lixom.net>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [GIT PULL] ARM: at91: SoC for 4.21
Message-ID: <20181212213857.s5whr3khftogkk3p@localhost>
References: <20181212124330.GA27581@piout.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212124330.GA27581@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141608_774970_2F990659 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 01:43:30PM +0100, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Not much this cycle, simply adding new SoC/SP ids to the SoC detection
> code.
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-soc
> 
> for you to fetch changes up to 446e8986a2417148aed14f362831bf2425d434cb:
> 
>   ARM: at91: add support in soc driver for new SAM9X60 (2018-12-12 11:55:20 +0100)

Merged into next/drivers. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
