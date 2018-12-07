Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77127C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:47:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4728820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YjgJcVS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4728820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1xSATYxaYPj1n+iCgzPqjU6ZEFOmhZpd7N9nRSyH6xA=; b=YjgJcVS2G8TTyS
	lf3bC0KoGw2KcJHmSm/2UARNXa2MPlwaRBcgwQWHcgbg1SX54LkQsjnyrDPhOpCVV/TZwwyuigUyO
	D6PgBIGTwYnyEj2cY2lW5URKSReQyhxPNuZNvuh6DFnvb55HdujauXuJfrx1aKCo90n/4HI8jr+lB
	n6GnKygeYfgF+whu7aZmSMSUrri7dmTsrlbtxDwqz3sB0eOSl4PxXTRLqGaFTtJiprOw7pBhFVBLp
	RDcDJjCsfv+og6szXHfR4LMBcXPAsYFnCdOjyL4XO74ZFOQkmIFGFQDhbBj/hL5ufzSNj0S9FL2zI
	mLak2JwRIzIb1z6DbLJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDfU-0004Om-Cz; Fri, 07 Dec 2018 10:47:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDfR-0004ON-8T
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:47:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36B66EBD;
 Fri,  7 Dec 2018 02:47:22 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 074AC3F5AF;
 Fri,  7 Dec 2018 02:47:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 6437A1AE0BDD; Fri,  7 Dec 2018 10:47:43 +0000 (GMT)
Date: Fri, 7 Dec 2018 10:47:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: arm64: WARN_ON_ONCE issue when resuming from hibernation
Message-ID: <20181207104743.GB23587@arm.com>
References: <20181207104049.5F64.4A936039@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207104049.5F64.4A936039@socionext.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_024733_308267_3F218A23 
X-CRM114-Status: GOOD (  18.43  )
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
Cc: arm@kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+ James]

On Fri, Dec 07, 2018 at 10:40:50AM +0900, Kunihiko Hayashi wrote:
> I found that a WARN_ON_ONCE dump occured in the resuming sequence from
> hibernation on arm64 SoC (I use UniPhier LD20 environment).
> 
>     ...
>     Disabling non-boot CPUs ...
>     CPU1: shutdown
>     psci: CPU1 killed.
>     CPU2: shutdown
>     psci: CPU2 killed.
>     CPU3: shutdown
>     psci: CPU3 killed.
>     WARNING: CPU: 0 PID: 1 at ../kernel/smp.c:416 smp_call_function_many+0xd4/0x350
>     Modules linked in:
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc4 #1
>     ...
> 
> I show the result of reading the code, however,
> I'm not sure that this issue occurs in other arm64 SoC.
> 
> In the resuming sequence, once all CPUs are stopped and local IRQs
> are disabled [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/power/hibernate.c?h=v4.20-rc4#n450
> 
> In case of arm64, flush_icache_range() will be called after that.
> This calls kick_all_cpus_sync() to sync all CPUs with IPI, and
> since local IRQs are disabled, WARN_ON_ONCE() will be called in
> smp_call_function_many() [2].
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/smp.c?h=v4.20-rc4#n415
> 
> The following tree shows a part of the callgraph.
> 
>     resume_target_kernel()
>     +- local_irq_disable()
>     +- swsusp_arch_resume()				/* for arm64 */
>        +- create_safe_exec_page()			/* for arm64 */
>           +- flush_icache_range()			/* for arm64 */
>              +- kick_all_cpus_sync()
>                 +- smp_call_function()
>                    +- smp_call_function_many()
>                       +- WARN_ON_ONCE(irq_disabled())
> 
> What is the possible way to solve this issue?

Given that all secondary CPUs are hotplugged out at this point, we can
just use the non-IPI version of flush_icache_range(). Completely untested
diff below.

Will

--->8

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 6b2686d54411..29cdc99688f3 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -214,7 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	}
 
 	memcpy((void *)dst, src_start, length);
-	flush_icache_range(dst, dst + length);
+	__flush_icache_range(dst, dst + length);
 
 	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
