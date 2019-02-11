Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631ECC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:40:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BAB20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MTUDTs6x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHcTe/v4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BAB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lIXWJnS435O3xu4Ga08U+cTYV9QnGOA6EH5Ezz3t+OQ=; b=MTUDTs6xdSukFI
	gHAAxIRQoeWMZtO4Qz7CRffVUYkxB8kJIqA5oRGn7vVS4mZQ0O76EiiC/hZDw3V8tsy+LQTb5WJuh
	89HPs3vpGrw1Ji9jekbzOQtYGw2lNL8fYw+ghR2bVguiIqn13VOeAyNJ12Mf5m8/3OPhSyXOeGDnq
	WNdzPQEXXKaPro6onEfyD8RorXvN1hVqsfVUiIqfcZQF25lgBCMaGRVK2FN6Tv/3/ya6dYSSKbk5L
	UJtCx5cyF0gOI1bV6bNoYBO2zB6516r2XW0Z6he3KDH26cvnrEG1n/rfvfZjPZgEI7xxd/RBppJMn
	Yh2IU0nZF1NhIt46XnjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt90V-0001Pl-1U; Mon, 11 Feb 2019 10:40:11 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8zs-0000Dg-I0
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:40:08 +0000
Received: by mail-wm1-x344.google.com with SMTP id f16so16338344wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MSMeJ85hCnV/mBF9GGGV6ArWIiKHCHYp6BfRp6LTcvk=;
 b=GHcTe/v4HLTE6/ZcIf6lGV4ciNnib00F0miBQKJ/h849hGbvpylts6FbdNzfzkLCoA
 kEZJZgxvXWR05iwQH6TglhLsW3luSoxuZSoOafur7xRkm+HucfsvvvyhrGCleinsdB7a
 kOKt6ePQGkkAvZgLGpAqxiZYf0kHWJJX9HQmrFTSGE8lrjQx6tIHXY3u/qip4OWoalqb
 n/9ukgVhnW2jvZYUZ+dkiFka5KTup8rI2fD7QxHZWg9FtOJS57KdgEu1/QdFsDsQrA7f
 f0yTITJvlyuX9LZ89piQz+46mR2R0uLfipoujrOoIEPaGnhfgup0ylO/7xEAA2KaP8sa
 Q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=MSMeJ85hCnV/mBF9GGGV6ArWIiKHCHYp6BfRp6LTcvk=;
 b=KuRAYE6iIBZM6QTYSK38t3gTCUMfUnVMxw+qbQvw2NM8kwVpp/RrSR550Q2bBUY24i
 jUF3jKYBIdX82nC0pGUru29K83sv6DglKZV+sPN/puQf/LEF7E51+VHQMw2UH15u7FDm
 lFd11u43n77P6JAzg67BHWquiHjkNZS/4+qXJW3v4z6b55GIS+15FTpKQPMoq6xssFhA
 mcG1Tm+OOMsUbSr0Rcq4gAaHtsTospqtmvpyQoI0zhmQl22ccRHsvsEFBByy6FG7Y7fm
 9/U/F7S5dFap4AXlm5AIl0eWSnIJp3qhfUZYKKO+UCYIZbANowcFClMksNySrentJbOW
 uZcw==
X-Gm-Message-State: AHQUAuaWhPhe/hH4vPj8Ig5fKH3Pvi/TMLR2xlOxQPRAAIFkVrou5PoU
 YPZNLQuGqJfsgHrAZ+fCoKc=
X-Google-Smtp-Source: AHgI3IZf3wahjDIx/L7PG9L3qJubpkc8NKYYmZR89WZekk9Sg8y67JBJz4VnSSQGjYaDrsxP6nvI7w==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr20556355wrq.273.1549881571132; 
 Mon, 11 Feb 2019 02:39:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id r12sm10477719wrt.76.2019.02.11.02.39.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 02:39:30 -0800 (PST)
Date: Mon, 11 Feb 2019 11:39:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211103927.GA118071@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211071159.GA55579@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023933_263541_170150F6 
X-CRM114-Status: UNSURE (   9.37  )
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Sounds good to me - I've merged this patch, will push it out after 
> testing.

Based on Peter's feedback I'm delaying this - performance testing on at 
least one key ll/sc arch would be nice indeed.

Thanks,

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
