Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE11E2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnA/Y+Qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11E2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2q9aQB2IoHlGUxZfMfbGFIGZYXmeXHh5Zv33Od957TQ=; b=NnA/Y+QfFOaVrm
	OEzwLcrm6v/PbUk+g7Ga+LGXwRb+i+2s5S+JumWN45zdTMlifNAkMKiKSjiEW395O7Z3WRqBhhJX+
	3EiBLGzMjTzB5TUxyZgEMl1AbV8muhG0VhAytxr/1xqQpWUQOtWr+Q4oy7cT5tWsXh2H71flzCNdL
	PZqL5YQiL3qs0pa/kVUNbfj9plbs3AuI2Z1Li1YzuW8CFSae/x08frDEJZLHK8DlJD+WjZgeB37RN
	Jes4Uwhto/pnDu3LE47zBN0N84ZRyQnEbim07GAyDo1l+uJZg3OKF2+dLZKtrQ+7fO0InqF/FskbC
	JsTO6mHYKNZ/0VbCJgeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufCR-0002h5-Px; Fri, 15 Feb 2019 15:14:47 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufCN-0002eI-OK
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:14:45 +0000
Received: by mail-qt1-f195.google.com with SMTP id j36so11186567qta.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g6HlYCGkavTor4Pj75JCcyYySifJWasU4FHKdrdWRQc=;
 b=QmGi6v6S2Sth3lkknoGVd/+kDEVlsOy/UMpGaUpsl4hjDZNiaoD1narPYT6lb48rRG
 Jm3uik2H7YZaewR5i8x3HYloNob8gHiQtiOFIXWFGYq5NFaDWqapLsRYzyw2b1ng7Mz8
 i/B7yAk8AZ4sGHoUeK//jarBI8ss6jFKClJXqi8UcaqDglUPm+Nj8BDkwuCNe0aWp+N9
 BSJKVCXkzcdnzMTbOy7cGp5EoVua10vJNtFQpmdWqq7RB0rkWG27YWnevTSMS7BjMTIb
 OZQqyGwod8V8azMxE35dpq8MRzsbensCz01Ym0h3v/hbQG2slVsGZcay/uv8oYmGLN8f
 fiQQ==
X-Gm-Message-State: AHQUAuaG4wGZ9xhV/sWX0mKV8ipVF1FXE2me7DdSKwKUsTg7x2snMgpc
 FYaMYSE+wg/fcyAlAUrCQZUs82Gcx3qsSTIlpp4ImA==
X-Google-Smtp-Source: AHgI3Ib1wtygyncDzVTYyCGG4NWpbK3xU8Ow2xxKOcG7kdJ3cUZnAYoqfcjan9+YMLtMoWGaOfUK/dCI6RS4Zg9Jhn8=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7815279qtl.343.1550243682681; 
 Fri, 15 Feb 2019 07:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20190212192838.GA12677@piout.net>
In-Reply-To: <20190212192838.GA12677@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:14:25 +0100
Message-ID: <CAK8P3a3naMESA7-4c3HSWiiS9QJvPM_TTzLAf4_ge_zeZrG5JA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: DT for 5.1
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_071443_787980_70FBEF05 
X-CRM114-Status: UNSURE (   8.87  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ludovic Desroches <ludovic.desroches@microchip.com>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 8:28 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> AT91 DT for 5.1
>
>  - Enable QSPI NOR on sama5d2 SoM1
>  - replace deprecated gpio-key,wakeup property
>

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
