Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:36:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB712133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gXOJ1P/4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sgt4mnTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB712133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YwL+vCTif0VJi8tJklyT9oFi2GwY1MIpiOM0J86soHg=; b=gXOJ1P/4vdl2fN
	yMXEnY4WpVogjJ3VELaBFz6KIZRDe7fh9fdMFpMufRQX/MfCOzGHGYDdno7rgIYCNnpZHewTTR6Yx
	hUVrtN5cT0fxxKT1b7Fhb2UilHjQfXhw3zDmWt1eWxoNEPrLDLNWQkj5ZwvwAImD0VfYa2rGkA5it
	2jSnu4jQERdaPD6GJ2Q3v7kNLT7OjRj1WbXOPGabL89NYyMlYjeQfb6VJ9lKuv3EjXZLcI955RdYR
	xPc3+EipGqADAj5ApvBsigGcRPaeyO3++hV+CA/DDdeoKUl8WSDm1hqf+otfGO64XXyyB/wO6Tq5A
	fDKJnL/8f9ujQYxpW8bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giElv-0005oL-Ci; Sat, 12 Jan 2019 08:36:03 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giEls-0005nM-Gh
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 08:36:01 +0000
Received: by mail-lf1-x12a.google.com with SMTP id n18so12468994lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 00:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=3q7lzdIPWxxxW/s8m7SmbDe4eKvvGBeobQNyq+dkjI4=;
 b=Sgt4mnTZ6p7MnjbRssML7ifoxUYjM5i+ZJ13JlgknPaUHjcoGT22+e2jwVKm08kLMj
 hqUZJ0jZB29FRnmwB6b1SHDIXcyW2eTX2d0W4VyzBGBgO4d6pWm+pGEEt733sXOcJ1ep
 D4JN2FatNMNS1hZxCd4ZGrc+/CIpuM5h8PX5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=3q7lzdIPWxxxW/s8m7SmbDe4eKvvGBeobQNyq+dkjI4=;
 b=bxy0v9ag56HcRMZBpETvJcoKEohEkuNizl4/j5mnMjs15YRDfZBzWPEn00uIiKmH90
 QTNEHKJVZ3VRAFqT1zNORH6+ZjzdMbImyOToQ6BPhCbCjTc7nftDvQvvJmcpIEDj8lre
 mWfHteye3TCwBrY3Zcq3h+vEBE1oIsMmiP0mI+2zV+d6OPTEJ+DrcZSH3nczfd8eJ487
 LxUrRjWkgJF0QANq4tew+uOEl6+zYpHAdAI5XFUS6vcG6vP9o1gVy0IrUPD71T/Cxfl5
 oGMeADt+/oQufdGDhsqis7Ap0jmjoYZcdj1hfTQAoZ0q5nTB5X13AxW/iMba3NwiT++1
 jRwg==
X-Gm-Message-State: AJcUukdHw3rZtUOr1m54cgvwJ9c5kuY5XStTUbJv5EooLJZV/4VrrsFl
 gisFCoNg3Zd9MR/8NunQC/V7O35PJwJuMb0lGiKtyA==
X-Google-Smtp-Source: ALg8bN4/7Lg/P6ylvdAhQ0R7XBdlQrCYrqCaiuEozR5w/rzpKMByNsSjN6udJts0AEZtKQnCnxwz4dFMjGEOeyB0SYA=
X-Received: by 2002:a19:c801:: with SMTP id y1mr9301458lff.53.1547282158437;
 Sat, 12 Jan 2019 00:35:58 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 12 Jan 2019 09:35:46 +0100
Message-ID: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
Subject: Hilscher NetX mach-netx refactorings
To: Robert Schwebel <r.schwebel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_003600_563733_A5B03C87 
X-CRM114-Status: UNSURE (   7.20  )
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
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sascha, Robert,

I am looking at refactoring mach-netx to use the new PL11x
DRM driver for the graphics.

I need to make sure that patches get tested on the hardware
and just want to ascertain that there is an active maintainer that
will be able to test patches I make for this and work on getting
it migrated to DRM before I start spending time on it.

Are you/pengutronix still actively maintaining this machine and
testing new kernels on netx?

I guess the second question is whether you have plans to migrate
it to device tree and multiplatform, but I'm mainly thinking about
my own little patches now.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
