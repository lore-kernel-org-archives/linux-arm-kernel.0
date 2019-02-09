Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:04:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B458721908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K7kmJ+wz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LbLALWqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B458721908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0sC4pTla/3nrxve3pxX2A06LaCmQYbJOGe39maYoi1M=; b=K7kmJ+wzsGenSh
	/MH+0OzCDyhyX8+y9v9T3Jyji0ERZ5Ngf1uNQaYqh4lc4aHk7qTtKLaNrMUN3NLIoUH3csVZj83Wl
	ZOQngO68tK8f2jzm8jxgFb5I9MlAnX55RFxVQMSRNyE7tOr6l6VPrHrhrXer+A1SeixrJYA5p+TWE
	3PBHduOVjvkI0BDQqhq8K8DZxbF188uBM26VGJGI9evM1wQ3QQ9X5L4c+dX/C4e8QfzPEuLpFz9kg
	i5807Z5CJnJ9+ngySePQ2iXCK3zHDGCnwFg+uMk/r+DNYSHygQxi5dTITCRoF5z4ZK4YQZRSvZiYr
	i5UZ7f3D41keBX2ztczQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsG7u-00053i-DW; Sat, 09 Feb 2019 00:04:10 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsG7q-000531-LB
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 00:04:08 +0000
Received: by mail-lf1-x142.google.com with SMTP id e27so3809852lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 16:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=esUN0eAUy4YWkP+bozuSr/XyV8kG31d8rYJRedvgykU=;
 b=LbLALWqmuur3vFRa25JFyrgBoAdC34KiufM5BZY6FVjl/WYfmGblutfsjwJLgcnL2s
 7WfLx0BMAxPDJUxhk3YWwQvooGaab1y8eWCVbR4BtrKqYJ8QmykyrhzkiPDRsWkCWKX2
 tpgX9WKhMrvACLp3JH8Bq642be3K34aaxe+NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=esUN0eAUy4YWkP+bozuSr/XyV8kG31d8rYJRedvgykU=;
 b=CDTuC12ddrDB8zH/WcYzgAQU3KJ2sxHWIoz7mWttgDWMf7emwAyQqW1/7rrkvocpj4
 KMOohEvPksqs+mWwvnFjC1CUKLjnazWfZhd6izRlwQt9neJTRrjNMXn23DJlfdJMJjYu
 zaFm1xS8CKP1fZ3iHU53A9fmFUWYs+AvbsprFnk8J4owrI80SkEwm6GMkAub5VNkTtjr
 rEWNlZIqJbuqPffSAO64Z5dZIO9m5emNE2DH9wIqE+4JqdmS/ZoLcXQQyv2zGKmEE4CC
 /6gYUyCpw289+vsEctYYGj0dlBLTRlZ7n+5N22SQm/aicc7kvU+iRm+tQjJ3ATSCZIgK
 TUBA==
X-Gm-Message-State: AHQUAuYisOMDkB7XAOHkKCnnGaLkOboMr1uJzdOD3cEuXg1nncZsSX0P
 bG3v8P7SsMsS+IODBxpqPNMRdaK3T24=
X-Google-Smtp-Source: AHgI3IZ5HZXZJFanKJRiiRjuYXpy0YRP0rVnTPS/JcJke4ot8hU9I5jujZqYXy3ovFYoURTCs8FoVA==
X-Received: by 2002:a19:9c54:: with SMTP id f81mr15517748lfe.135.1549670643258; 
 Fri, 08 Feb 2019 16:04:03 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id q1sm137841lfk.15.2019.02.08.16.04.00
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 16:04:01 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id e27so3809776lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 16:04:00 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr14867539lfh.117.1549670639775; 
 Fri, 08 Feb 2019 16:03:59 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
 <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
In-Reply-To: <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Feb 2019 16:03:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzAGRJQE43NHaC8sCECLr-QnpHYst+TJq-qhfp9eK-Qw@mail.gmail.com>
Message-ID: <CAHk-=whzAGRJQE43NHaC8sCECLr-QnpHYst+TJq-qhfp9eK-Qw@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To: Waiman Long <longman@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_160406_703932_C6A7A36C 
X-CRM114-Status: GOOD (  12.04  )
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

On Fri, Feb 8, 2019 at 12:31 PM Waiman Long <longman@redhat.com> wrote:
>
> >  (b) what's the new fastpath case
>
> The only change in the fastpath is the use of cmpxchg for writer lock.

.. since a big deal here was about using the generic atomic accessor
functions, I really was looking forward to seeing the *actual* fast
path code generation.

In other words, right now I have very little visibility in how it
actually affects the code. Looking at the patches themselves doesn't
make it obvious. I was hoping for the overview to really explain the
whole "before and after" situation, and it didn't. Not at the high
level, and not at a low level. And no performance numbers in the
overview either.

And yes, I see the numbers in the patches, but what I really hoped for
was some real load numbers. In particular, I would have loved to see
numbers from th ekernel test robot "will-it-scale.per_thread_ops"
case, which is the one that had a 65% regression due to the lack of
reader spinning.

So I was kind of hoping to hear whether that regression is basically
entirely gone with this patch series, or if we still have a regression
due to the extra downgrade, or what?

                 Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
