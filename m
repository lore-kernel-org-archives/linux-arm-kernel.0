Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC07C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AFF2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HcKJ/mE7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z1TFAWl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AFF2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y0ewLea6Jp9JcjURmJQuKgg0qXwMacqJ++e3VELX/yE=; b=HcKJ/mE7x30JWL
	nz2IsG4r3MG02gBfC7qyUNZMQxjkU2MxZTk5Gm88AVDErbSM43Yd52WLqNs35tWuEQFvJWzGkVwi7
	0VZt1ZhM9CQSEn0L4CNrIlwjssKnmlIcPn2QEo+qQfPPtaIHs4gq4maYnUlj0ZVuFd7cqf9FHkIXo
	WN1H6dM3ppQ/imxSZuM2PwUAj43bkXvgP7NIIvU9jORG2deA4G5NN7l8QWxZvaXN8JPeRQw4PSetj
	p1r7dfcvM2Un3NZwgIl0szkT5OBvE9wjYzvorXJ6m517S+Ks14fy8hdyhwulKlgDg33ZFBHTajxXP
	45XdHWH1EJMWUAcoUVTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz3g4-0006xy-3O; Wed, 27 Feb 2019 18:11:32 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz3fP-00063D-66
 for linux-arm-kernel@bombadil.infradead.org; Wed, 27 Feb 2019 18:10:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T6NiSwMMvhnoe2vgI+8wifL/HFKKnl7ekrNCMWErvF8=; b=Z1TFAWl1UVeDD2aOVzfdwLyCiN
 nSSc+elYtP6CoHB4VC81PBHztUKKmOXJLT69NQwq2Ub6FvdI1ZJEfKPwVn5GEUuq4Yb2DlsIG44jB
 NQm8b+VqC/cIKuWtKpB2XTYh2hDXDnUSFp/41RxFfyyOI4gapGYfN2cKDsqrHs1CqBv45GFtSFfG/
 ybNtOpHdLj21NOWogKxItyl1SJO3PSEP79kWXdBcD41s+skoPKBsVLmU1V79Bly1WrS8PEj7BLe97
 2Z8fuY5ufECWJ2IcpsMGjUDfQ0t6eIg5AKShIRi2RRRpGICCzHoq6F6yMz6aHzGydKr8N8UaTHoHv
 sltqs9EA==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2fx-0005Ts-Qi
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:07:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F2011684;
 Wed, 27 Feb 2019 09:07:21 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC793F738;
 Wed, 27 Feb 2019 09:07:17 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 14/34] openrisc: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:48 +0000
Message-Id: <20190227170608.27963-15-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_120721_980451_71E25118 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Stafford Horne <shorne@gmail.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Jonas Bonn <jonas@southpole.se>,
 x86@kernel.org, Steven Price <steven.price@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For openrisc, we don't support large pages, so add a stub returning 0.

CC: Jonas Bonn <jonas@southpole.se>
CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
CC: Stafford Horne <shorne@gmail.com>
CC: openrisc@lists.librecores.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/openrisc/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 21c71303012f..5a375104ef71 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -228,6 +228,7 @@ extern unsigned long empty_zero_page[2048];
 #define pmd_none(x)	(!pmd_val(x))
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK)) != _KERNPG_TABLE)
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define pmd_large(x)	(0)
 #define pmd_clear(xp)	do { pmd_val(*(xp)) = 0; } while (0)
 
 /*
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
