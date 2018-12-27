Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5097BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:48:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C902148D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e1XQJyB5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFNTkx4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C902148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LH9p7rf3qss9F9RBlTEhHZ/Vt+cNMOkyWupL2kAT6oo=; b=e1X
	QJyB5r9zAZ3mtGxWBAsazgUNTDn4EqLpf0c7lomcJ148V0FC705hzG370T2S9gKqZmNj1SBNkHhpy
	sqVd2gieK0fyhME1LS2Y22HOfmk99A96Q5qvJhErWZ7zkTut1aIZnUNj/vH/nCOIgA4sZMPBVCPV6
	AdudhB2gKUh6JEJhNJdqX6TKz2rkH6h/RPf+QVOARu3o0nrIKufQtpx1BN3Cfi29DqB2kOF6k6x3I
	B9abfg+sEj8DucRYGb4w+u+CmMGAjCHc11Z3hJH708seyZKblgz2P5RMy2pRT/mizWavMkGWzUcvT
	4uGX4PHbZdraE36WxlUd+viCezyneJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcfNs-0006Rn-SC; Thu, 27 Dec 2018 23:48:12 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcfNp-0006Pu-Qv
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 23:48:11 +0000
Received: by mail-pl1-x643.google.com with SMTP id a14so9292046plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=q2nJ9rfyypggwGRZ0F93ZauVq8Vari0uStE/oU9pY6s=;
 b=QFNTkx4TFLmeIKJblC3YN67IvstJInDThS2hmGCMZO1ketk5nOP8rCdoZq3NgCHIdb
 24/CDpxmU6MTkStMDpgcmP8XPoVnmkElu4KMmU3BDOd6Nxn0BXhvG0QPdoPcbcXzFQ21
 t+nfaksHzRwg5JhiLgvh7G6FX1qj1v1R2VaeqM/rVIS4uKfGaycVpjVQ/06BTHSWU3eB
 r07EU+Lf5w9EAx53nW4nRqv35UVh6vAVamDwoCVsvsf7TFnBlUXiBZh0BfEpCpZZ1spE
 7EoUhMk7PJE05WKDVHj+oUQDpRcwpyFvmPD/HiHOGVlrO6VW99sl41iXZO8y+CSbzmAX
 4uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=q2nJ9rfyypggwGRZ0F93ZauVq8Vari0uStE/oU9pY6s=;
 b=EazHyyzwEz+BY6rUwHZugJLa3Z+bJZScmYvVkiD0qrmU0O48IJZb05sZD2weW5XDcy
 a+EASqL2a+El1LyTV7b7lEGxInIAmplRPEHYlSy2LsJSY6J3bq4PpVfDvyG36uaYkk0/
 gNj+e0PEV41rUbJlnwf30icXyE5gAaSLGafZu5Sos7LnjtsaxUBw4Dji3PxiOFkL8Del
 5ZhTQvz7SwV39T7zzwMWVt6YMfBE9BxHO7DUiLOfMK7CXi4R67OR8Ra0Bjt7jjfBZzs1
 HWdVDWUPIB5LpCR4eB7WdQBeB3GSGi8nZ11Q5nDE5de2YVil9egwL5EI/rYvx72RIr1F
 nR/g==
X-Gm-Message-State: AJcUukfI50ALu/Gopadzv3FGX6G5k78ev2JAL72wuBrfGV83UjXZZZTI
 mjP9fAb3PqF/z+MuCyoGjDKmmfw6
X-Google-Smtp-Source: ALg8bN47/jxZO17cgPLQQSuAQ9rjaDbOV9Lq9vKY8gFaVkf2/1PNJy/xoWCJuIl0kSBeQH4kVaSpbg==
X-Received: by 2002:a17:902:2b84:: with SMTP id
 l4mr25578969plb.191.1545954476894; 
 Thu, 27 Dec 2018 15:47:56 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id l64sm48462219pge.73.2018.12.27.15.47.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 27 Dec 2018 15:47:56 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: mm: initialize pfn limits with find_limits()
Date: Thu, 27 Dec 2018 15:47:27 -0800
Message-Id: <1545954447-22513-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_154809_909008_43C4B240 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Michal Hocko <mhocko@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 Jinbum Park <jinb.park7@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Doug Berger <opendmb@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The max_low_pfn value must be set before sparse_init() is called to
keep the early memblock allocations and frees balanced for kmemleak
initialization when sparsemem is enabled.

This commit accomplishes that by replacing the local variables min,
max_low, and max_high with the global limit variables min_low_pfn,
max_low_pfn, and max_pfn respectively in bootmem_init(). The global
variables are initialized directly by find_limits() and used in the
remainder of the function.

Fixes: 9099daed9c69 ("mm: kmemleak: avoid using __va() on addresses that don't have a lowmem mapping")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 arch/arm/mm/init.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 32e4845af2b6..98a733f3a5b9 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -302,15 +302,12 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 
 void __init bootmem_init(void)
 {
-	unsigned long min, max_low, max_high;
-
 	memblock_allow_resize();
-	max_low = max_high = 0;
 
-	find_limits(&min, &max_low, &max_high);
+	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 
-	early_memtest((phys_addr_t)min << PAGE_SHIFT,
-		      (phys_addr_t)max_low << PAGE_SHIFT);
+	early_memtest((phys_addr_t)min_low_pfn << PAGE_SHIFT,
+		      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
 
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(),
@@ -328,16 +325,7 @@ void __init bootmem_init(void)
 	 * the sparse mem_map arrays initialized by sparse_init()
 	 * for memmap_init_zone(), otherwise all PFNs are invalid.
 	 */
-	zone_sizes_init(min, max_low, max_high);
-
-	/*
-	 * This doesn't seem to be used by the Linux memory manager any
-	 * more, but is used by ll_rw_block.  If we can get rid of it, we
-	 * also get rid of some of the stuff above as well.
-	 */
-	min_low_pfn = min;
-	max_low_pfn = max_low;
-	max_pfn = max_high;
+	zone_sizes_init(min_low_pfn, max_low_pfn, max_pfn);
 }
 
 /*
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
