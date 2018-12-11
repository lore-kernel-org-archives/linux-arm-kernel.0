Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BAC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6D12086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qaloKGkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6D12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sJstX7IOYAe/JrGpBw+uWCfzzL32T+B9UV/i5csnlLk=; b=qaloKGkqFJUvSQ
	kJxJaJXIF5nWXNTfPmJ7yC4eK6+RjzO8kf/YhFohj1E15uoTs3K0YUTUztPj0qm3ehhDcCtxI0R+R
	3+gny+eQATKZN+RJc+aONyNrUDrhck3aqFeUi83JRlbGIsIOoXGL0cK3Nx1LtfO8ZralWTJX1FXPG
	9nVg0XITLw2dmYzqEtdCoztsDh8PTu07p4F+p1izzCyYx711pkJVrX+aGNvUCjvKQ0pqoTvJzvxmE
	F2mhxFvw9x1Yll2Lgd2HjofFO8ZgxVQazMlAXzTXLeqcSj4oMqqP/K95vsCnlhiLxsyHJCIVdyklf
	bhoC284dvcEdp9mFhjDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWpot-000728-LH; Tue, 11 Dec 2018 21:43:59 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWpop-000713-BH
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:43:57 +0000
Received: by mail-qt1-f194.google.com with SMTP id e5so18211206qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wZrYDhQDmw+7vlF+0D5VlJ5hXp14PJhXLq3YQkxDGhk=;
 b=GxTZbMsfTxeexwGYB7mFtPaKiMS6QIiq91tODJAil+WRdhUqc1ORykuBmq54PhaPSQ
 CKBeiyzTpBW9UhN+c1LqGVvk49Zcmv53mUry4xaRPKsRjOiAC3LN0KFhVFTMN04o3Vva
 R+A5EDWfggNTfgDzxV2ZJW3CCjOFT8Veoob5kQO8LXMeMlX6GkzmzH3OtuwtUiZj69Tt
 wMDZO+5dkGfWnDSEfVFhBFWru0X+XCH9Ql0e9GoQ0rzUhjLwBIgRn7fhOH1Yom5O9+CS
 i7X8A8cs6bogcj5AbQBXqEfJQOXlxRDGC6GG+3PzotNke6559EtKIljXvPmbHpXoo8Fo
 mlDg==
X-Gm-Message-State: AA+aEWau3wZrCkxAFCwhPwPtLoRmQdbKFoKKNqNelJLmrIXFHRkL+R6Z
 QkdQc0191DgB9Rogxq00AeTvnSYkXNnvI2BVCsU=
X-Google-Smtp-Source: AFSGD/W5mBXx/aKK1ofup/4ouSqZaDUCSUP59Ccw3pjOm395Eg8/fm5PPHm9tANuIPvwvuiHwmoMD2EzkJ0VqI5YW2M=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr16890413qtm.96.1544564624122; 
 Tue, 11 Dec 2018 13:43:44 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
In-Reply-To: <1544548707.18411.3.camel@lca.pw>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 22:43:26 +0100
Message-ID: <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To: cai@lca.pw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_134355_390297_98715119 
X-CRM114-Status: GOOD (  19.78  )
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

On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2018-12-11 at 13:42 +0100, Arnd Bergmann wrote:
> > On Fri, Dec 7, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > If the kernel is configured with KASAN_EXTRA, the stack size is
> > > increasted significantly due to enable this option will set
> > > -fstack-reuse to "none" in GCC [1]. As the results, it could trigger
> > > stack overrun quite often with 32k stack size compiled using GCC 8. For
> > > example, this reproducer
> > >
> > > size
> > > 7536 shrink_inactive_list
> > > 7440 shrink_page_list
> > > 6560 fscache_stats_show
> > > 3920 jbd2_journal_commit_transaction
> > > 3216 try_to_unmap_one
> > > 3072 migrate_page_move_mapping
> > > 3584 migrate_misplaced_transhuge_page
> > > 3920 ip_vs_lblcr_schedule
> > > 4304 lpfc_nvme_info_show
> > > 3888 lpfc_debugfs_nvmestat_data.constprop
> > >
> > > There are other 49 functions are over 2k in size while compiling kernel
> > > with "-Wframe-larger-than=" on this machine. Hence, it is too much work
> > > to change Makefiles for each object to compile without
> > > -fsanitize-address-use-after-scope individually.
> > >
> > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23
> >
> > Could you clarify: are the numbers you see with or without the bugfix
> > from that bugzilla?
> >
>
> The numbers were from GCC8 which does NOT contain this patch [1].
>
> GCC9 is awesome which reduced the numbers in half even for KASAN_EXTRA. Only
> thing is that GCC9 has not been officially released yet, so it is a bit
> inconvenient for users need to compile the compiler by themselves first.
>
> I am fine either way to drop this patch or keep it until GCC9 is GA.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c35

Maybe we can make the constant depend on the compiler version?
It may also be possible to reduce the KASAN_THREAD_SHIFT
constant for the normal case with gcc-9 and go back to the
default frame size then.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
