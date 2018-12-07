Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A71EC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:35:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C2B20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hy4aOxB5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XlewbJ5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C2B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AVQR4QuVKe7F7nCjHwbcfCQ2CHifwrINsiWrEzJXbyQ=; b=hy4aOxB5AfTX36W+On9T9mGQ1Q
	jo1NyQrefXfldaRVOZNTaO8FVYadRCdsU/H3SQkh7dD+GnprCwrGL95Ho26W5DnCKDqNTzgJvvNHQ
	gYxKwtFFOO2qXFkYpoKiIQ6eaFIKbW6N2AN0/R4H9+bfXczGjw+SQsRV6SrjE+pTuSYgwzCinLbOw
	YswjftIZS5vl4ipL7K5tvS1FCKj275QMVjCGlvTpU8/tDOeLRn7uQJWLCNiDK4gfmCHN6OZ5K/5SL
	MXOiiTjCHozLshOtny0i0BmPnPC5Lo9mQP/GJEE1SraeYdMO2/jOpQ5rQ3KEzY+8O6O2TsVUHlBmq
	h4UhnBMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVOiJ-0008Sh-JJ; Fri, 07 Dec 2018 22:35:15 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVOiF-0007AD-Mb
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 22:35:13 +0000
Received: by mail-qt1-x841.google.com with SMTP id y20so6249549qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QDHetqdY6gL2ut6w5hBOClKGYYflCOmIf2piJSnwVCA=;
 b=XlewbJ5l6u5F0/A8cWX4s+3SHkW1ez1LG4mNrfLVy1fLIciasfhYhYb+jAjQVRhXy+
 eTwKcOqjxK3Jd1pWNMbVzm7nPJmxgmHxMKdrHrUxRN0ap1pyEx7Xnwy6PghZ/smAFkMn
 zmasFudqR6QRtvtH0S6XTo4OBlk5q3zkSKlLFmIVU17NCV4E2eIMGk5ibnJEDrcYZ3rh
 q++WnLXNmvIT9MTh9IuGjoxW0qAuFRDzyULrh6UJzsCQZWgywE4dfUpmPzrapsYVjyFQ
 ZqQZhetQ3QYEq22E8aWN9PE0t3JLgoPTogBGoNqOvM/SuMbl90dj+X1EhzX2z8Ur5rVs
 USxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QDHetqdY6gL2ut6w5hBOClKGYYflCOmIf2piJSnwVCA=;
 b=DmfF5PpsJFCWtTGrUhc+JWSHGFXWHth4oKWFG9tHSkV9l2ogURYXBVlg/lD6nxcNLx
 o64yBS3jgsnuG8QeuO1BwRiCpRvOVzNQDRqU1NaBMNWsYe2izlL7JvEybviKxE5MJ1NO
 3RSGR1GRkNvOjICeYPx9nrPpPynu4r76dVG6jkmbHuJlddi1EunsuiuAza4QFJRncGon
 W+pEsITgaIbfj0xZpJyvoUESSMOnyDBFM+0XNj58VIUyHWUIr8F+TkZG+G82bCfl1r++
 RcMHAniDByLjVoc+/p4DhGwfd/Drce220darAWU0BTZcQU7/SilmBtJ0f6S3hm00ijrR
 G1mA==
X-Gm-Message-State: AA+aEWYHeiaw8d67NkjpdF5xKEM8G5/pp7l2niL/YvIb5wte4a92Pgx0
 7K+xtxN+ltMNB4jgHZeWSJVEqw==
X-Google-Smtp-Source: AFSGD/WejKshiv7QsC3sfvDuJ4bXWRhcUsf+w02H/MBeBw9vTcjUTcFmTufFIMhbdN/iZ/cqlDZs1Q==
X-Received: by 2002:ac8:280f:: with SMTP id 15mr3909192qtq.31.1544222100055;
 Fri, 07 Dec 2018 14:35:00 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id v53sm2968757qtb.6.2018.12.07.14.34.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 14:34:59 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: catalin.marinas@arm.com,
	will.deacon@arm.com
Subject: [PATCH] arm64: increase stack size for KASAN_EXTRA
Date: Fri,  7 Dec 2018 17:34:49 -0500
Message-Id: <20181207223449.38808-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_143511_739799_05BBAC82 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: Qian Cai <cai@lca.pw>, arnd@arndb.de, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, glider@google.com,
 linux-arm-kernel@lists.infradead.org, aryabinin@virtuozzo.com,
 dvyukov@google.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If the kernel is configured with KASAN_EXTRA, the stack size is
increasted significantly due to enable this option will set
-fstack-reuse to "none" in GCC [1]. As the results, it could trigger
stack overrun quite often with 32k stack size compiled using GCC 8. For
example, this reproducer

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/\
syscalls/madvise/madvise06.c

could trigger a "corrupted stack end detected inside scheduler" very
reliably with CONFIG_SCHED_STACK_END_CHECK enabled. Also, See other bug
reports,

https://lore.kernel.org/lkml/1542144497.12945.29.camel@gmx.us/
https://lore.kernel.org/lkml/721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us/

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks. Some noticiable ones
are,

size
7536 shrink_inactive_list
7440 shrink_page_list
6560 fscache_stats_show
3920 jbd2_journal_commit_transaction
3216 try_to_unmap_one
3072 migrate_page_move_mapping
3584 migrate_misplaced_transhuge_page
3920 ip_vs_lblcr_schedule
4304 lpfc_nvme_info_show
3888 lpfc_debugfs_nvmestat_data.constprop

There are other 49 functions are over 2k in size while compiling kernel
with "-Wframe-larger-than=" on this machine. Hence, it is too much work
to change Makefiles for each object to compile without
-fsanitize-address-use-after-scope individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/memory.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..56562ff01076 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -76,12 +76,17 @@
 /*
  * KASAN requires 1/8th of the kernel virtual address space for the shadow
  * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * stack size when KASAN is in use, and then double it again if KASAN_EXTRA is
+ * on.
  */
 #ifdef CONFIG_KASAN
 #define KASAN_SHADOW_SCALE_SHIFT 3
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_THREAD_SHIFT	2
+#else
 #define KASAN_THREAD_SHIFT	1
+#endif /* CONFIG_KASAN_EXTRA */
 #else
 #define KASAN_SHADOW_SIZE	(0)
 #define KASAN_THREAD_SHIFT	0
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
