Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C1AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:07:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6389220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="miO188HK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="17FX2thS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6389220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QLn06mYp5MbeFJygoQGvRw3491x5jzUYIglrdHlAEag=; b=miO188HKI0/aYa
	zr7I/BdwRjKvhJjDCkgITcxNVZikwatkFJlpdgopEhOEQggUbqWF7M8jDZvW8vGF6LkGGo91kdpWy
	8hufZEtyE33mcKHjy0Wya41WcQbqoxWTwGDWwELxn6vcCOTUaD2+h1/4NPbZ2pixkcM03LoW1hMGO
	Watx6sRECUrCx4yJA9RRdVGvuSqqfeLXIVm0dSOJ5ikaTQgBmPQsJ2Gehcs5jXbXz2lkf9pBK66wM
	UNkMM7EYmZwdvrGnU1uPbzqTk0fCHIuHg02ClLNguXLCDMxILXpQVde7iFE1d2vBch1d9to+VxX5g
	Uivi2c8NnFEqVWTkcarQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMDJ-0007qH-Ok; Mon, 10 Dec 2018 14:07:13 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMDI-0007qA-0m
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 14:07:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GkAUqUKQu/1gTgqSH3aCvVxy7YJVnyUJfvfSRt4Y3YI=; b=17FX2thSO5MJC/nachnhmUXwq
 Uh2bS4ja8aMSb3EhKDf32Mu0n8n0EXqzOwMlMCOHFs+GKoJxaOFXb5rAUzrrBGecaXH7yXJiWWqV/
 +nk/w+mOG+9HU45cLassdpHYKUiSK/kUv8dkkqWjBpMJOL9N0t7oyqBL8X6SFfiZ+lFbB3sKlN+3s
 D5VoG19fTPc/u+2zj+p2e//TaCsqh6UXeCBAJslG011HlWaVY/zTlleCGn7Cd/Ca8ricTt8CpdwCR
 8rcGqBz5JUYkJy0M3gkQ2BdwJ8qO9Br7iiw+epQ2j7ogVWz9zCmgca2zHIrvmNPw0FULVwKzvl+ci
 8DoMWMIXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMDB-0004IE-Nu; Mon, 10 Dec 2018 14:07:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 2CFE82075BCE5; Mon, 10 Dec 2018 15:07:03 +0100 (CET)
Date: Mon, 10 Dec 2018 15:07:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
Message-ID: <20181210140703.GM5289@hirez.programming.kicks-ass.net>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210135228.49751-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, mingo@kernel.org, longman@redhat.com,
 akpm@linux-foundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 08:52:28AM -0500, Qian Cai wrote:
> Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
> warning.
> 
> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
> [    0.000000]  acpi_table_parse+0x1ac/0x218
> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
> [    0.000000]  timer_probe+0x1bc/0x254
> [    0.000000]  time_init+0x44/0x98
> [    0.000000]  start_kernel+0x4ec/0x7d4

It seems to me we want something like:

---
 kernel/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38eb7e5..e1ee8caf28b5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -313,6 +313,8 @@ void cpus_write_unlock(void)
 
 void lockdep_assert_cpus_held(void)
 {
+	if (system_state < SYSTEM_RUNNING)
+		return;
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
