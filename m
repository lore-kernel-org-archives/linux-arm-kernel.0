Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55002C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CB520892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZIrWo8wd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=laptop-org.20150623.gappssmtp.com header.i=@laptop-org.20150623.gappssmtp.com header.b="TBcxg8Wv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CB520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=laptop.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jpPhFS+gAgr1saUxBLvSAGtgFUhvQOv2VqUrPfzeVEY=; b=ZIrWo8wdqV/uTy
	n4H7RPhca3Hq3nhjBaTRQvcIOdWt5Afx1bkBQIctuDTlaSdjy+LqxT58LuESwVkw3lb4fKsJJnPXL
	olhNR0KkezNhZnSzj8BVI9d+glZy0l1h1Ni2FayTiaLzvssJAEFDibHpYJMY8ElZ1dHAUOlNE36LA
	ugyND9KbqG02Ww6tBge0zOgs6BOCr6k/VahRJJia6SLS2bejWZIeUJMezbqxZG9SBWKokPLPYVBg9
	1gZRLiqm8iKhgvp0iuo4ZiqDWBdjx7ZADXEXvwTZzZC3ZzxoZeziFyD1nhU4CMi0ojcBG6rpzidit
	HCpFKCbmpu4zN4pdNhYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTb6y-0002g8-EB; Sun, 02 Dec 2018 23:25:16 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTb6v-0001Rq-Ak
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 23:25:15 +0000
Received: by mail-pf1-x443.google.com with SMTP id w73so5379827pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=laptop-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aElEMZ/2oXcO1UAaewUAxe9TlLURM5XdAWKdXdvBChQ=;
 b=TBcxg8WvJzWZ9PUCBRwSB/vREyo4LL/aQVqsmUSpADVh9bUS47ZSHIAmZjtdwd7V3r
 R7PB5LQCMzXKUcagdT3HVZdKFVPJ/R0cOM+WuHmk9I8COtt+ovKQQZOcTIJLgiBchWcP
 TcR6A1PJ6FlBnwU8fu/7mo3e65R3u7jhvAFzWc6hvDU6xuz6DFgVC3WkRKIpK1RdV0F9
 pCDj76/OKgi3zPDnQ4hZY4414iJIrUpzlqFBz9retvY/O4M0NJYF34msGKZYcwvrg5cc
 TnG5VrVXWjgsZoTw4ZfHwxOME4WYZbVKf0EDwcqTGz4MbLu4ounRckUXeCHCr/uORRjp
 zMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aElEMZ/2oXcO1UAaewUAxe9TlLURM5XdAWKdXdvBChQ=;
 b=KzvM+10IUYSicX5mKOpRBhqsKaMR0t6lzDOU5la8PGEFF4v50lEwLfpZgmZ8YT4Sbm
 GSnTTKaUHz9YgJ6G9xkd71xWUAT5yNrMeaq5SUb8tX8NbNgyfO5VfXI+rWBIh1+UoVFR
 imQfqGSlDzfKnqG9HZ0Y+8jlvk7FtHfr2YDMMAB7GThFxFYAOlc+o4MOZRl69aCO6sO3
 /hPXCiwwcYjRqTDRlFpcyg4K0jezjJZwPrxagQKYU8hyq31oE1BJKdxTPcfsInt2zIWX
 JFLqayo0AiWcTHN1gjOKh7NhLIEMcy2jrUpIS1uxZ2hfN80hX7kJNmVk86hgoLTTm6Ap
 AJzA==
X-Gm-Message-State: AA+aEWbekvrk7i09/yzuchJN9vFyNM11TPU+acqMLQb97r9+SSLQ8d7I
 U37T+8PeuAi5YWJZtrIp2btm1w==
X-Google-Smtp-Source: AFSGD/UjAuli8dvY09Ns+79X/Fr0cD1UrZUTUuY8JJ8L00KBeN8Wk3sQfWqweBDT6yQHCQHqu6sDKA==
X-Received: by 2002:a63:d157:: with SMTP id c23mr11392358pgj.170.1543793101653; 
 Sun, 02 Dec 2018 15:25:01 -0800 (PST)
Received: from esk.lan ([1.144.139.38])
 by smtp.gmail.com with ESMTPSA id c65sm26657231pfa.90.2018.12.02.15.25.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 15:25:01 -0800 (PST)
Received: from james by esk.lan with local (Exim 4.86_2)
 (envelope-from <quozl@laptop.org>)
 id 1gTb6e-0004gF-9K; Mon, 03 Dec 2018 10:24:56 +1100
Date: Mon, 3 Dec 2018 10:24:56 +1100
From: James Cameron <quozl@laptop.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
Message-ID: <20181202232456.GE12222@laptop.org>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
 <20181130234424.vx5y46wqvziywbk2@localhost>
 <20181202222930.GB29467@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202222930.GB29467@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_152513_396502_28F90D34 
X-CRM114-Status: GOOD (  16.61  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lkundrak@v3.sk,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 02, 2018 at 11:29:30PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > The patch set has been tested on an OLPC XO-1.75 laptop.
> > > 
> > > Excellent!
> > 
> > OOooh, I have one of those... somewhere.
> 
> Time to find it :-). It is still pretty great machine, can last 8?
> hours on battery, sunlight readable screen, and if you meet a tiger
> you can hit him on the head with it ... and it is still likely to work
> afterwards :-).

Yes.  Best configuration is with laptop closed, ears locked, firmly
held by handle, and use the narrow side edge to hit with.  Users have
tried the large flat surface behind the display, but the display tends
to fail after five to ten hits.  It will depend on the tiger.

-- 
James Cameron
http://quozl.netrek.org/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
