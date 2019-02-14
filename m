Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:51:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84325222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TyaVHVCE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PGshS3Ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84325222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Of1iF3BusNVweGEbdxaR/bBPEktrUl7gWn5Dh06Y/Iw=; b=TyaVHVCE2uJUWl
	Jc9lje2QZ45jDmhyBgARmwbnXavu+rZcLfz7d/KtXcDtQxDMYNsIIcGEahej5Y3iiVIva0LSWF9oS
	UeNB+i/RClyeoRLFTCTFBzkQ6dcqC8tkp0GSjsbJL1LQpO9d4DbjgP80qiFqCBEVv341dm4jE5fFE
	CH7o3pyNyfmPi04El/h6cb2aurK09qjsBoZDsIC+YD5d+kA71IiXEsJfZmQwaNn38ofh/XiDnhEWc
	6KSJNU1iys9vHIYo34IFxl8YXnYKVg+o7b8o9vOC0wPYbTNDpI5E32+D1rXEyZGnF9sGEW4H1A7mz
	bDnbvEyta0i9lEkGW5rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLAq-0005it-08; Thu, 14 Feb 2019 17:51:48 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLAl-0005i3-Ry
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:51:45 +0000
Received: by mail-lj1-x244.google.com with SMTP id g80so6014018ljg.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YOAxNfp/u2AjpSAe9gJ1DkLd8kcSaDRiWtEtJaBSEcs=;
 b=PGshS3MaeGeltwuyVtFmT0V6YZQZmxLLNBrf107mvwKlqUhZwGpD70GnjqQJh+4V2q
 3J6Xvbgr/CiWsk6q6rJVeglsaiLbeVTkiovB8o6FTpvJF+udviHo9Zs+xhaucNb0e3LD
 IXDiqt1MsmZkkBaKR5AXhS5/XMcdP66J22GNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YOAxNfp/u2AjpSAe9gJ1DkLd8kcSaDRiWtEtJaBSEcs=;
 b=eHPdEDiluWRbP6pLxr4QrJ6PTl1cGKLHMbTq78wRHua3sHI6CPRX5uiDH1W91TEq7B
 3oXF9CiuAHukNFMD7ga/og+6YkpHZHPrAR2ZMdlTuWwl4DjjE+RT2GY3p60cW2Gobtzl
 9zjsSrNkuE5kZzB1TDUWHUZzfi9m4CklAmDSP3lCIXkvgj1IaNO44SKBb+GyFK/2SgXY
 Mhn4f/QYQJ97DQe4x58i4T+ydR1lQlfbK3WxV1bk7aJjLlTM78RqZ2vkNjdSaejzl7bT
 iQvaGbNSFqKl4M7eFy4fm9whLzYNPZr3L+DYEGszoiwRycFBdHTyRfORIpD4K2oqv1lm
 5BDw==
X-Gm-Message-State: AHQUAuZq3HIffOvDBbNBtGEkmSBDpyd7lSAEN6FrLb2evIzqDHNN+u/Y
 HtK6oima2oRWxsmnD+NWWwk9b9FK+dQ=
X-Google-Smtp-Source: AHgI3IZ21kL3iPmvNooahuJZ1tvufAyc7DQYbOIy2kG0tPICaBFHe875zkzqtX4aKuIGyFWzPk1PTA==
X-Received: by 2002:a2e:9786:: with SMTP id y6-v6mr3145009lji.53.1550166701256; 
 Thu, 14 Feb 2019 09:51:41 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com.
 [209.85.167.42])
 by smtp.gmail.com with ESMTPSA id n21sm664690lfb.81.2019.02.14.09.51.38
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:51:38 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u21so5215756lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:51:38 -0800 (PST)
X-Received: by 2002:a19:2794:: with SMTP id n142mr3048400lfn.77.1550166697920; 
 Thu, 14 Feb 2019 09:51:37 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
In-Reply-To: <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Feb 2019 09:51:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Message-ID: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
To: Waiman Long <longman@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095143_915575_3BF3FF82 
X-CRM114-Status: GOOD (  13.86  )
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
 "H. Peter Anvin" <hpa@zytor.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 6:53 AM Waiman Long <longman@redhat.com> wrote:
>
> The ARM64 result is what I would have expected given that the change was
> to optimize for the uncontended case. The x86-64 result is kind of an
> anomaly to me, but I haven't bothered to dig into that.

I would say that the ARM result is what I'd expect from something that
scales badly to begin with.

The x86-64 result is the expected one: yes, the cmpxchg is done one
extra time, but it results in fewer cache transitions (the cacheline
never goes into "shared" state), and cache transitions are what
matter.

The cost of re-doing the instruction should be low. The cacheline
ping-pong and the cache coherency messages is what hurts.

So I actually think both are very easily explained.

The x86-64 number improves, because there is less cache coherency traffic.

The arm64 numbers scaled horribly even before, and that's because
there is too much ping-pong, and it's probably because there is no
"stickiness" to the cacheline to the core, and thus adding the extra
loop can make the ping-pong issue even worse because now there is more
of it.

The cachelines not sticking at all to a core probably is good for
fairness issues (in particular, sticking *too* much can cause horrible
issues), but it's absolutely horrible if it means that you lose the
cacheline even before you get to complete the second cmpxchg.

                  Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
