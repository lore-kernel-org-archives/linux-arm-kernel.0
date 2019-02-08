Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977CFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:59:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BFC21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P8qlNAd3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OyX0wzEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BFC21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zCDFOkXWAG2+RfjxzEWpSg4gA62nIh6xv4q93j1V638=; b=P8qlNAd3mba6WJ
	4dxvO5dEnUElNAlO2Y8qbRXnvcLCc6F8C5GZNWPOeoEHrtFJGAxG2weTlSvYjU7P+hkw0hLOLzqk7
	1EFFT6zvhM5HDqwcWEQplCzV8W72Gvsi444ab8XYo51Jf1iE68cHuueCfPnv7SwhhNDzpLH/Qhrnm
	rTIyp4vPc5552CeLwYrVs7rffohyHUJw5MW6N3wjL471TGHEBLI0EIShHccieb63CSU67wZI55JKO
	aQv8fANatd1HhjT9aPKlcR+fxYXUmZx4FQ0fiwOpWuU45u5p4TRBY4oqSjdperxPg+IhDkG0maP5V
	MU/BumKPyWoj+h2ulpnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsCIj-0008N9-J0; Fri, 08 Feb 2019 19:59:05 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsCIg-0008Ma-LB
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 19:59:04 +0000
Received: by mail-lj1-x244.google.com with SMTP id g11-v6so4052510ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qOYQNrLIv4ghYg9cJs/kFayOVviMNWKea8x1M/btUwQ=;
 b=OyX0wzEFwz/6B3oUovySoSdj87UyroJwU08G3xNJoOnjsbu6Dq0hCgkf1L42WN6nW1
 jwoJPZp5H1TptNE7ujv4YSzeQ1S9iqAxD7F1/8fIrL0nE3FasZpSYcLqdNGwta+XmVQT
 r5DkKnmqomQZhOV3nS7bhb+cUUVEYNQaa28wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qOYQNrLIv4ghYg9cJs/kFayOVviMNWKea8x1M/btUwQ=;
 b=fzu/8ZcBTKAF+WjR0xPq/oOW+RzwlR+1ff1PBU5XNOaRhgAYX1WaRVSSLwL+7oaJdu
 WucyXuhSP42d+/MvKaWbAs1+5Sb2/cDxe1uaAd9KJ76bFrJNb4WGkML1PLE2/WuiQmwN
 +hV1iIG+pmn34kbINbV+0RR3WuCH5bVwB0/HVjXMr57cd8XPJp7qhA4P4UYQzosXD8Dt
 7hR8yf9A7uUl2nB3tf3XLonMZ6kR4WHeURdh3FiP/11AEpJLBMkSPmlslBahS9TvEBTX
 rFctj+URO2TmDoShd+a2rDnmCanDwmxHPUSRevWq9EZNuqQ5d/EEy9dp/kSS0inU7t4H
 /KLQ==
X-Gm-Message-State: AHQUAuawDdTFSm6maVKuN5t0EAcal5cqm+vjHAXpg78Qb5FP9OfdGnmE
 wOsPxoRPcvwsQlAF08tRjima7t8GV5d3NQ==
X-Google-Smtp-Source: AHgI3IYg10nBlshEwM324p10dR1U6x3jByVZYaNMT7+uiRiu0HxFqiYa9QH7QNYYCbwoRdPIhNKRmw==
X-Received: by 2002:a2e:91d1:: with SMTP id
 u17-v6mr14879369ljg.160.1549655940024; 
 Fri, 08 Feb 2019 11:59:00 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54])
 by smtp.gmail.com with ESMTPSA id a127sm594712lfe.73.2019.02.08.11.58.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 11:58:59 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id l10so3424953lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 11:58:59 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr14335535lfh.117.1549655456495; 
 Fri, 08 Feb 2019 11:50:56 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Feb 2019 11:50:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
Message-ID: <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To: Waiman Long <longman@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_115902_694106_EE1D49D5 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 11:08 AM Waiman Long <longman@redhat.com> wrote:
>
> This patchset revamps the current rwsem-xadd implementation to make
> it saner and easier to work with. This patchset removes all the
> architecture specific assembly code and uses generic C code for all
> architectures. This eases maintenance and enables us to enhance the
> code more easily.
>
> This patchset also implements the following 3 new features:
>
>  1) Waiter lock handoff
>  2) Reader optimistic spinning
>  3) Store write-lock owner in the atomic count (x86-64 only)

The patches are kind of hard to read, with most of them just doing
prep-work that doesn't necessarily matter to the big picture.

What I'd really like to see is

 (a) an overview of the new locking logic

 (b) what's the new fastpath case

 (c) some performance numbers

to explain the changes from a "this is the point of the whole
exercise" standpoint.

And yes, I realize that the lock handoff and optimistic spinning is a
big deal, since I've seen the same regression numbers that presumably
caused this effort to be resurrected. So it's not that I don't find
this intriguing and worthwhile, it's literally that I'd like a summary
not so much of the individual patches, but of the new model.

Please?

             Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
