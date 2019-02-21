Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642FEC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:28:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334F42084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y1XI7LER";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3m0Dcsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334F42084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gs5aM1rI/SBD58/FCyKWCk4NQjW9AoqnAcJVRGvVwBc=; b=Y1XI7LERjXcZa7
	Q59AxDSZuPLecxHm7APLOSxDJOhKeeKOX2T3MF98JmVTz0Bf1kZan9JUWIw9BkK9XRqIMkiamCkST
	RYsXJ4ckVca+pT38IRv6nOqF7X96oLnKLedpyAIf63Y7tHoddqJWwV/DFaSzauUfYVNd5s6Tict4z
	+wxWNJjQbWMncEMblZ1oKhnmZqjbPGCSmbiHU2sylbObl1xFTL/jtM1ZRhc2ORb4dLm8uBCDE8ZC7
	6jmiD4lyxQypTGExv7GmTDbiwazic9OLH5oTmQT0dXg7t3qyZB3agwWgdAJeishuQ82yNFCzI+Zr3
	CNz5aDc5OEKKiAt1STaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoP2-0004j8-Lk; Thu, 21 Feb 2019 13:28:40 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoOz-0004iA-RN
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 13:28:39 +0000
Received: by mail-pl1-x644.google.com with SMTP id p19so2965442plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V9yQpXUXsa9DaLMPn71/JplZopjBUHFWx0ET1kih9hA=;
 b=S3m0DcsqxG+Z/kOdBmYmZYskYWN9MLblqe8ZnITX1wSPP/Dz/Yjx8YTD2sB+S7TNcQ
 2cUG6vZpgQNrmBe7dmZJtbqs/iL8P7jArgclNLgsi7o3moppkpepWhJTFI++2uG8fuHF
 MCGaEdribTbBT56hljmJBoXqVw2farhLqam7bExf9wkzvoMplL3GCdZOq0IAo6iqhnor
 mKTLd8Zp8Ar++Szh0gcLddY+iIbbVReFJV0mL/h/moV5UfUQAzO+9HAAUvUMPIdKnoWi
 /3U8VqXZeOwTxKwnFffaTGTgMEwaCQ43i/KT/eEP29RcJE069zOIBgsTL+XrNrOQ+jpp
 y5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V9yQpXUXsa9DaLMPn71/JplZopjBUHFWx0ET1kih9hA=;
 b=Tcelx2z8Xe82Ctm2iE7an2ZgfFGpJlV5yZnczuFNe0uLB0kRiyrhxu7eGHwqtXPvkb
 mUGcYT5IrcSPIGbM+K1LEcYb+ZyMhc4l+ZPSb+g4FCB9IayrlRw9G43MrRNtTwWMeXNY
 LN4wbbppjYBKTbj0VLcVlKbmzguvyI//nG0KQ7Fmt7tR7T1JzgNsOp310yXIBxESowH3
 e7Jww1ryhKht0B38edm99T7mqiv8mfzoK8NcxBffWO9EvOaWWt/ub3FxfrVCVkVYES46
 qg8xl4yJbiHg6BTKA20/gpDh4nvo3uzlXj5lHu3P2j7AJYa/y3TiwK5RbCqCTv1RQC0o
 s1Yw==
X-Gm-Message-State: AHQUAuaDOYCph8ssi373n5T97SFNn2vGlxC3qoTV46KqxBljlm85syq7
 SFmdS1BsnuiQLWyBjE9cPV+YoVi3+aWNG3xm9Ro=
X-Google-Smtp-Source: AHgI3Iao+GgldUUholkBSQLalbp0XXrJCxncaqK6G2hqZ4tfkYa+X7A6Gqm8Z1WBV7uLY+8/S989aAvi4VPbFK4I4as=
X-Received: by 2002:a17:902:2468:: with SMTP id
 m37mr42719939plg.314.1550755717071; 
 Thu, 21 Feb 2019 05:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-7-lkundrak@v3.sk>
 <20190221012231.GC5838@wrath>
In-Reply-To: <20190221012231.GC5838@wrath>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Feb 2019 15:28:26 +0200
Message-ID: <CAHp75VcWMf086oGrJHWOCgYFy-J-KLw+jzFoAwuXaHtS7dgdvA@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] Platform: OLPC: Add XO-1.75 EC driver
To: Darren Hart <dvhart@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_052837_913442_B6220D6D 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 3:22 AM Darren Hart <dvhart@infradead.org> wrote:
>
> On Thu, Jan 10, 2019 at 06:58:41PM +0100, Lubomir Rintel wrote:
> > It's based off the driver from the OLPC kernel sources. Somewhat
> > modernized and cleaned up, for better or worse.
> >
> > Modified to plug into the olpc-ec driver infrastructure (so that battery
> > interface and debugfs could be reused) and the SPI slave framework.

> > Basically all of the above is based on the review by Andy Shevchenko.
>
> Andy, I am happy to merge this series - but this patch includes a lot of changes
> driven by your feedback. Are you satisfied with the changes, would you like to
> add your Reviewed-by?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Open minors:
 - u8 vs. unsigned char in a cases when it's about command to send to
HW (including unnecessary & 0xff parts)
 - _TIMEOUT w/o units a bit odd (perhaps _TIMEOUT_MS ?)

I think this may be addressed later on.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
