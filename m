Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B40C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:44:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B936F2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NU/kT7Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B936F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Aply80awPPmFeelADW/L8VAYNQO/ybttXLf4r+eRPhg=; b=NU/kT7Zk94dOxD
	PZJ1UaM0YPcbpPnCrYTUbUjnG0rRJz2DYSs5LlNAUyyWzzvDonbg6hAc8QxiujtBzIVx0ianxK6dL
	dslwVaz2xXF6aNjNmM2oisooWeo/RZrr16ebmhQGZXaLZ+R8ZtC1P8PInCZcOiW41zH9nunO1lgRx
	pLekAG/HjcfPPNVvtWNOzn2zwHp/51FhcK8M7BkejWnGLPJXqQt5DkqEOzGVQiROgqsgdEpfev23R
	i6vBPyoCcWxmG6epBiY2FUMbjn/+6DpDzC40KW+G2wiTr8xA+Ry7zhzlPO9QPDJE0BuvnxSWVp7rc
	BciBbJpH5BA4M30DnP4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgPE-0005Om-Hm; Mon, 18 Feb 2019 10:44:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgP6-0005Ny-F4
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:44:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0717C80D;
 Mon, 18 Feb 2019 02:44:04 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2B73F720;
 Mon, 18 Feb 2019 02:44:02 -0800 (PST)
Date: Mon, 18 Feb 2019 10:43:59 +0000
From: Will Deacon <will.deacon@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] trace: skip hwasan
Message-ID: <20190218104359.GB10743@fuggles.cambridge.arm.com>
References: <20190217043434.46233-1-cai@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190217043434.46233-1-cai@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_024404_508594_14E2E5D7 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 mingo@redhat.com, kasan-dev@googlegroups.com, andreyknvl@google.com,
 aryabinin@virtuozzo.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 16, 2019 at 11:34:34PM -0500, Qian Cai wrote:
> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> because there is a burst of too much pointer access, and then KASAN will
> dereference each byte of the shadow address for the tag checking which
> will kill all the CPUs.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/trace/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c2b2148bb1d2..fdd547a68385 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -28,6 +28,11 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>  
> +# Too much pointer access will kill hwasan.
> +ifdef CONFIG_KASAN_SW_TAGS
> +KASAN_SANITIZE := n
> +endif

I don't maintain this file, but I think that my comments on your related
patch are relevant here as well:

https://lkml.org/lkml/2019/2/18/223

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
