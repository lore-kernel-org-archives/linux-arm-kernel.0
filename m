Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6242084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qBbt/qVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6242084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xuMoFQXgunq2WWk892CLFnC8tuwcwbBnac90hXe6eNU=; b=qBbt/qVmstW5dx
	4w1V8NFJbdEJdhhJco5BOSze4x8d7LWQXnHSK4t22dOGJWOeg7fdZlaNCRqDbi5GT9RsT+gzlW8Fl
	6fe0uSgQ1Nls94nRffCt+h4n+78O2tnuyn4MfM8ZNFdWVuD4TfQpS2I7OWk4p8cVEop2bPUYorHq8
	6ABkpYtd63cuOnTRy+gV/O6Jue84IwQmr0JHTyPQmLG34vCN8d4agr+3cgykdLxCLa8tRd7/0gzt8
	4jbBgCb3x1tw4WE7p6YNts64ZjQDu/23Yy0kxTlIg6EQRWaWo0dPz8vql8E//ifidQQGn8SIY+eee
	uIUeo2rSbxEGp1OegnLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhNI-0007bh-Dy; Tue, 11 Dec 2018 12:42:56 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhNE-0007ab-NB
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:42:54 +0000
Received: by mail-qk1-f194.google.com with SMTP id w204so8485514qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 04:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gD8f9A+yOrKSkam/K81qSn+sZ/zk2aeP124oDPQh7j8=;
 b=EKr8TZS5y2UrmFXqOzEOr8jJ4sH+m/JHp4JauDfE93fcKCn9H9BLNSj3sGhfaxkH2C
 CbBEgmxz9ko3TTtC5wCkGKYE5kKC1n33p4klsBpVXYdJlzrjQQjQKV844sgcydAIK2uR
 HcuYxs4Ir+/m4bjnA+xwaHD9ZzLUS8V0OBnIIRviPkjrzMKalR+sDftaJdYMmmCxxSWL
 g8hjCHJ3A3vxxWAGSo+idQW8f/s4uptS1fA9jbR0VWMyGXrfcJSeH1vjoj5Q1m6qNIHr
 TY7JBJr2weO2X7VmF2EkhSQuM0knZ4CWq0QbDTCi/Qg1/rTBcyFCPmhPGDO3QXlRpRnq
 LFFA==
X-Gm-Message-State: AA+aEWYvgCxlFhhHEprx80wD4t/toVQBzs4+g4iv33T86iuAw5pBEGjs
 8/nLQ+I4AsigQiL5XbNljecMdmyDL0vvMTPQASs=
X-Google-Smtp-Source: AFSGD/Vd1BIXINShufesnfmxbgu3Uq+GOP9+W8KyfUFd1gvLvE01bT4ekpquPDaZ24IdORmlr0adyRros9sOjzDWghA=
X-Received: by 2002:a37:324a:: with SMTP id y71mr14519413qky.291.1544532161273; 
 Tue, 11 Dec 2018 04:42:41 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
In-Reply-To: <20181207223449.38808-1-cai@lca.pw>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 13:42:24 +0100
Message-ID: <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To: cai@lca.pw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_044252_760988_AB744D19 
X-CRM114-Status: GOOD (  13.17  )
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

On Fri, Dec 7, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
>
> If the kernel is configured with KASAN_EXTRA, the stack size is
> increasted significantly due to enable this option will set
> -fstack-reuse to "none" in GCC [1]. As the results, it could trigger
> stack overrun quite often with 32k stack size compiled using GCC 8. For
> example, this reproducer

>
> size
> 7536 shrink_inactive_list
> 7440 shrink_page_list
> 6560 fscache_stats_show
> 3920 jbd2_journal_commit_transaction
> 3216 try_to_unmap_one
> 3072 migrate_page_move_mapping
> 3584 migrate_misplaced_transhuge_page
> 3920 ip_vs_lblcr_schedule
> 4304 lpfc_nvme_info_show
> 3888 lpfc_debugfs_nvmestat_data.constprop
>
> There are other 49 functions are over 2k in size while compiling kernel
> with "-Wframe-larger-than=" on this machine. Hence, it is too much work
> to change Makefiles for each object to compile without
> -fsanitize-address-use-after-scope individually.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Could you clarify: are the numbers you see with or without the bugfix
from that bugzilla?

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
