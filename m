Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AE1C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE6C205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bp7coFWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE6C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QN4NTVCUs5U14WdKvtG43KAP+hrKu6/XsN4JhhREjf8=; b=bp7coFWBzxb/eO
	KV+VZay48lxdoC5PcBt/6sPQ7wkw49xaPT41yoyN8jHaiFibr3NTmJgSE7GCwPwUpoXb2/l9uD1g0
	WFl4HXbx7qWVzdo6WX/Os+BrVDV9MKfjf5qRaw3b1CMQPqbLejiJDhTJSRJ746MjlKfRdgnUmm8M3
	0VxhL1lo3FFpDYy8ulmPv3r7Gm+XtYHwhfMQyOn1HJR0MZqzJXnUc0nCxKmmux016JGmAqzPB09i7
	O8nm7798CEJZ/LZx49CHq8/CV7EcO0mEICB3c2p6ZDGRxTvopa3Y+LeI7vBl8ek+3/K+CBjoLttYM
	7lkaiD7rC5BLkBXXQh5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjoLm-0007N0-UT; Wed, 16 Jan 2019 16:47:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjoLX-0007EN-DL
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:47:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06095A78;
 Wed, 16 Jan 2019 08:47:19 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 981C63F5AF;
 Wed, 16 Jan 2019 08:47:16 -0800 (PST)
Date: Wed, 16 Jan 2019 16:47:13 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] kasan: Remove use after scope bugs detection.
Message-ID: <20190116164712.GB1910@brain-police>
References: <20190111185842.13978-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111185842.13978-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_084719_911785_5F9D7BE7 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, Qian Cai <cai@lca.pw>,
 Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 09:58:42PM +0300, Andrey Ryabinin wrote:
> Use after scope bugs detector seems to be almost entirely useless
> for the linux kernel. It exists over two years, but I've seen only
> one valid bug so far [1]. And the bug was fixed before it has been
> reported. There were some other use-after-scope reports, but they
> were false-positives due to different reasons like incompatibility
> with structleak plugin.
> 
> This feature significantly increases stack usage, especially with
> GCC < 9 version, and causes a 32K stack overflow. It probably
> adds performance penalty too.
> 
> Given all that, let's remove use-after-scope detector entirely.
> 
> While preparing this patch I've noticed that we mistakenly enable
> use-after-scope detection for clang compiler regardless of
> CONFIG_KASAN_EXTRA setting. This is also fixed now.
> 
> [1] http://lkml.kernel.org/r/<20171129052106.rhgbjhhis53hkgfn@wfg-t540p.sh.intel.com>
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/memory.h |  4 ----
>  lib/Kconfig.debug               |  1 -
>  lib/Kconfig.kasan               | 10 ----------
>  lib/test_kasan.c                | 24 ------------------------
>  mm/kasan/generic.c              | 19 -------------------
>  mm/kasan/generic_report.c       |  3 ---
>  mm/kasan/kasan.h                |  3 ---
>  scripts/Makefile.kasan          |  5 -----
>  scripts/gcc-plugins/Kconfig     |  4 ----
>  9 files changed, 73 deletions(-)

For the arm64 part:

Acked-by: Will Deacon <will.deacon@arm.com>

but I defer to you and Dmitry as to whether or not you go ahead with this.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
