Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E49C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25C62173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E//zO+hn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/T8D2EB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25C62173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zAPC/FmuyXPFuLtRqCVGNCz9s/uLdPwwGlwRWdYvkIw=; b=E//zO+hnBF6VVe
	VTJiiikMONm6my3nbQws9XlWd1xPQ8mUOlrc3h8goVrttvKfTShm/M+VQl//UKDq/b1mbIWSRKzFh
	WAsteobE3YICtGw1LnSUgIYtX4tM9Ctel7znEXNl0/5qjXIij/yyAHhvNZAFtKgdx9j97NvzrEZMk
	fIH/TzrlujfkgtRApKmI6FFG+5g7VR+VB0Sthf2NQsRv7z6TqX7UaIDx4oLptSZG355qErVI/43CP
	nDI15XEIVANXAp6gjDUvF8lRkU7Q5qJ7Qq8JBLhe1LdJNcI2iosQ+6FiXKvhawDEYYJJ1GMrGDmdI
	c5FBtav7sq5CL7wZ/Kkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXGS-0003y6-Qy; Thu, 10 Jan 2019 10:08:40 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXGP-0003x8-0U
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:08:38 +0000
Received: by mail-pf1-x442.google.com with SMTP id q1so5096570pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KsrA9e/YTY8VQx623WU53BOyh7sF7fPNsmII8U736wk=;
 b=c/T8D2EBoGXlytaOCb3o3IkZpl0F3ysP5Iuy+oaORbZJvqL/rgNd/yDbBYyskw/wH9
 ovoAB//aEQhWx9uP9GVy4/uGcSDa1ovU6Lr57yKsFAqhoriHg2Zi7aUZ+BbSk5E+qzio
 1BkEC5eatIwR1kaXowazAeQNx82MBIZYXtsoYZ7Zd6dScbUkbCJxhTq4t+Jugeersg+c
 pIs7e6xoDR/ZI6rBfOzCnCqXIdMM0iuQYQVBESkR27NF8K1GfkSwZ2olycyk03bOW038
 H6RAcS8hcLY7MKAN1OWp2BMOZ3o4OHljVaXFU589gVgxC8QtXmFtHeAOOSgsibT+F87h
 UoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KsrA9e/YTY8VQx623WU53BOyh7sF7fPNsmII8U736wk=;
 b=tLmQO23DGTn8WeVfAI4yVEFGY1H6SIBX9cAfrCBSxLTxfvJt1fMvaOq7JLZiP7xE5e
 iMQ5HoQUTn/BgAjNKaNuxYaSHiaRJPRLsvy+2EIW7OqXJ29Jj8Bw61dPlNSIfDFoFac6
 7Li5ov7XdX9Us67pNDwWJf0N/8seNdbYQ6l/CdAnFPr8ChoyNLH2ijP1h+OgbVxleEu3
 vy9q+TXGZhy66APu9VRknc90l14Ks63sNZlKNrfrnB37xf2BDgJw2rVTOZj3BSd/waoJ
 N+jWkrWm6J1bcJR2lg85kHzHAto5urrvOKcfhh+GIxP/7Vza8ZHET0Ma5p2FAFMQxTwO
 p2pw==
X-Gm-Message-State: AJcUukfPBtxWEGvqlhRP9v56UObaAAqCYyLfW0ICEMc6DrhjKHT9Izie
 07PYkGFxTV/rUaYpJPmRdi9HR4Uvm5BdDDLfTWA=
X-Google-Smtp-Source: ALg8bN4rBVq+3np+gX1aEH+u8PCBbjM6K/wi/3UCkYIn92/TQ+l0M7seYzA3jkgwQwdq+Q/kANsj5RNS7EdbORgXOzI=
X-Received: by 2002:a63:20e:: with SMTP id 14mr6585701pgc.161.1547114914523;
 Thu, 10 Jan 2019 02:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <CAHp75VcDXmARXAyE1tPouj0cLqg1Ohs5hq+LZ7dsoGY8pJWO2g@mail.gmail.com>
 <3b9c5e7e35ae25316bf4551ebf7ae21238d64f03.camel@v3.sk>
In-Reply-To: <3b9c5e7e35ae25316bf4551ebf7ae21238d64f03.camel@v3.sk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Jan 2019 12:08:22 +0200
Message-ID: <CAHp75Ve2RZqf71tapmGQpZ1YtuKmEHe33k18k9Tg-7RExWQY8w@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
To: Lubomir Rintel <lkundrak@v3.sk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_020837_085401_AEBF8AFC 
X-CRM114-Status: GOOD (  18.13  )
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
 devicetree <devicetree@vger.kernel.org>, James Cameron <quozl@laptop.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 6:37 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Wed, 2019-01-09 at 13:15 +0200, Andy Shevchenko wrote:
> > On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

> > > Also, the 01/15 patch has been added to allow the module to provide
> > > a
> > > reboot handler. Patch 15/15 depends on it.
> >
> > Isn't it a quite big distance between provider and consumer?
> > Especially taking into consideration concerns about patch 1 which
> > blocks the series.
> > Perhaps you may drop it as a patch 1 and do something on top of patch
> > 15 as feature extension?
>
> Yes, that is a good idea. I'll do so when I submit a new version of the
> set (in few days' time).
>
> I think the battery part can be split from the EC part too. Would that
> be a good idea to send them as separate patch sets next time?

Yes, any independent porions can be send independently. It would speed
up the review and applying process.

> It seems
> to me now that they probably ought to end up going in via different
> trees (linux-power-supply vs linux-platform-drivers-x86).

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
