Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD49BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F89C208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B6G/Tueg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F89C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C7N1FCy2r/duaNX2OfjQEDiryrufTagdZBwuhZnYw2M=; b=B6G/TuegkoJhl6
	FgJhLDxmxU7bfcr3SPjQSTBGbqCWMnDiK8kbt99Q32p2+En1PTwE2SwDt77mTsiy+6hLeuaCSeX03
	o4EjoJB/ZKH4GWGYGBpzRBF6qDtONWRpr/Wn7CE/gd2nHYtCrr6IjJK5PrDfbov3KCEXcA0ocxaQU
	adaSHzUrVUogWqC9hse9s/uXRjjgGGITGmFEbh+dm+gyUJ7PVROMFt5CwmqjVZm6HqQjWgmYhG2Jb
	pNvVmg/Rcts+OnZ2zyEsMpthR7hw5QSbvPwnBwBVn4/oE1h2BZ2wIE50wDW4xkYTcE7VrP8c17BTJ
	ys/IhrMhQhSvS5Oii0qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtnT-0003JL-1a; Mon, 03 Dec 2018 19:22:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtnP-0003HT-CL
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:22:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B9E1688;
 Mon,  3 Dec 2018 11:22:08 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3DDC3F575;
 Mon,  3 Dec 2018 11:22:08 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id CE1721AE1062; Mon,  3 Dec 2018 19:22:28 +0000 (GMT)
Date: Mon, 3 Dec 2018 19:22:28 +0000
From: Will Deacon <will.deacon@arm.com>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181203192228.GC29028@arm.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130150956.27620-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_112219_422526_BB9FF7F4 
X-CRM114-Status: GOOD (  16.83  )
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
Cc: keescook@chromium.org, Arnd Bergmann <arnd@arndb.de>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anders,

On Fri, Nov 30, 2018 at 04:09:56PM +0100, Anders Roxell wrote:
> Both of those functions end up calling ftrace_modify_code(), which is
> expensive because it changes the page tables and flush caches.
> Microseconds add up because this is called in a loop for each dyn_ftrace
> record, and this triggers the softlockup watchdog unless we let it sleep
> occasionally.
> Rework so that we call cond_resched() before going into the
> ftrace_modify_code() function.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/kernel/ftrace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

It sounds like you're running into issues with the existing code, but I'd
like to understand a bit more about exactly what you're seeing. Which part
of the ftrace patching is proving to be expensive?

The page table manipulation only happens once per module when using PLTs,
and the cache maintenance is just a single line per patch site without an
IPI.

Is it the loop in ftrace_replace_code() that is causing the hassle?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
