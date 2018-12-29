Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488DAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:44:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9EE2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CexcNqZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9EE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0J3hJDx3C7k+0rfXPkIdMbgys2Y2zPqI65IpTz+qYJw=; b=CexcNqZdAIU3xI
	30UtY66xxQPHVOFwhGzkPEP1y9uvQxvaO8/AnNA6h1Ych7S/ADgYVXx8FI29qC4vpzvEoFYBb0i6n
	gfp037M+0tnoRwM2LUHVpwuZh/A/c0Z3GxWWYhog/E04pHuIsn9BbRK6Gkq+b20jgXsyi1rQMVN7S
	JaLHr6r33/L6Q/ORdIn64q6pZSGRNG6NDqw9WWE9lxQWwxWrCXrCSsODorcZ3yr2/JLP177uM6OdZ
	JtDvrSpUyPPHiQTE6isAbRvHJTWifvXoM8OjmBAMB2illrFqLf3Mz+Moys0lcNfjfbDEC0OlZn+gt
	Ct17z4BJrnhsOxzeqVTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd3fr-0000mT-S7; Sat, 29 Dec 2018 01:44:23 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd3fo-0000ki-Iq
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 01:44:22 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0A44E6C544E6F;
 Sat, 29 Dec 2018 09:44:00 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 29 Dec 2018 09:43:51 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: smp: Fix compilation error
Date: Sat, 29 Dec 2018 09:43:17 +0800
Message-ID: <1546047797-48275-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_174420_810314_C014F81D 
X-CRM114-Status: GOOD (  11.06  )
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For arm64: updates for 4.21, there is a compilation error:
arch/arm64/kernel/head.S: Assembler messages:
arch/arm64/kernel/head.S:824: Error: missing ')'
arch/arm64/kernel/head.S:824: Error: missing ')'
arch/arm64/kernel/head.S:824: Error: missing ')'
arch/arm64/kernel/head.S:824: Error: unexpected characters following instruction at operand 2 -- `mov x2,#(2)|(2U<<(8))'
scripts/Makefile.build:391: recipe for target 'arch/arm64/kernel/head.o' failed
make[1]: *** [arch/arm64/kernel/head.o] Error 1
GCC version is gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609

Let's fix it using the UL() macro.

Fixes: 66f16a24512f ("arm64: smp: Rework early feature mismatched detection")

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/include/asm/smp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 1895561839a9..99c9ed170072 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -25,12 +25,12 @@
 /* The cpu invoked ops->cpu_die, synchronise it with cpu_kill */
 #define CPU_KILL_ME			(1)
 /* The cpu couldn't die gracefully and is looping in the kernel */
-#define CPU_STUCK_IN_KERNEL		(2)
+#define CPU_STUCK_IN_KERNEL		UL(2)
 /* Fatal system error detected by secondary CPU, crash the system */
 #define CPU_PANIC_KERNEL		(3)
 
 #define CPU_STUCK_REASON_52_BIT_VA	(1U << CPU_STUCK_REASON_SHIFT)
-#define CPU_STUCK_REASON_NO_GRAN	(2U << CPU_STUCK_REASON_SHIFT)
+#define CPU_STUCK_REASON_NO_GRAN	(UL(2) << CPU_STUCK_REASON_SHIFT)
 
 #ifndef __ASSEMBLY__
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
