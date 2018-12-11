Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE33C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF4F20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AgyMXxKZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nA8eJNPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF4F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IOlpu96ubLWMmnZDxizuNjqGo7ECJMz8rMRASxVPFWw=; b=AgyMXxKZWlvm0A
	jBBqohGkNncDoUW7uxh2anYu9ggVGu6NPy9pnccuh1LKWBQONxJGiliCGy1GS/hqY6FGjq9LHGnLQ
	jzOiVhHUHM2cL3+Si5S6b0fAbYcAewvdnEtPdQy7Kz88zlkQXhmFOXQ6levSEgok72jBqU1b4RESt
	cL6LezajWSF4UIcmOAJxOQrhXPXQCsHFVUv6jnUuYM6mb+t+s0DAs87S+Ho7toBh5uXI+utsyYf80
	gACkPYB7NNUdKmHEBQShYndUUTFbnKzxR7J6saBHFk2rRXufQsowcylpRViRdp9lnB8Gp7iahuNN+
	UilIylW9aQ5wUmH0YxaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWpxZ-00033h-Lt; Tue, 11 Dec 2018 21:52:57 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWpxV-00032S-VQ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:52:55 +0000
Received: by mail-qt1-x843.google.com with SMTP id y20so18241379qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A4HFOG3VmVnE3ZqibYXZ9iqqQwLgZN74D8ZHOnCgwYU=;
 b=nA8eJNPJ38IPFj45HZ73XjrD1TAdVRWtvai26NSLm8oNjl+7HI5pRgXhJxGG9pj4L0
 FuskVy2oFpDdQfA53faKKfT8v9HjNOC92WThOm/HdOhjvGF9QDtO3A54dyEHZ0OouUE0
 hyBT8xDPu+VkB6kWO8HUwsibUTVsv3GnE0l5ubk/Nfv2+bSdbSTxGzgD6XQC/eqSVqx7
 aCnXsOR+bSU6BYGLM/HGzKpih6X8mRuhnRLG3vY/wgdX5Yb3uLlaVd/jyIFtHhBQceJR
 bQ+5+lulVlO59GoQAWtXwhPCv6ZivvCH13HVcCXE97rgQCIkHn8jglHZcDhGV22U6D2V
 o2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A4HFOG3VmVnE3ZqibYXZ9iqqQwLgZN74D8ZHOnCgwYU=;
 b=kbMhXYGYDyMevZT0q/mq99qqHjuYgOxBZ0ZJjdpNnveOlY6VaICmbeexEDsonO0Anl
 ER1Hv6hd5N99ayzxwsVl89xPImUYTnziy7OMxvik+j4ErOhKoq5GLw4/TEZ09bmQSjzI
 LQuNpqzLsc2HaHJP5UBVeojP2Mt+veE/GkUsoUqDgv0FTpztlQSA75/bcGjAowp2dFvc
 lwXKsZcDez1Sv/Q3mDPr3xxWBPB0Sej31PMKc44RIU+pUSO4p5A6l2F9vLvBqC0QgpUe
 YaOeye5g6JGdeSi1Kv3P7jKkn53awBXfN3ZBlcLUFRwAE3rypuI2FQRlvByVc3PCs5nD
 0bIw==
X-Gm-Message-State: AA+aEWaO9ioGNe58bWaMDEEQFBnGj96dpqTwFo9PGeIAxs9JNXn5LF29
 JZKqYlpQo5Sfb6NVWIy3fAsqAQ==
X-Google-Smtp-Source: AFSGD/VR2uQRkA/UCfjikXqJ+gKFZ8IDlGVa4/3IKnAEieQiJzl8Q3khGp5oWmSiWVkawQN+YcacNQ==
X-Received: by 2002:a0c:aa84:: with SMTP id f4mr16894502qvb.243.1544565160972; 
 Tue, 11 Dec 2018 13:52:40 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id v186sm8553160qkd.13.2018.12.11.13.52.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 13:52:40 -0800 (PST)
Message-ID: <1544565158.18411.5.camel@lca.pw>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
From: Qian Cai <cai@lca.pw>
To: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 16:52:38 -0500
In-Reply-To: <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
 <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_135254_013665_C9D73C1C 
X-CRM114-Status: GOOD (  22.74  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Tue, 2018-12-11 at 13:42 +0100, Arnd Bergmann wrote:
> > > On Fri, Dec 7, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > If the kernel is configured with KASAN_EXTRA, the stack size is
> > > > increasted significantly due to enable this option will set
> > > > -fstack-reuse to "none" in GCC [1]. As the results, it could trigger
> > > > stack overrun quite often with 32k stack size compiled using GCC 8. For
> > > > example, this reproducer
> > > > 
> > > > size
> > > > 7536 shrink_inactive_list
> > > > 7440 shrink_page_list
> > > > 6560 fscache_stats_show
> > > > 3920 jbd2_journal_commit_transaction
> > > > 3216 try_to_unmap_one
> > > > 3072 migrate_page_move_mapping
> > > > 3584 migrate_misplaced_transhuge_page
> > > > 3920 ip_vs_lblcr_schedule
> > > > 4304 lpfc_nvme_info_show
> > > > 3888 lpfc_debugfs_nvmestat_data.constprop
> > > > 
> > > > There are other 49 functions are over 2k in size while compiling kernel
> > > > with "-Wframe-larger-than=" on this machine. Hence, it is too much work
> > > > to change Makefiles for each object to compile without
> > > > -fsanitize-address-use-after-scope individually.
> > > > 
> > > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23
> > > 
> > > Could you clarify: are the numbers you see with or without the bugfix
> > > from that bugzilla?
> > > 
> > 
> > The numbers were from GCC8 which does NOT contain this patch [1].
> > 
> > GCC9 is awesome which reduced the numbers in half even for KASAN_EXTRA. Only
> > thing is that GCC9 has not been officially released yet, so it is a bit
> > inconvenient for users need to compile the compiler by themselves first.
> > 
> > I am fine either way to drop this patch or keep it until GCC9 is GA.
> > 
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c35
> 
> Maybe we can make the constant depend on the compiler version?

I am not too keen to do the version-check considering some LTS versions could
just back-port those patches and the render the version-check incorrectly.

> It may also be possible to reduce the KASAN_THREAD_SHIFT
> constant for the normal case with gcc-9 and go back to the
> default frame size then.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
